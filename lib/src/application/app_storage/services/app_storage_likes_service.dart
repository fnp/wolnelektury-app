import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

class AppStorageLikesService {
  final AppStorage _storage;

  AppStorageLikesService(this._storage);

  Future<void> upsertMultipleLikes(
    List<({String slug, bool isLiked, DateTime? timestamp})> likes,
  ) async {
    if (likes.isEmpty) return;

    final companions = likes.map((p) {
      return LikesCompanion(
        slug: Value(p.slug),
        isLiked: Value(p.isLiked),
        updatedAt: Value(p.timestamp ?? DateTime.now()),
      );
    }).toList();

    await _storage.batch((batch) {
      batch.insertAllOnConflictUpdate(_storage.likes, companions);
    });
  }

  Future<List<String>> getLikes() async {
    final result =
        await (_storage.select(_storage.likes)
              ..where((tbl) => tbl.isLiked.equals(true))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    return result.map((e) => e.slug).toList();
  }

  Future<bool> removeLike(String slug) async {
    await upsertMultipleLikes([
      (slug: slug, isLiked: false, timestamp: DateTime.now()),
    ]);

    return true;
  }

  Future<void> clearUnliked() async {
    final query = _storage.delete(_storage.likes)
      ..where((tbl) => tbl.isLiked.equals(false));

    await query.go();
  }
}
