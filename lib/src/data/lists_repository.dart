import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class ListsRepository {
  Future<DataState<String>> createList({
    required String listName,
    required List<String> bookSlugs,
  });

  Future<DataState<void>> deleteList({required String listSlug});

  Future<DataState<void>> deleteBookFromList({
    required String listSlug,
    required String bookSlug,
  });

  Future<DataState<void>> addBooksToList({
    required String listSlug,
    required List<String> bookSlugs,
  });

  Future<DataState<BookListModel>> getList({required String listSlug});

  Future<DataState<List<BookListModel>>> getLists({String? url});
}

class ListsRepositoryImplementation extends ListsRepository {
  final ApiService _apiService;
  ListsRepositoryImplementation(this._apiService);

  static const String _createListEndpoint = '/lists/';
  static String _manageListEndpoint(String listSlug) => '/lists/$listSlug/';
  static String _deleteBookFromListEndpoint({
    required String listSlug,
    required String bookSlug,
  }) {
    return '/lists/$listSlug/$bookSlug/';
  }

  @override
  Future<DataState<void>> addBooksToList({
    required String listSlug,
    required List<String> bookSlugs,
  }) async {
    try {
      final response = await _apiService.postRequest(
        _manageListEndpoint(listSlug),
        {'books': bookSlugs},
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<String>> createList({
    required String listName,
    required List<String> bookSlugs,
  }) async {
    try {
      final response = await _apiService.postRequest(_createListEndpoint, {
        'name': listName,
        'books': bookSlugs,
      });

      print(response);

      if (response.hasError || !response.hasData) {
        return const DataState.failure(Failure.badResponse());
      }
      return DataState.success(data: response.data!.first['slug'] as String);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> deleteBookFromList({
    required String listSlug,
    required String bookSlug,
  }) async {
    try {
      final response = await _apiService.deleteRequest(
        _deleteBookFromListEndpoint(listSlug: listSlug, bookSlug: bookSlug),
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> deleteList({required String listSlug}) async {
    try {
      final response = await _apiService.deleteRequest(
        _manageListEndpoint(listSlug),
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }
      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<BookListModel>> getList({required String listSlug}) async {
    try {
      final response = await _apiService.getRequest(
        _manageListEndpoint(listSlug),
        useCache: CacheEnum.ignore,
      );

      if (!response.hasData) {
        return const DataState.failure(Failure.notFound());
      }
      return DataState.success(
        data: BookListModel.fromJson(response.data!.first),
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<BookListModel>>> getLists({String? url}) async {
    try {
      final response = await _apiService.getRequest(
        url ?? _createListEndpoint,
        useCache: CacheEnum.ignore,
      );
      print('GetLists response: $response');
      if (!response.hasData) {
        return const DataState.failure(Failure.notFound());
      }
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: BookListModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
