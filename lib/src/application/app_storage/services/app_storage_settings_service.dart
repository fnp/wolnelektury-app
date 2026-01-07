import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/enums/app_theme_enum.dart';
import 'package:wolnelektury/src/enums/reader_font_type.dart';

class AppStorageSettingsService {
  static const int appSettingsId = 1;
  final AppStorage _storage;

  AppStorageSettingsService(this._storage);

  // Reader settings
  // ------------------------------------------------
  Future<ReaderSetting> readReadingSettings() async => _getReaderSettings();

  Future<ReaderSetting> setReadingSettings({
    required double textSizeFactor,
    required ReaderFontType fontType,
  }) async {
    final currentSettings = await _getReaderSettings();

    if (currentSettings.readingFontSize == textSizeFactor &&
        currentSettings.readingFontType == fontType.name) {
      return currentSettings;
    }

    await _storage
        .update(_storage.readerSettings)
        .replace(
          ReaderSettingsCompanion.insert(
            id: const Value(appSettingsId),
            readingFontSize: Value(textSizeFactor),
            readingFontType: Value(fontType.name),
          ),
        );

    return _getReaderSettings();
  }

  Future<ReaderSetting> _getReaderSettings() async {
    // Get current settings
    final result = await _storage
        .select(_storage.readerSettings)
        .getSingleOrNull();

    // If settings are not found, insert the default settings
    if (result == null) {
      await _storage
          .into(_storage.readerSettings)
          .insert(
            ReaderSettingsCompanion.insert(
              id: const Value(appSettingsId),
              readingFontSize: const Value(0.5),
              readingFontType: Value(ReaderFontType.sans.name),
            ),
          );
    }

    // Return the settings
    return _storage.select(_storage.readerSettings).getSingle();
  }
  // ------------------------------------------------

  // App settings
  // ------------------------------------------------
  Future<AppSetting> readAppSettings() async => _getAppSettings();

  Future<AppSetting> setTheme(AppTheme theme) async {
    // Checks if the theme is already set
    // And sets the theme to default if it's not
    final currentSettings = await _getAppSettings();

    if (currentSettings.theme == theme.name) {
      return currentSettings;
    }

    await _storage
        .update(_storage.appSettings)
        .replace(
          AppSettingsCompanion.insert(
            id: const Value(appSettingsId),
            theme: Value(theme.name),
          ),
        );

    return _getAppSettings();
  }

  Future<AppSetting> _getAppSettings() async {
    // Get current settings
    final result = await _storage
        .select(_storage.appSettings)
        .getSingleOrNull();

    // If settings are not found, insert the default settings
    if (result == null) {
      await _storage
          .into(_storage.appSettings)
          .insert(
            AppSettingsCompanion.insert(
              id: const Value(appSettingsId),
              theme: Value(AppTheme.adaptive.name),
            ),
          );
    }

    // Return the settings
    return _storage.select(_storage.appSettings).getSingle();
  }

  // ------------------------------------------------
}
