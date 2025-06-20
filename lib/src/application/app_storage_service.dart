import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';

part 'app_storage_service.g.dart';

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get theme => text().withDefault(const Constant('adaptive'))();
}

class ReaderSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get readingFontSize => real().withDefault(const Constant(0.5))();
  TextColumn get readingFontType =>
      text().withDefault(const Constant('sans'))();
}

class AppCache extends Table {
  TextColumn get callKey => text().customConstraint('NOT NULL UNIQUE')();
  TextColumn get response => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class OfflineBooks extends Table {
  TextColumn get slug => text().customConstraint('NOT NULL UNIQUE')();
  // Stringified JSON of OfflineBookModel
  TextColumn get bookJson => text().withDefault(const Constant(''))();
}

@DriftDatabase(tables: [AppSettings, AppCache, ReaderSettings, OfflineBooks])
class AppStorage extends _$AppStorage {
  AppStorage() : super(_openConnection());

  AppStorage.forTesting(super.e);

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_storage');
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from == 1 && to == 2) {
        await m.createTable(offlineBooks);
      }
    },
    onCreate: (m) async {
      await m.createAll();
    },
  );
}

class AppStorageService {
  static const int appSettingsId = 1;
  static const Duration cacheValidity = Duration(days: 7);
  final AppStorage _storage;

  AppStorageService(this._storage);

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

  // App Cache
  // ------------------------------------------------
  String _createCallKey(RequestOptions options) {
    // For now path, maybe some more parameters here
    return options.path;
  }

  Future<void> saveCache(Response<dynamic> response) async {
    AppLogger.instance.d(
      'AppStorageService',
      'Saving cache for call for:',
      response.requestOptions.path,
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
      'Retrieving cache for call to',
      callKey,
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

  // ------------------------------------------------

  // Offline Books
  // ------------------------------------------------

  Future<bool> saveOfflineBook(String slug, OfflineBookModel book) async {
    final bookJson = jsonEncode(book.toJson());
    final existingBook = await readOfflineBook(slug);

    if (existingBook != null) {
      // Update existing book
      await _storage
          .update(_storage.offlineBooks)
          .replace(
            OfflineBooksCompanion(slug: Value(slug), bookJson: Value(bookJson)),
          );
      return true;
    } else {
      // Insert new book
      await _storage
          .into(_storage.offlineBooks)
          .insert(
            OfflineBooksCompanion.insert(slug: slug, bookJson: Value(bookJson)),
          );
      return true;
    }
  }

  Future<OfflineBookModel?> readOfflineBook(String slug) async {
    final result = await (_storage.select(
      _storage.offlineBooks,
    )..where((book) => book.slug.equals(slug))).getSingleOrNull();

    if (result == null || result.bookJson.isEmpty) {
      return null;
    }

    try {
      return OfflineBookModel.fromJson(jsonDecode(result.bookJson));
    } catch (e) {
      AppLogger.instance.e(
        'AppStorageService',
        'Error parsing offline book JSON: $e',
      );
      return null;
    }
  }
}
