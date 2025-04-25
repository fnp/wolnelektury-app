import 'package:get_it/get_it.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/config/dio.dart';

Future<void> initializeServices({
  required GetIt getIt,
}) async {
  // Preparation for the initialization of the services
  getIt.registerSingleton<AppStorage>(AppStorage());

  getIt.registerSingleton<AppStorageService>(
    AppStorageService(
      getIt.get(),
    ),
  );
  // Initialization of the services
  getIt.registerSingleton<ApiService>(
    ApiService(
      apiDio,
      getIt.get(),
    ),
  );
}
