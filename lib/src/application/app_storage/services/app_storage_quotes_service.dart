import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';

class AppStorageQuotesService {
  final AppStorage _storage;

  AppStorageQuotesService(this._storage);

  Future<void> clear() async {
    final query = _storage.delete(_storage.quotes);
    await query.go();
  }

  Future<void> upsertMultipleQuotes(
    List<
      ({
        String id,
        String slug,
        String? quoteJson,
        DateTime? timestamp,
        bool isDeleted,
      })
    >
    quotes,
  ) async {
    if (quotes.isEmpty) return;

    final companions = quotes.map((p) {
      return QuotesCompanion(
        id: Value(p.id),
        slug: Value(p.slug),
        quoteJson: p.quoteJson != null ? Value(p.quoteJson!) : const Value(''),
        isDeleted: Value(p.isDeleted),
        updatedAt: Value(p.timestamp ?? DateTime.now()),
      );
    }).toList();

    await _storage.batch((batch) {
      batch.insertAllOnConflictUpdate(_storage.quotes, companions);
    });
  }

  Future<String?> getQuoteJson(String id) async {
    final row = await (_storage.select(
      _storage.quotes,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.quoteJson;
  }

  Future<List<String>> getBookQuotes(String slug) async {
    final result =
        await (_storage.select(_storage.quotes)
              ..where((tbl) => tbl.slug.equals(slug))
              ..where((tbl) => tbl.isDeleted.equals(false))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    return result.map((e) => e.quoteJson).toList();
  }

  Future<List<String>> getQuotes({
    required int offset,
    required int limit,
  }) async {
    final result =
        await (_storage.select(_storage.quotes)
              ..limit(limit, offset: offset)
              ..where((tbl) => tbl.isDeleted.equals(false))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();

    return result.map((e) => e.quoteJson).toList();
  }

  Future<bool> deleteQuote(String id) async {
    // Only flag the row, so its JSON stays available for syncing the deletion.
    await (_storage.update(
      _storage.quotes,
    )..where((tbl) => tbl.id.equals(id))).write(
      QuotesCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return true;
  }

  /// Swaps a locally generated id for the uuid assigned by the server,
  /// keeping the row's updatedAt so it isn't sent out again.
  Future<void> replaceId({
    required String oldId,
    required String newId,
    required String quoteJson,
  }) async {
    await _storage.transaction(() async {
      final old = await (_storage.select(
        _storage.quotes,
      )..where((tbl) => tbl.id.equals(oldId))).getSingleOrNull();
      if (old == null) return;

      await (_storage.delete(
        _storage.quotes,
      )..where((tbl) => tbl.id.equals(oldId))).go();
      await _storage
          .into(_storage.quotes)
          .insertOnConflictUpdate(
            QuotesCompanion(
              id: Value(newId),
              slug: Value(old.slug),
              quoteJson: Value(quoteJson),
              isDeleted: Value(old.isDeleted),
              updatedAt: Value(old.updatedAt),
            ),
          );
    });
  }

  /// Removes tombstones, optionally only the ones already sent to the server.
  Future<void> clearDeleted({DateTime? sentUntil}) async {
    final query = _storage.delete(_storage.quotes)
      ..where((tbl) => tbl.isDeleted.equals(true));
    if (sentUntil != null) {
      query.where((tbl) => tbl.updatedAt.isSmallerOrEqualValue(sentUntil));
    }

    await query.go();
  }
}
