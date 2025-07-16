import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_likes_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

abstract class LikesRepository {
  Future<DataState<List<String>>> getFavourites();

  Future<DataState<void>> toggleFavourite({
    required String slug,
    required bool targetValue,
  });
}

class FavouritesRepositoryImplementation extends LikesRepository {
  final ApiService _apiService;
  final AppStorageLikesService _likesStorage;
  final AppStorageSyncService _syncStorage;

  FavouritesRepositoryImplementation(
    this._apiService,
    this._likesStorage,
    this._syncStorage,
  );

  static const String _likesEndpoint = '/my-likes/';

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
          (slug: slug, timestamp: DateTime.now()),
        ]);
      } else {
        final result = await _likesStorage.removeLike(slug);
        if (!result) {
          return const DataState.failure(Failure.notFound());
        }
      }

      final isConnected = get.get<ConnectivityCubit>().state.isConnected;
      final isLogged = get.get<AuthCubit>().state.isAuthenticated;

      if (isConnected && isLogged) {
        // Mark the sync date
        await _syncStorage.updateSyncData(sentLikesSyncAt: DateTime.now());
        await _setFavouriteInDb(slug: slug, targetValue: targetValue);
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
          '$_likesEndpoint/$slug/',
          null,
        );
        if (response.error != null) {
          return const DataState.failure(Failure.badResponse());
        }

        return const DataState.success(data: null);
      } else {
        final response = await _apiService.deleteRequest(
          '$_likesEndpoint/$slug/',
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
}
