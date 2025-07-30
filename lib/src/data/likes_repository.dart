import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_likes_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/data/mixin/repository_helper_mixin.dart';
import 'package:wolnelektury/src/domain/like_sync_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

abstract class LikesRepository {
  Future<DataState<List<String>>> getFavourites();

  Future<DataState<void>> toggleFavourite({
    required String slug,
    required bool targetValue,
  });

  Future<DataState<void>> sendOutLikesSync();
  Future<DataState<void>> receiveInLikesSync();
}

class FavouritesRepositoryImplementation extends LikesRepository
    with RepositoryHelperMixin {
  final ApiService _apiService;
  final AppStorageLikesService _likesStorage;
  final AppStorageSyncService _syncStorage;

  FavouritesRepositoryImplementation(
    this._apiService,
    this._likesStorage,
    this._syncStorage,
  );

  static const String likesEndpoint = '/like/';
  static const String sendSyncLikesEndpoint = '/sync/userlistitem/';
  static String receiveSyncLikesEndpoint(String ts) =>
      '/sync/userlistitem?favourites=true&ts=$ts';

  @override
  Future<DataState<List<String>>> getFavourites() async {
    try {
      final response = await _likesStorage.getLikes();
      return DataState.success(data: response);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> toggleFavourite({
    required String slug,
    required bool targetValue,
  }) async {
    try {
      if (targetValue) {
        await _likesStorage.upsertMultipleLikes([
          (slug: slug, isLiked: targetValue, timestamp: DateTime.now()),
        ]);
      } else {
        final result = await _likesStorage.removeLike(slug);
        if (!result) {
          return const DataState.failure(Failure.notFound());
        }
      }

      if (tryOnline) {
        final dbResult = await _setFavouriteInDb(
          slug: slug,
          targetValue: targetValue,
        );
        if (dbResult.isSuccess) {
          await _syncStorage.updateSyncData(sentLikesSyncAt: DateTime.now());
        }
        return dbResult;
      }
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<void>> _setFavouriteInDb({
    required String slug,
    required bool targetValue,
  }) async {
    try {
      if (targetValue) {
        final response = await _apiService.putRequest(
          '$likesEndpoint/$slug/',
          null,
        );

        if (response.error != null) {
          return const DataState.failure(Failure.badResponse());
        }

        return const DataState.success(data: null);
      } else {
        final response = await _apiService.deleteRequest(
          '$likesEndpoint/$slug/',
        );

        if (response.error != null) {
          return const DataState.failure(Failure.badResponse());
        }
        return const DataState.success(data: null);
      }
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> sendOutLikesSync() async {
    try {
      final likes = await _syncStorage.getLikesToSync();
      AppLogger.instance.d(
        'LikesRepository',
        'Sending out number of likes: ${likes.length}',
      );

      // All is up to date
      if (likes.isEmpty) {
        await _syncStorage.updateSyncData(sentLikesSyncAt: DateTime.now());
        return const DataState.success(data: null);
      }

      final response = await _apiService.postRequest(
        sendSyncLikesEndpoint,
        likes.map((e) {
          final model = LikeSyncModel.fromLike(like: e);
          return model.toJson();
        }).toList(),
        contentType: Headers.jsonContentType,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      await Future.delayed(const Duration(milliseconds: 1));
      await _syncStorage.updateSyncData(sentLikesSyncAt: DateTime.now());
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> receiveInLikesSync() async {
    try {
      final syncData = await _syncStorage.getSyncData();
      final lastReceived = syncData.receivedLikesSyncAt;
      final lastReceivedTimestamp =
          ((lastReceived?.millisecondsSinceEpoch ?? 0) / 1000)
              .round()
              .toString();

      AppLogger.instance.d(
        'LikesRepository',
        'Asking for sync with last date $lastReceived',
      );

      final response = await _apiService.getRequest(
        receiveSyncLikesEndpoint(lastReceivedTimestamp),
        useCache: CacheEnum.ignore,
      );

      // Simply nothing to sync
      if (!response.hasData) {
        await _syncStorage.updateSyncData(
          receivedProgressSyncAt: DateTime.now(),
        );
        return const DataState.failure(Failure.notFound());
      }

      final List<LikeSyncModel> likes = [];

      for (final e in response.data!) {
        try {
          final syncModel = LikeSyncModel.fromJson(e);
          likes.add(syncModel);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      await _likesStorage.upsertMultipleLikes(
        likes.mapIndexed((index, e) {
          final updatedAt = DateTime.fromMillisecondsSinceEpoch(
            // Null timestamp shouldn't ever happen, but just in case
            (e.timestamp ?? 0) * 1000,
          );
          return (
            slug: e.slug,
            isLiked: e.deleted != true,
            timestamp: updatedAt,
          );
        }).toList(),
      );

      await _syncStorage.updateSyncData(receivedLikesSyncAt: DateTime.now());
      await _likesStorage.clearUnliked();

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
