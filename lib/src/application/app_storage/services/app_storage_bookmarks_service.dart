import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

class AppStorageBookmarksService {
  final AppStorage _storage;

  AppStorageBookmarksService(this._storage);

  Future<void> upsertMultipleBookmarks(
    List<({String id, String slug, String progressJson, DateTime? timestamp})>
    bookmarks,
  ) async {
    if (bookmarks.isEmpty) return;

    final companions = bookmarks.map((p) {
      return BookmarksCompanion(
        id: Value(p.id),
        slug: Value(p.slug),
        progressJson: Value(p.progressJson),
        updatedAt: Value(p.timestamp ?? DateTime.now()),
      );
    }).toList();

    await _storage.batch((batch) {
      batch.insertAllOnConflictUpdate(_storage.bookmarks, companions);
    });
  }

  Future<List<String>> getBookBookmarks(String slug) async {
    final result = await (_storage.select(
      _storage.bookmarks,
    )..where((tbl) => tbl.slug.equals(slug))).get();

    return result.map((e) => e.progressJson).toList();
  }

  Future<List<String>> getBookmarks({
    required int offset,
    required int limit,
  }) async {
    final result =
        await (_storage.select(_storage.bookmarks)
              ..limit(limit, offset: offset)
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    return result.map((e) => e.progressJson).toList();
  }

  Future<bool> deleteBookmark(String id) async {
    final count = await (_storage.delete(
      _storage.bookmarks,
    )..where((tbl) => tbl.id.equals(id))).go();

    return count > 0;
  }
}
