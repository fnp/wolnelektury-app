import 'package:get_it/get_it.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_cache_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_offline_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_progresses_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_settings_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_sync_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_service.dart';
import 'package:wolnelektury/src/config/dio.dart';

Future<void> initializeServices({required GetIt getIt}) async {
  // Preparation for the initialization of the services
  getIt.registerSingleton<AppStorage>(AppStorage());

  final AppStorage appStorage = getIt.get<AppStorage>();
  getIt.registerSingleton<AppStorageSyncService>(
    AppStorageSyncService(appStorage),
  );
  getIt.registerSingleton<AppStorageProgressesService>(
    AppStorageProgressesService(appStorage),
  );
  getIt.registerSingleton<AppStorageCacheService>(
    AppStorageCacheService(appStorage),
  );
  getIt.registerSingleton<AppStorageOfflineService>(
    AppStorageOfflineService(appStorage),
  );
  getIt.registerSingleton<AppStorageSettingsService>(
    AppStorageSettingsService(appStorage),
  );

  // Initialization of the services
  getIt.registerSingleton<ApiService>(ApiService(apiDio, getIt.get()));
}
