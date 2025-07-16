import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_service.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';

class AppStorageOfflineService {
  final AppStorage _storage;

  AppStorageOfflineService(this._storage);

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

  Future<List<OfflineBookModel>> readAllOfflineBooks() async {
    final results = await _storage.select(_storage.offlineBooks).get();

    return results
        .map((result) {
          if (result.bookJson.isEmpty) {
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
        })
        .whereType<OfflineBookModel>()
        .toList();
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

  Future<bool> removeOfflineBook(String slug) async {
    final existingBook = await readOfflineBook(slug);
    if (existingBook == null) {
      return false; // Book not found
    }

    await (_storage.delete(
      _storage.offlineBooks,
    )..where((book) => book.slug.equals(slug))).go();
    return true;
  }
}
