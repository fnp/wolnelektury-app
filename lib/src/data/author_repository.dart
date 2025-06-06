import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/utils/api/api_utils.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class AuthorRepository {
  Future<DataState<DetailedAuthorModel>> getAuthor({
    required String slug,
  });

  Future<DataState<List<BookModel>>> getAuthorsBooks({
    required int authorId,
    String? url,
  });

  Future<DataState<List<BookModel>>> getAuthorTranslations({
    required int authorId,
    String? url,
  });
}

class AuthorRepositoryImplementation extends AuthorRepository {
  final ApiService _apiService;
  AuthorRepositoryImplementation(this._apiService);

  static String _authorEndpoint(String slug) => '/authors/$slug/';
  static const String _booksEndpoint = '/books';
  static String _translationsEndpoint(String id) => '/books/?translator=$id';

  @override
  Future<DataState<DetailedAuthorModel>> getAuthor({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        _authorEndpoint(slug),
      );

      if (response.hasData) {
        return DataState.success(
          data: DetailedAuthorModel.fromJson(response.data!.first),
        );
      }
      return const DataState.failure(
        Failure.notFound(),
      );
    } catch (e) {
      return const DataState.failure(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<List<BookModel>>> getAuthorsBooks({
    required int authorId,
    String? url,
  }) async {
    try {
      String effectiveUrl = ApiUtils.applyTags(
        tags: [TagModel(id: authorId, category: '', name: '')],
        apiUrl: url ?? _booksEndpoint,
      );

      effectiveUrl = ApiUtils.applyLimit(
        apiUrl: effectiveUrl,
        limit: 6,
      );

      final response = await _apiService.getRequest(
        effectiveUrl,
      );

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<List<BookModel>>> getAuthorTranslations({
    required int authorId,
    String? url,
  }) async {
    try {
      String effectiveUrl = ApiUtils.applyLimit(
        apiUrl: url ?? _translationsEndpoint(authorId.toString()),
        limit: 6,
      );

      final response = await _apiService.getRequest(
        effectiveUrl,
      );

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(
        Failure.badResponse(),
      );
    }
  }
}
