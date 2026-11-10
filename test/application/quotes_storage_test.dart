import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_quotes_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';

void main() {
  group('Quotes migration v3 -> v4', () {
    late Directory tempDir;
    late File dbFile;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('quotes_migration');
      dbFile = File('${tempDir.path}/app_storage.sqlite');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test(
      'creates quotes table and sync columns, keeps existing data',
      () async {
        // Build a database in the current schema and then downgrade it to v3.
        final fresh = AppStorage.forTesting(NativeDatabase(dbFile));
        await AppStorageSyncService(fresh).updateSyncData(
          receivedBookmarksSyncAt: DateTime.fromMillisecondsSinceEpoch(5000),
        );
        await AppStorageQuotesService(fresh).clear();
        await fresh.close();

        // The setup downgrades the file to v3 right before drift checks the
        // version, so opening it runs the real v3 -> v4 upgrade.
        final migrated = AppStorage.forTesting(
          NativeDatabase(
            dbFile,
            setup: (raw) {
              raw.execute('DROP TABLE quotes');
              raw.execute(
                'ALTER TABLE sync_info DROP COLUMN received_quotes_sync_at',
              );
              raw.execute(
                'ALTER TABLE sync_info DROP COLUMN sent_quotes_sync_at',
              );
              raw.execute('PRAGMA user_version = 3');
            },
          ),
        );
        addTearDown(migrated.close);

        final syncData = await AppStorageSyncService(migrated).getSyncData();
        expect(syncData.receivedBookmarksSyncAt, isNotNull);
        expect(syncData.receivedQuotesSyncAt, isNull);
        expect(syncData.sentQuotesSyncAt, isNull);

        final quotes = AppStorageQuotesService(migrated);
        await quotes.upsertMultipleQuotes([
          (
            id: 'q1',
            slug: 'book',
            quoteJson: '{}',
            timestamp: DateTime.now(),
            isDeleted: false,
          ),
        ]);
        expect(await quotes.getBookQuotes('book'), ['{}']);
      },
    );
  });

  group('AppStorageQuotesService', () {
    late AppStorage storage;
    late AppStorageQuotesService quotes;
    late AppStorageSyncService sync;

    setUp(() {
      storage = AppStorage.forTesting(NativeDatabase.memory());
      quotes = AppStorageQuotesService(storage);
      sync = AppStorageSyncService(storage);
    });

    tearDown(() async {
      await storage.close();
    });

    ({
      String id,
      String slug,
      String? quoteJson,
      DateTime? timestamp,
      bool isDeleted,
    })
    row(String id, {String json = '{"a":1}', DateTime? at}) => (
      id: id,
      slug: 'book',
      quoteJson: json,
      timestamp: at,
      isDeleted: false,
    );

    test('deleteQuote flags the row and keeps its JSON', () async {
      await quotes.upsertMultipleQuotes([row('q1')]);
      await quotes.deleteQuote('q1');

      expect(await quotes.getBookQuotes('book'), isEmpty);
      final toSync = await sync.getQuotesToSync();
      expect(toSync.single.isDeleted, isTrue);
      expect(toSync.single.quoteJson, '{"a":1}');
    });

    test('replaceId swaps the id and keeps updatedAt', () async {
      final at = DateTime.fromMillisecondsSinceEpoch(1000000);
      await quotes.upsertMultipleQuotes([row('local-1', at: at)]);

      await quotes.replaceId(
        oldId: 'local-1',
        newId: 'server-uuid',
        quoteJson: '{"uuid":"server-uuid"}',
      );

      final all = await storage.select(storage.quotes).get();
      expect(all.single.id, 'server-uuid');
      expect(all.single.quoteJson, '{"uuid":"server-uuid"}');
      expect(all.single.updatedAt, at);
    });

    test(
      'getQuotesToSync returns only rows newer than last sent sync',
      () async {
        await quotes.upsertMultipleQuotes([
          row('old', at: DateTime.fromMillisecondsSinceEpoch(1000000)),
          row('new', at: DateTime.fromMillisecondsSinceEpoch(3000000)),
        ]);
        await sync.updateSyncData(
          sentQuotesSyncAt: DateTime.fromMillisecondsSinceEpoch(2000000),
        );

        final toSync = await sync.getQuotesToSync();
        expect(toSync.map((e) => e.id), ['new']);
      },
    );

    test('clearDeleted removes only deleted rows', () async {
      await quotes.upsertMultipleQuotes([row('a'), row('b')]);
      await quotes.deleteQuote('a');
      await quotes.clearDeleted();

      final all = await storage.select(storage.quotes).get();
      expect(all.map((e) => e.id), ['b']);
    });
  });
}
