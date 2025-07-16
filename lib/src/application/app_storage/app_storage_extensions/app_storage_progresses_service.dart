import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_service.dart';

class AppStorageProgressesService {
  final AppStorage _storage;

  AppStorageProgressesService(this._storage);

  Future<void> upsertMultipleProgressData(
    List<({String slug, String progressJson, DateTime? timestamp})> progresses,
  ) async {
    if (progresses.isEmpty) return;

    final companions = progresses.map((p) {
      return ProgressesCompanion(
        slug: Value(p.slug),
        progressJson: Value(p.progressJson),
        updatedAt: Value(p.timestamp ?? DateTime.now()),
      );
    }).toList();

    await _storage.batch((batch) {
      batch.insertAllOnConflictUpdate(_storage.progresses, companions);
    });
  }

  Future<String?> getProgressBySlug(String slug) async {
    final result = await (_storage.select(
      _storage.progresses,
    )..where((tbl) => tbl.slug.equals(slug))).getSingleOrNull();

    if (result == null || result.progressJson.isEmpty) {
      return null;
    }

    return result.progressJson;
  }

  Future<List<String>> getProgresses({
    required int offset,
    required int limit,
  }) async {
    final result =
        await (_storage.select(_storage.progresses)
              ..limit(limit, offset: offset)
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    return result.map((e) => e.progressJson).toList();
  }
}
