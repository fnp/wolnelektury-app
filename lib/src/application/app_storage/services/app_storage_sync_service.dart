import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_settings_service.dart';

class AppStorageSyncService {
  final AppStorage _storage;
  AppStorageSyncService(this._storage);

  Future<SyncInfoData> getSyncData() async {
    final syncData = await _storage.select(_storage.syncInfo).getSingleOrNull();
    if (syncData == null) {
      await _storage
          .into(_storage.syncInfo)
          .insert(
            const SyncInfoCompanion(
              id: Value(AppStorageSettingsService.appSettingsId),
              receivedProgressSyncAt: Value(null),
              sentProgressSyncAt: Value(null),
              receivedLikesSyncAt: Value(null),
              sentLikesSyncAt: Value(null),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      return const SyncInfoData(
        id: AppStorageSettingsService.appSettingsId,
        receivedProgressSyncAt: null,
        sentProgressSyncAt: null,
        receivedLikesSyncAt: null,
        sentLikesSyncAt: null,
      );
    }
    return syncData;
  }

  Future<void> updateSyncData({
    DateTime? receivedProgressSyncAt,
    DateTime? sentProgressSyncAt,
    DateTime? receivedLikesSyncAt,
    DateTime? sentLikesSyncAt,
    DateTime? receivedBookmarksSyncAt,
    DateTime? sentBookmarksSyncAt,
  }) async {
    final syncData = await getSyncData();
    final updatedFields = SyncInfoCompanion(
      id: Value(syncData.id),
      receivedProgressSyncAt: receivedProgressSyncAt != null
          ? Value(receivedProgressSyncAt)
          : const Value.absent(),
      sentProgressSyncAt: sentProgressSyncAt != null
          ? Value(sentProgressSyncAt)
          : const Value.absent(),
      receivedLikesSyncAt: receivedLikesSyncAt != null
          ? Value(receivedLikesSyncAt)
          : const Value.absent(),
      sentLikesSyncAt: sentLikesSyncAt != null
          ? Value(sentLikesSyncAt)
          : const Value.absent(),
      receivedBookmarksSyncAt: receivedBookmarksSyncAt != null
          ? Value(receivedBookmarksSyncAt)
          : const Value.absent(),
      sentBookmarksSyncAt: sentBookmarksSyncAt != null
          ? Value(sentBookmarksSyncAt)
          : const Value.absent(),
    );

    await _storage.update(_storage.syncInfo).replace(updatedFields);
  }

  Future<List<ProgressesData>> getProgressToSync() async {
    final syncData = await getSyncData();

    final query = _storage.select(_storage.progresses)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);

    if (syncData.sentProgressSyncAt != null) {
      query.where(
        (tbl) => tbl.updatedAt.isBiggerThanValue(syncData.sentProgressSyncAt!),
      );
    }

    final result = await query.get();
    return result;
  }

  Future<List<Like>> getLikesToSync() async {
    final syncData = await getSyncData();

    final query = _storage.select(_storage.likes)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);

    if (syncData.sentLikesSyncAt != null) {
      query.where(
        (tbl) => tbl.updatedAt.isBiggerThanValue(syncData.sentLikesSyncAt!),
      );
    }

    final result = await query.get();
    return result;
  }

  Future<List<Bookmark>> getBookmarksToSync() async {
    final syncData = await getSyncData();

    final query = _storage.select(_storage.bookmarks)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);

    if (syncData.sentBookmarksSyncAt != null) {
      query.where(
        (tbl) => tbl.updatedAt.isBiggerThanValue(syncData.sentBookmarksSyncAt!),
      );
    }

    final result = await query.get();
    return result;
  }
}
