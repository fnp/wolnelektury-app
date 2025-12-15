import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

class AppStorageBookmarksService {
  final AppStorage _storage;

  AppStorageBookmarksService(this._storage);

  Future<void> clear() async {
    final query = _storage.delete(_storage.bookmarks);
    await query.go();
  }

  Future<void> upsertMultipleBookmarks(
    List<
      ({
        String id,
        String slug,
        String? bookmarkJson,
        DateTime? timestamp,
        bool isDeleted,
      })
    >
    bookmarks,
  ) async {
    if (bookmarks.isEmpty) return;

    final companions = bookmarks.map((p) {
      return BookmarksCompanion(
        id: Value(p.id),
        slug: Value(p.slug),
        bookmarkJson: p.bookmarkJson != null
            ? Value(p.bookmarkJson!)
            : const Value(''),
        isDeleted: Value(p.isDeleted),
        updatedAt: Value(p.timestamp ?? DateTime.now()),
      );
    }).toList();

    await _storage.batch((batch) {
      batch.insertAllOnConflictUpdate(_storage.bookmarks, companions);
    });
  }

  Future<List<String>> getBookBookmarks(String slug) async {
    final result =
        await (_storage.select(_storage.bookmarks)
              ..where((tbl) => tbl.slug.equals(slug))
              ..where((tbl) => tbl.isDeleted.equals(false)))
            .get();

    return result.map((e) => e.bookmarkJson).toList();
  }

  Future<List<String>> getBookmarks({
    required int offset,
    required int limit,
  }) async {
    final result =
        await (_storage.select(_storage.bookmarks)
              ..limit(limit, offset: offset)
              ..where((tbl) => tbl.isDeleted.equals(false))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    print('here?');

    return result.map((e) => e.bookmarkJson).toList();
  }

  Future<bool> deleteBookmark(String id, String slug) async {
    upsertMultipleBookmarks([
      (
        id: id,
        slug: slug,
        bookmarkJson: null,
        timestamp: DateTime.now(),
        isDeleted: true,
      ),
    ]);

    return true;
  }

  Future<void> clearDeleted() async {
    final query = _storage.delete(_storage.bookmarks)
      ..where((tbl) => tbl.isDeleted.equals(true));

    await query.go();
  }
}
