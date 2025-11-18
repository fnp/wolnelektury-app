import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_bookmarks_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/data/mixin/repository_helper_mixin.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

abstract class BookmarksRepository {
  Future<DataState<List<BookmarkModel>>> getBookmarks({
    int offset = 0,
    int limit = 20,
  });

  Future<DataState<BookmarkModel>> getBookmarkById({required String uuid});

  Future<DataState<List<BookmarkModel>>> getBookBookmarks({
    required String slug,
  });

  Future<DataState<BookmarkModel>> createTextBookmark({
    required String slug,
    required String anchor,
    String? note,
  });

  Future<DataState<BookmarkModel>> createAudioBookmark({
    required String slug,
    required int timestamp,
    String? note,
  });

  Future<DataState<void>> updateBookmark({
    required BookmarkModel updatedBookmark,
  });

  Future<DataState<void>> deleteBookmark({
    required String id,
    required String href,
    required String slug,
  });

  Future<DataState<void>> sendOutBookmarksSync();
  Future<DataState<void>> receiveInBookmarksSync();
}

class BookmarksRepositoryImplementation extends BookmarksRepository
    with RepositoryHelperMixin {
  final ApiService _apiService;
  final AppStorageBookmarksService _bookmarksStorage;
  final AppStorageSyncService _syncStorage;
  BookmarksRepositoryImplementation(
    this._apiService,
    this._bookmarksStorage,
    this._syncStorage,
  );

  static const String _bookmarksEndpoint = '/bookmarks/';
  static const String _sendSyncBookmarksEndpoint = '/sync/bookmark/';
  static String _receiveSyncBookmarksEndpoint(String ts) =>
      '/sync/bookmark?ts=$ts';

  @override
  Future<DataState<BookmarkModel>> getBookmarkById({
    required String uuid,
  }) async {
    try {
      final response = await _apiService.getRequest(
        '$_bookmarksEndpoint/$uuid/',
        useCache: CacheEnum.use,
      );
      if (response.hasData) {
        return DataState.success(
          data: BookmarkModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<BookmarkModel>>> getBookmarks({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _bookmarksStorage.getBookmarks(
        offset: offset,
        limit: limit,
      );

      if (response.isEmpty) {
        return const DataState.failure(Failure.notFound());
      }

      final List<BookmarkModel> bookmarks = [];
      for (final e in response) {
        try {
          final model = BookmarkModel.fromJson(jsonDecode(e));
          bookmarks.add(model);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      return DataState.success(data: bookmarks);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<BookmarkModel>>> getBookBookmarks({
    required String slug,
  }) async {
    try {
      final response = await _bookmarksStorage.getBookBookmarks(slug);

      if (response.isEmpty) {
        return const DataState.failure(Failure.notFound());
      }

      final List<BookmarkModel> bookmarks = [];
      for (final e in response) {
        try {
          final model = BookmarkModel.fromJson(jsonDecode(e));
          bookmarks.add(model);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      return DataState.success(data: bookmarks);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> deleteBookmark({
    required String id,
    required String href,
    required String slug,
  }) async {
    try {
      await _bookmarksStorage.deleteBookmark(id, slug);
      if (tryOnline) {
        final dbResult = await _deleteBookmarkFromDb(href);
        if (dbResult.isSuccess) {
          await _syncStorage.updateSyncData(
            sentBookmarksSyncAt: DateTime.now(),
          );
        }
        return dbResult;
      }
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> updateBookmark({
    required BookmarkModel updatedBookmark,
  }) async {
    try {
      await _bookmarksStorage.upsertMultipleBookmarks([
        (
          id: updatedBookmark.location,
          slug: updatedBookmark.slug,
          bookmarkJson: jsonEncode(updatedBookmark.toJson()),
          timestamp: DateTime.now(),
          isDeleted: false,
        ),
      ]);

      if (tryOnline) {
        final dbResult = await _updateBookmarkInDb(
          updatedBookmark: updatedBookmark,
        );
        if (dbResult.isSuccess) {
          await _syncStorage.updateSyncData(
            sentBookmarksSyncAt: DateTime.now(),
          );
        }
        return dbResult;
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<BookmarkModel>> createTextBookmark({
    required String slug,
    required String anchor,
    String? note,
  }) async {
    try {
      final createdBookmark = BookmarkModel.withLocation(
        slug: slug,
        anchor: anchor,
        note: note ?? '',
      );

      Future<void> insertionFunction(BookmarkModel bookmark) async {
        await _bookmarksStorage.upsertMultipleBookmarks([
          (
            id: bookmark.location,
            slug: slug,
            bookmarkJson: jsonEncode(bookmark.toJson()),
            timestamp: DateTime.now(),
            isDeleted: false,
          ),
        ]);
      }

      // Is offline, just insert locally
      if (!tryOnline) {
        await insertionFunction(createdBookmark);
      }

      // Is online, insert locally remotely created bookmark, cuz it returns with info about progress.
      // Created text bookmark will have audio timestamp and vice versa.
      if (tryOnline) {
        final dbResult = await _createTextBookmarkInDb(
          slug: slug,
          anchor: anchor,
          note: note,
        );
        dbResult.handle(
          success: (data, _) async {
            await insertionFunction(data);
            await _syncStorage.updateSyncData(
              sentBookmarksSyncAt: DateTime.now(),
            );
          },
          failure: (_) {},
        );
        return dbResult;
      }

      return DataState.success(data: createdBookmark);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<BookmarkModel>> createAudioBookmark({
    required String slug,
    required int timestamp,
    String? note,
  }) async {
    try {
      final bookmark = BookmarkModel.withLocation(
        slug: slug,
        audioTimestamp: timestamp,
        note: note ?? '',
      );
      await _bookmarksStorage.upsertMultipleBookmarks([
        (
          id: bookmark.location,
          slug: slug,
          bookmarkJson: jsonEncode(bookmark.toJson()),
          timestamp: DateTime.now(),
          isDeleted: false,
        ),
      ]);

      if (tryOnline) {
        final dbResult = await _createAudioBookmarkInDb(
          slug: slug,
          timestamp: timestamp,
          note: note,
        );
        if (dbResult.isSuccess) {
          await _syncStorage.updateSyncData(
            sentBookmarksSyncAt: DateTime.now(),
          );
        }
        return dbResult;
      }

      return DataState.success(data: bookmark);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<BookmarkModel>> _createTextBookmarkInDb({
    required String slug,
    required String anchor,
    String? note,
  }) async {
    try {
      final response = await _apiService.postRequest(_bookmarksEndpoint, {
        'anchor': anchor,
        'book': slug,
        'note': note,
      });

      if ((response.data ?? []).isNotEmpty) {
        return DataState.success(
          data: BookmarkModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<BookmarkModel>> _createAudioBookmarkInDb({
    required String slug,
    required int timestamp,
    String? note,
  }) async {
    try {
      final response = await _apiService.postRequest(_bookmarksEndpoint, {
        'audio_timestamp': timestamp,
        'book': slug,
        'note': note,
      });

      if ((response.data ?? []).isNotEmpty) {
        return DataState.success(
          data: BookmarkModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<void>> _updateBookmarkInDb({
    required BookmarkModel updatedBookmark,
  }) async {
    try {
      final response = await _apiService
          .putRequest(updatedBookmark.href.removeApiUrl, {
            'note': updatedBookmark.note,
            'book': updatedBookmark.slug,
            'anchor': updatedBookmark.anchor,
            'audio_timestamp': updatedBookmark.audioTimestamp,
          });

      if (response.hasData) {
        return const DataState.success(data: null);
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  Future<DataState<void>> _deleteBookmarkFromDb(String href) async {
    try {
      await _apiService.deleteRequest(href.removeApiUrl);
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> sendOutBookmarksSync() async {
    try {
      final bookmarks = await _syncStorage.getBookmarksToSync();

      AppLogger.instance.d(
        'BookmarksRepository',
        'Sending number of sync bookmarks: ${bookmarks.length}',
      );

      // All is up to date
      if (bookmarks.isEmpty) {
        await _syncStorage.updateSyncData(sentBookmarksSyncAt: DateTime.now());
        return const DataState.success(data: null);
      }
      final response = await _apiService.postRequest(
        _sendSyncBookmarksEndpoint,
        bookmarks.map((e) {
          final model = BookmarkModel.fromJson(jsonDecode(e.bookmarkJson));
          return model.copyWith(
            timestamp: (e.updatedAt.millisecondsSinceEpoch) ~/ 1000,
          );
        }).toList(),
        contentType: Headers.jsonContentType,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      await Future.delayed(const Duration(milliseconds: 1));
      await _syncStorage.updateSyncData(sentBookmarksSyncAt: DateTime.now());
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> receiveInBookmarksSync() async {
    try {
      final syncData = await _syncStorage.getSyncData();
      final lastReceived = syncData.receivedBookmarksSyncAt;
      final lastReceivedTimestamp =
          ((lastReceived?.millisecondsSinceEpoch ?? 0) / 1000)
              .round()
              .toString();

      final response = await _apiService.getRequest(
        _receiveSyncBookmarksEndpoint(lastReceivedTimestamp),
        useCache: CacheEnum.ignore,
      );

      AppLogger.instance.d(
        'BookmarksRepository',
        'Received number of sync bookmarks: ${response.data?.length}',
      );

      // Simply nothing to sync
      if (!response.hasData) {
        await _syncStorage.updateSyncData(
          receivedBookmarksSyncAt: DateTime.now(),
        );
        return const DataState.failure(Failure.notFound());
      }

      final List<BookmarkModel> bookmarks = [];

      for (final e in response.data!) {
        try {
          final bookmarkModel = BookmarkModel.fromJson(e);
          bookmarks.add(bookmarkModel);
        } catch (_) {
          // Wrong JSON, skip
        }
      }

      await _bookmarksStorage.upsertMultipleBookmarks(
        bookmarks.mapIndexed((index, e) {
          final updatedAt = DateTime.fromMillisecondsSinceEpoch(
            // Null timestamp shouldn't ever happen, but just in case
            (e.timestamp ?? 0) * 1000,
          );
          return (
            slug: e.slug,
            id: e.location,
            bookmarkJson: jsonEncode(e.toJson()),
            isDeleted: e.isDeleted,
            timestamp: updatedAt,
          );
        }).toList(),
      );

      await _syncStorage.updateSyncData(
        receivedBookmarksSyncAt: DateTime.now(),
      );
      await _bookmarksStorage.clearDeleted();

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
