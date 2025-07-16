import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

class AppStorageCacheService {
  static const Duration cacheValidity = Duration(days: 7);
  final AppStorage _storage;

  AppStorageCacheService(this._storage);

  String _createCallKey(RequestOptions options) {
    // For now path, maybe some more parameters here
    return options.path;
  }

  Future<void> saveCache(Response<dynamic> response) async {
    AppLogger.instance.d(
      'AppStorageService',
      'Saving cache for call for: ${response.requestOptions.path}',
    );
    final callKey = _createCallKey(response.requestOptions);
    final existingCacheForKey = await readCache(callKey);
    if (existingCacheForKey != null) {
      AppLogger.instance.d(
        'AppStorageService',
        'Cache already exists, deleting to overwrite',
      );
      await deleteCacheForKey(callKey);
    }
    try {
      await _storage
          .into(_storage.appCache)
          .insert(
            AppCacheCompanion.insert(
              callKey: callKey,
              response: jsonEncode(response.data),
            ),
          );
    } catch (e) {
      AppLogger.instance.e('AppStorageService', 'Error saving cache: $e');
    }
  }

  Future<Response<dynamic>?> readCache(String callKey) async {
    AppLogger.instance.d(
      'AppStorageService',
      'Retrieving cache for call to $callKey',
    );
    try {
      final result = await (_storage.select(
        _storage.appCache,
      )..where((cache) => cache.callKey.equals(callKey))).getSingleOrNull();

      if (result == null) {
        return null;
      }

      if (DateTime.now().difference(result.createdAt) > cacheValidity) {
        await deleteCacheForKey(callKey);
        return null;
      }

      return Response(
        requestOptions: RequestOptions(path: callKey),
        data: jsonDecode(result.response),
        statusCode: 200,
      );
    } catch (e) {
      AppLogger.instance.e('AppStorageService', 'Error reading cache: $e');
      return null;
    }
  }

  Future<void> deleteCacheForKey(String callKey) async {
    await (_storage.delete(
      _storage.appCache,
    )..where((cache) => cache.callKey.equals(callKey))).go();
  }
}
