import 'dart:convert';

import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
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
    bool tryOnline = true,
  });
}

class ProgressRepositoryImplementation extends ProgressRepository {
  static String progressTextEndpoint(String slug) => '/progress/$slug/text/';
  static String progressAudioEndpoint(String slug) => '/progress/$slug/audio/';

  final ApiService _apiService;
  final AppStorageService _appStorageService;

  ProgressRepositoryImplementation(this._apiService, this._appStorageService);

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
    // Try online when internet is available and user is logged in.
    bool tryOnline = true,
  }) async {
    try {
      await _appStorageService.upsertMultipleProgressData([
        (
          slug: slug,
          progressJson: jsonEncode(
            progress.copyWith(updatedAt: DateTime.now()).toJson(),
          ),
          updatedAt: DateTime.now(),
        ),
      ]);

      if (tryOnline) {
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
