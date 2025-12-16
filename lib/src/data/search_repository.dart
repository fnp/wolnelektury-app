import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/generic_search_result_model.dart';
import 'package:wolnelektury/src/domain/hint_model.dart';
import 'package:wolnelektury/src/domain/text_search_result_model.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class SearchRepository {
  Future<DataState<List<HintModel>>> getSearchHints(String query);
  Future<DataState<List<BookModel>>> searchBooks({
    required String query,
    String? url,
  });
  Future<DataState<List<TextSearchResultModel>>> searchText({
    required String query,
    String? url,
  });
  Future<DataState<GenericSearchResultModel>> searchGeneric({
    required String query,
    String? url,
  });
}

class SearchRepositoryImplementation extends SearchRepository {
  final ApiService _apiService;
  SearchRepositoryImplementation(this._apiService);

  static String _searchHintsEndpoint(String query) => '/search/hint?q=$query';
  static String _searchBooksEndpoint(String query) => '/search/books?q=$query';
  static String _searchTextEndpoint(String query) => '/search/text?q=$query';
  static String _searchGenericEndpoint(String query) => '/search/?q=$query';

  @override
  Future<DataState<List<HintModel>>> getSearchHints(String query) async {
    try {
      final response = await _apiService.getRequest(
        _searchHintsEndpoint(query),
        isAnonymous: true,
      );
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: HintModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<BookModel>>> searchBooks({
    required String query,
    String? url,
  }) async {
    try {
      final response = await _apiService.getRequest(
        url ?? _searchBooksEndpoint(query),
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

  @override
  Future<DataState<List<TextSearchResultModel>>> searchText({
    required String query,
    String? url,
  }) async {
    try {
      final response = await _apiService.getRequest(
        url ?? _searchTextEndpoint(query),
        isAnonymous: true,
      );
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(
            data: data,
            serializer: TextSearchResultModel.fromJson,
          );
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<GenericSearchResultModel>> searchGeneric({
    required String query,
    String? url,
  }) async {
    try {
      final response = await _apiService.getRequest(
        url ?? _searchGenericEndpoint(query),
        isAnonymous: true,
      );
      if (response.hasData) {
        final parsed = GenericSearchResultModel.fromJson(response.data!.first);
        return DataState.success(data: parsed);
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
