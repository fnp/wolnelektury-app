import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

class AppStorageLikesService {
  final AppStorage _storage;

  AppStorageLikesService(this._storage);

  Future<void> upsertMultipleLikes(
    List<({String slug, DateTime? timestamp})> likes,
  ) async {
    if (likes.isEmpty) return;

    final companions = likes.map((p) {
      return LikesCompanion(
        slug: Value(p.slug),
        updatedAt: Value(p.timestamp ?? DateTime.now()),
      );
    }).toList();

    await _storage.batch((batch) {
      batch.insertAllOnConflictUpdate(_storage.likes, companions);
    });
  }

  Future<List<String>> getLikes() async {
    final result = await (_storage.select(
      _storage.likes,
    )..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).get();

    return result.map((e) => e.slug).toList();
  }

  Future<bool> removeLike(String slug) async {
    final count = await (_storage.delete(
      _storage.likes,
    )..where((tbl) => tbl.slug.equals(slug))).go();

    return count > 0;
  }
}
