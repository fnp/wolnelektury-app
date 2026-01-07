import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_offline_service.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/book_text_audio_sync_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/enums/sort_enum.dart';
import 'package:wolnelektury/src/utils/api/api_utils.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class BooksRepository {
  Future<DataState<List<BookModel>>> getBooks({
    required SortEnum sort,
    List<TagModel> tags = const <TagModel>[],
    String? url,
  });

  Future<DataState<ReaderBookModel>> getBookJson({
    required String slug,
    bool tryOffline = false,
  });

  Future<DataState<BookModel>> getBookBySlug({required String slug});

  Future<DataState<List<BookTextAudioSyncModel>>> getBookTextAudioSync({
    required String slug,
  });
}

class BooksRepositoryImplementation extends BooksRepository {
  static const String _booksEndpoint = '/books';
  static String _syncEndpoint(String slug) => '$_booksEndpoint/$slug/sync';

  final ApiService _apiService;
  final AppStorageOfflineService _offlineStorage;
  BooksRepositoryImplementation(this._apiService, this._offlineStorage);

  @override
  Future<DataState<List<BookTextAudioSyncModel>>> getBookTextAudioSync({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        _syncEndpoint(slug),
        isAnonymous: true,
      );
      if (response.hasData) {
        return DataState.fromApiResponse(
          response: response,
          converter: (data) {
            return serializer(
              data: data,
              serializer: BookTextAudioSyncModel.fromJson,
            );
          },
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<BookModel>> getBookBySlug({required String slug}) async {
    try {
      final response = await _apiService.getRequest(
        '$_booksEndpoint/$slug/',
        isAnonymous: true,
      );

      if (response.hasData) {
        return DataState.success(
          data: BookModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<ReaderBookModel>> getBookJson({
    required String slug,
    bool tryOffline = false,
  }) async {
    try {
      if (tryOffline) {
        final offlineBook = await _offlineStorage.readOfflineBook(slug);
        if (offlineBook?.reader != null) {
          final parsed = ReaderBookModel.fromJson(
            offlineBook!.reader!.toJson(),
          );
          return DataState.success(data: parsed);
        }
        return const DataState.failure(Failure.notFound());
      }

      final response = await _apiService.getRequest(
        '$_booksEndpoint/$slug.json',
        isAnonymous: true,
      );

      if (response.hasData) {
        return DataState.success(
          data: ReaderBookModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
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
      effectiveUrl = ApiUtils.applyTags(tags: tags, apiUrl: effectiveUrl);

      final response = await _apiService.getRequest(
        effectiveUrl,
        isAnonymous: true,
      );

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
