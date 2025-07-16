import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_storage.g.dart';

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

  @override
  Set<Column> get primaryKey => {slug};
}

class Progresses extends Table {
  TextColumn get slug => text()();
  TextColumn get progressJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {slug};
}

class Likes extends Table {
  TextColumn get slug => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {slug};
}

class SyncInfo extends Table {
  IntColumn get id => integer().autoIncrement()();
  //
  DateTimeColumn get receivedProgressSyncAt => dateTime().nullable()();
  DateTimeColumn get sentProgressSyncAt => dateTime().nullable()();
  //
  DateTimeColumn get receivedLikesSyncAt => dateTime().nullable()();
  DateTimeColumn get sentLikesSyncAt => dateTime().nullable()();
}

@DriftDatabase(
  tables: [
    AppSettings,
    AppCache,
    ReaderSettings,
    OfflineBooks,
    Progresses,
    SyncInfo,
    Likes,
  ],
)
class AppStorage extends _$AppStorage {
  AppStorage() : super(_openConnection());

  AppStorage.forTesting(super.e);

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_storage');
  }

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(offlineBooks);
      }
      if (from < 3) {
        await m.createTable(progresses);
        await m.createTable(syncInfo);
        await m.createIndex(
          Index(
            'progresses_updated_at_idx',
            'CREATE INDEX progresses_updated_at_idx ON progresses(updated_at)',
          ),
        );
      }
      if (from < 4) {
        await m.addColumn(syncInfo, syncInfo.sentLikesSyncAt);
        await m.addColumn(syncInfo, syncInfo.receivedLikesSyncAt);
        await m.createTable(likes);
        await m.createIndex(
          Index(
            'likes_updated_at_idx',
            'CREATE INDEX likes_updated_at_idx ON likes(updated_at)',
          ),
        );
      }
    },
    onCreate: (m) async {
      await m.createAll();
    },
  );
}
