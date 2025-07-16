import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

abstract class BookmarksRepository {
  Future<DataState<List<BookmarkModel>>> getBookmarks({String? url});

  Future<DataState<List<BookmarkModel>>> getBookBookmarks({
    required String slug,
  });

  Future<DataState<BookmarkModel>> createBookmark({
    required String slug,
    required int anchorId,
    String? note,
  });

  Future<DataState<BookmarkModel>> updateBookmark({
    required String href,
    required String slug,
    required int anchorId,
    String? note,
  });

  Future<DataState<void>> deleteBookmark({required String href});
}

class BookmarksRepositoryImplementation extends BookmarksRepository {
  final ApiService _apiService;
  BookmarksRepositoryImplementation(this._apiService);

  static const String _bookmarksEndpoint = '/bookmarks/';
  static const String _bookBookmarksEndpoint = '/bookmarks/book';

  @override
  Future<DataState<void>> deleteBookmark({required String href}) async {
    try {
      await _apiService.deleteRequest(href.removeApiUrl);

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<BookmarkModel>> updateBookmark({
    required String href,
    required String slug,
    required int anchorId,
    String? note,
  }) async {
    try {
      final response = await _apiService.putRequest(href.removeApiUrl, {
        'note': note,
        'book': slug,
        'anchor': anchorId,
      });

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
  Future<DataState<List<BookmarkModel>>> getBookBookmarks({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        '$_bookBookmarksEndpoint/$slug/',
        useCache: CacheEnum.ignore,
      );

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookmarkModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<BookmarkModel>> createBookmark({
    required String slug,
    required int anchorId,
    String? note,
  }) async {
    try {
      final response = await _apiService.postRequest(_bookmarksEndpoint, {
        'anchor': anchorId,
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

  @override
  Future<DataState<List<BookmarkModel>>> getBookmarks({String? url}) async {
    try {
      final effectiveUrl = url ?? _bookmarksEndpoint;
      final response = await _apiService.getRequest(
        effectiveUrl,
        useCache: CacheEnum.ignore,
      );
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookmarkModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
