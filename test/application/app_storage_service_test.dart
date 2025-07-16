import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_settings_service.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';

void main() {
  late AppStorage appStorage;
  late AppStorageSettingsService appStorageService;

  setUp(() {
    appStorage = AppStorage.forTesting(NativeDatabase.memory());
    appStorageService = AppStorageSettingsService(appStorage);
  });

  tearDown(() async {
    await appStorage.close();
  });

  group('AppStorageService tests', () {
    test('ReadAppSettings returns the default settings', () async {
      final result = await appStorageService.readAppSettings();
      expect(result.theme, equals(AppTheme.adaptive.name));
    });

    test('SetTheme correctly updates the theme', () async {
      const updatedTheme = AppTheme.light;
      final result = await appStorageService.setTheme(updatedTheme);
      expect(result.theme, equals(updatedTheme.name));
    });
  });
}
