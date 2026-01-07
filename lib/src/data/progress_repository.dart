import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_progresses_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/data/mixin/repository_helper_mixin.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/enums/cache_enum.dart';
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

class ProgressRepositoryImplementation extends ProgressRepository
    with RepositoryHelperMixin {
  static String _progressTextEndpoint(String slug) => '/progress/$slug/text/';
  static String _progressAudioEndpoint(String slug) => '/progress/$slug/audio/';
  static const String _sendSyncProgressEndpoint = '/sync/progress/';
  static String _receiveSyncProgressEndpoint(String ts) =>
      '/sync/progress?ts=$ts';

  final ApiService _apiService;
  final AppStorageSyncService _syncStorage;
  final AppStorageProgressesService _progressStorage;

  ProgressRepositoryImplementation(
    this._apiService,
    this._syncStorage,
    this._progressStorage,
  );

  @override
  Future<DataState<void>> receiveInProgressSync() async {
    try {
      final syncData = await _syncStorage.getSyncData();
      final lastReceived = syncData.receivedProgressSyncAt;
      final lastReceivedTimestamp =
          ((lastReceived?.millisecondsSinceEpoch ?? 0) / 1000)
              .round()
              .toString();

      final response = await _apiService.getRequest(
        _receiveSyncProgressEndpoint(lastReceivedTimestamp),
        useCache: CacheEnum.ignore,
        isAnonymous: false,
      );

      AppLogger.instance.d(
        'ProgressRepository',
        'Received number of sync progresses: ${response.data?.length}',
      );

      // Simply nothing to sync
      if (!response.hasData) {
        await _syncStorage.updateSyncData(
          receivedProgressSyncAt: DateTime.now(),
        );
        return const DataState.failure(Failure.notFound());
      }

      final List<ProgressModel> progresses = [];

      for (final e in response.data!) {
        try {
          final syncModel = ProgressModel.fromJson(e);
          progresses.add(syncModel);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      await _progressStorage.upsertMultipleProgressData(
        progresses.mapIndexed((index, e) {
          final updatedAt = DateTime.fromMillisecondsSinceEpoch(
            // Null timestamp shouldn't ever happen, but just in case
            (e.timestamp ?? 0) * 1000,
          );
          return (
            slug: e.slug,
            progressJson: jsonEncode(e.toJson()),
            timestamp: updatedAt,
          );
        }).toList(),
      );

      await _syncStorage.updateSyncData(receivedProgressSyncAt: DateTime.now());

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> sendOutProgressSync() async {
    try {
      final progresses = await _syncStorage.getProgressToSync();

      AppLogger.instance.d(
        'ProgressRepository',
        'Sending number of sync progresses: ${progresses.length}',
      );

      // All is up to date
      if (progresses.isEmpty) {
        await _syncStorage.updateSyncData(sentProgressSyncAt: DateTime.now());
        return const DataState.success(data: null);
      }
      final response = await _apiService.postRequest(
        _sendSyncProgressEndpoint,
        progresses.map((e) {
          final progress = ProgressModel.fromJson(jsonDecode(e.progressJson));
          return progress.copyWith(
            timestamp: (e.updatedAt.millisecondsSinceEpoch) ~/ 1000,
            textAnchor: progress.textAnchor ?? '',
          );
        }).toList(),
        contentType: Headers.jsonContentType,
        isAnonymous: false,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      await Future.delayed(const Duration(milliseconds: 1));
      await _syncStorage.updateSyncData(sentProgressSyncAt: DateTime.now());
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
      final response = await _progressStorage.getProgresses(
        offset: offset,
        limit: limit,
      );

      if (response.isEmpty) {
        return const DataState.failure(Failure.notFound());
      }

      final List<ProgressModel> progresses = [];
      for (final e in response) {
        try {
          final model = ProgressModel.fromJson(jsonDecode(e));
          progresses.add(model);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

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
      final response = await _progressStorage.getProgressBySlug(slug);
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
      await _progressStorage.upsertMultipleProgressData([
        (
          slug: slug,
          progressJson: jsonEncode(progress.toJson()),
          timestamp: null,
        ),
      ]);

      if (tryOnline) {
        DataState dbResult = const DataState.failure(Failure.notFound());
        switch (type) {
          case ProgressType.text:
            if (progress.textAnchor == null) break;
            dbResult = await _setTextProgressInDb(
              slug: slug,
              textAnchor: progress.textAnchor!,
            );
          case ProgressType.audio:
            if (progress.audioTimestamp == null) break;
            dbResult = await _setAudioProgressInDb(
              slug: slug,
              position: progress.audioTimestamp!,
            );
        }
        if (dbResult.isSuccess) {
          await _syncStorage.updateSyncData(sentProgressSyncAt: DateTime.now());
        }
        return dbResult;
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
        _progressAudioEndpoint(slug),
        {'audio_timestamp': position},
        isAnonymous: false,
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
        _progressTextEndpoint(slug),
        {'text_anchor': textAnchor},
        isAnonymous: false,
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
