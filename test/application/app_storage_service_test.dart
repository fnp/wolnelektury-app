import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';

void main() {
  late AppStorage appStorage;
  late AppStorageService appStorageService;

  setUp(() {
    appStorage = AppStorage.forTesting(NativeDatabase.memory());
    appStorageService = AppStorageService(appStorage);
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
