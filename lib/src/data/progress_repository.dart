import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

enum ProgressType { text, audio }

abstract class ProgressRepository {
  Future<DataState<List<ProgressModel>>> getProgresses({
    int offset = 0,
    int limit = 20,
  });

  Future<DataState<ProgressModel>> getProgressByBook({required String slug});

  Future<DataState<void>> setProgress({
    required String slug,
    required ProgressModel progress,
    required ProgressType type,
  });

  Future<DataState<void>> sendOutProgressSync();
  Future<DataState<void>> receiveInProgressSync();
}

class ProgressRepositoryImplementation extends ProgressRepository {
  static String progressTextEndpoint(String slug) => '/progress/$slug/text/';
  static String progressAudioEndpoint(String slug) => '/progress/$slug/audio/';
  static const String sendSyncProgressEndpoint = '/sync/';
  static String receiveSyncProgressEndpoint(String ts) => '/sync/?ts=$ts';

  final ApiService _apiService;
  final AppStorageService _appStorageService;

  ProgressRepositoryImplementation(this._apiService, this._appStorageService);

  @override
  Future<DataState<void>> receiveInProgressSync() async {
    try {
      final syncData = await _appStorageService.getSyncData();
      final lastReceived = syncData.receivedProgressSyncAt;

      AppLogger.instance.d(
        'ProgressRepository',
        'Asking for sync with last date $lastReceived',
      );

      final response = await _apiService.getRequest(
        receiveSyncProgressEndpoint(
          ((lastReceived?.millisecondsSinceEpoch ?? 0) / 1000)
              .round()
              .toString(),
        ),
        useCache: CacheEnum.ignore,
      );

      if (!response.hasData) {
        await _appStorageService.updateSyncData(
          receivedProgressSyncAt: DateTime.now(),
        );
        return const DataState.failure(Failure.notFound());
      }

      final progresses = response.data!.map((e) {
        return ProgressModel.fromJson(e['object']);
      }).toList();

      AppLogger.instance.d(
        'ProgressRepository',
        'Received number of progresses: ${progresses.length}',
      );

      await _appStorageService.upsertMultipleProgressData(
        progresses.mapIndexed((index, e) {
          final timestampInSeconds = response.data![index]['timestamp'] ?? 0;
          final updatedAt = DateTime.fromMillisecondsSinceEpoch(
            timestampInSeconds * 1000,
          );
          return (
            slug: e.slug,
            progressJson: jsonEncode(e.toJson()),
            timestamp: updatedAt,
          );
        }).toList(),
      );

      await _appStorageService.updateSyncData(
        receivedProgressSyncAt: DateTime.now(),
      );

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> sendOutProgressSync() async {
    try {
      final progresses = await _appStorageService.getProgressToSync();
      AppLogger.instance.d(
        'ProgressRepository',
        'Sending out number of progresses: ${progresses.length}',
      );

      // All is up to date
      if (progresses.isEmpty) {
        await _appStorageService.updateSyncData(
          sentProgressSyncAt: DateTime.now(),
        );
        return const DataState.success(data: null);
      }
      final response = await _apiService.postRequest(
        sendSyncProgressEndpoint,
        progresses.map((e) {
          final progress = ProgressModel.fromJson(jsonDecode(e.progressJson));
          return {
            'object': {
              'text_anchor': progress.textAnchor,
              'audio_timestamp': progress.audioTimestamp,
            },
            'id': e.slug,
            'type': 'progress',
            'timestamp': (e.updatedAt.millisecondsSinceEpoch / 1000).round(),
          };
        }).toList(),
        contentType: Headers.jsonContentType,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      await Future.delayed(const Duration(milliseconds: 1));
      await _appStorageService.updateSyncData(
        sentProgressSyncAt: DateTime.now(),
      );
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<ProgressModel>>> getProgresses({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _appStorageService.getProgresses(
        offset: offset,
        limit: limit,
      );

      if (response.isEmpty) {
        return const DataState.failure(Failure.notFound());
      }
      final progresses = response
          .map((e) => ProgressModel.fromJson(jsonDecode(e)))
          .toList();
      return DataState.success(data: progresses);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<ProgressModel>> getProgressByBook({
    required String slug,
  }) async {
    try {
      final response = await _appStorageService.getProgressBySlug(slug);
      if (response == null) {
        return const DataState.failure(Failure.notFound());
      }
      final progress = ProgressModel.fromJson(jsonDecode(response));
      return DataState.success(data: progress);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> setProgress({
    required String slug,
    required ProgressModel progress,
    required ProgressType type,
  }) async {
    try {
      await _appStorageService.upsertMultipleProgressData([
        (
          slug: slug,
          progressJson: jsonEncode(progress.toJson()),
          timestamp: null,
        ),
      ]);

      final connection = await Connectivity().checkConnectivity();
      final isLogged = get.get<AuthCubit>().state.isAuthenticated;
      final tryOnline = connection.first != ConnectivityResult.none;

      if (tryOnline && isLogged) {
        // Mark the sync date
        await _appStorageService.updateSyncData(
          sentProgressSyncAt: DateTime.now(),
        );
        switch (type) {
          case ProgressType.text:
            if (progress.textAnchor == null) break;
            return _setTextProgressInDb(
              slug: slug,
              textAnchor: progress.textAnchor!,
            );
          case ProgressType.audio:
            if (progress.audioTimestamp == null) break;
            return _setAudioProgressInDb(
              slug: slug,
              position: progress.audioTimestamp!,
            );
        }
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<void>> _setAudioProgressInDb({
    required String slug,
    required int position,
  }) async {
    try {
      final response = await _apiService.putRequest(
        progressAudioEndpoint(slug),
        {'audio_timestamp': position},
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<void>> _setTextProgressInDb({
    required String slug,
    required String textAnchor,
  }) async {
    try {
      final response = await _apiService.putRequest(
        progressTextEndpoint(slug),
        {'text_anchor': textAnchor},
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
