import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/presentation/enums/sort_enum.dart';
import 'package:wolnelektury/src/utils/api/api_utils.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

abstract class BooksRepository {
  Future<DataState<List<BookModel>>> getBooks({
    required SortEnum sort,
    List<TagModel> tags = const <TagModel>[],
    String? url,
  });

  Future<DataState<void>> toggleFavourite({
    required String slug,
    required bool targetValue,
  });

  Future<DataState<Map<String, List<String>>>> getFavourites();

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

  Future<DataState<void>> deleteBookmark({
    required String href,
  });

  Future<DataState<ReaderBookModel>> getBookJson({
    required String slug,
  });
}

class BooksRepositoryImplementation extends BooksRepository {
  static const String _booksEndpoint = '/books';
  static const String _likeEndpoint = '/like';
  static const String _myLikesEndpoint = '/my-likes/';
  static const String _bookmarksEndpoint = '/bookmarks/';
  static const String _bookBookmarksEndpoint = '/bookmarks/book';

  final ApiService _apiService;
  BooksRepositoryImplementation(this._apiService);

  @override
  Future<DataState<void>> deleteBookmark({required String href}) async {
    try {
      await _apiService.deleteRequest(
        href.removeApiUrl,
      );

      return const DataState.success(null);
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
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
      final response = await _apiService.putRequest(
        href.removeApiUrl,
        {
          'note': note,
          'book': slug,
          'anchor': anchorId,
        },
      );

      if (response.hasData) {
        return DataState.success(
          BookmarkModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failed(
        Failure.notFound(),
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
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
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<BookmarkModel>> createBookmark({
    required String slug,
    required int anchorId,
    String? note,
  }) async {
    try {
      final response = await _apiService.postRequest(
        _bookmarksEndpoint,
        {
          'anchor': anchorId,
          'book': slug,
          'note': note,
        },
      );

      if ((response.data ?? []).isNotEmpty) {
        return DataState.success(
          BookmarkModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failed(
        Failure.notFound(),
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<ReaderBookModel>> getBookJson({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        '$_booksEndpoint/$slug.json',
      );

      if (response.hasData) {
        return DataState.success(
          ReaderBookModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failed(
        Failure.notFound(),
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<Map<String, List<String>>>> getFavourites() async {
    try {
      final response = await _apiService.getRequest(
        _myLikesEndpoint,
        useCache: CacheEnum.ignore,
      );

      if (response.hasData) {
        return DataState.success(
          response.data!.first.entries.fold<Map<String, List<String>>>(
            <String, List<String>>{},
            (acc, entry) {
              acc[entry.key] = List<String>.from(entry.value);
              return acc;
            },
          ),
        );
      }
      return const DataState.failed(
        Failure.notFound(),
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<void>> toggleFavourite({
    required String slug,
    required bool targetValue,
  }) async {
    try {
      if (targetValue) {
        final response = await _apiService.putRequest(
          '$_likeEndpoint/$slug/',
          null,
        );
        if (response.error != null) {
          return const DataState.failed(
            Failure.badResponse(),
          );
        }

        return const DataState.success(null);
      } else {
        final response = await _apiService.deleteRequest(
          '$_likeEndpoint/$slug/',
        );

        if (response.error != null) {
          return const DataState.failed(
            Failure.badResponse(),
          );
        }
        return const DataState.success(null);
      }
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<List<BookModel>>> getBooks({
    required SortEnum sort,
    List<TagModel> tags = const <TagModel>[],
    String? url,
  }) async {
    try {
      String effectiveUrl = ApiUtils.applySorting(
        sort: sort,
        apiUrl: url ?? _booksEndpoint,
      );
      effectiveUrl = ApiUtils.applyTags(
        tags: tags,
        apiUrl: effectiveUrl,
      );

      final response = await _apiService.getRequest(
        effectiveUrl,
        useCache: CacheEnum.ignore,
      );

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }
}
