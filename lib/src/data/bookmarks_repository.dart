import 'dart:convert';

import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_bookmarks_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
import 'package:wolnelektury/src/data/mixin/repository_helper_mixin.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

abstract class BookmarksRepository {
  Future<DataState<List<BookmarkModel>>> getBookmarks({
    int offset = 0,
    int limit = 20,
  });

  Future<DataState<List<BookmarkModel>>> getBookBookmarks({
    required String slug,
  });

  Future<DataState<BookmarkModel>> createBookmark({
    required String slug,
    required String anchor,
    String? note,
  });

  Future<DataState<void>> updateBookmark({
    required BookmarkModel updatedBookmark,
  });

  Future<DataState<void>> deleteBookmark({
    required String id,
    required String href,
  });
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
  }) async {
    try {
      await _bookmarksStorage.deleteBookmark(id);
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
          progressJson: jsonEncode(updatedBookmark.toJson()),
          timestamp: DateTime.now(),
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
  Future<DataState<BookmarkModel>> createBookmark({
    required String slug,
    required String anchor,
    String? note,
  }) async {
    try {
      final bookmark = BookmarkModel.withLocation(
        slug: slug,
        anchor: anchor,
        note: note ?? '',
      );
      await _bookmarksStorage.upsertMultipleBookmarks([
        (
          id: bookmark.location,
          slug: slug,
          progressJson: jsonEncode(bookmark.toJson()),
          timestamp: DateTime.now(),
        ),
      ]);

      if (tryOnline) {
        final dbResult = await _createBookmarkInDb(
          slug: slug,
          anchor: anchor,
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

  Future<DataState<BookmarkModel>> _createBookmarkInDb({
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

  Future<DataState<void>> _updateBookmarkInDb({
    required BookmarkModel updatedBookmark,
  }) async {
    try {
      final response = await _apiService
          .putRequest(updatedBookmark.href.removeApiUrl, {
            'note': updatedBookmark.note,
            'book': updatedBookmark.slug,
            'anchor': updatedBookmark.anchor,
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
}
