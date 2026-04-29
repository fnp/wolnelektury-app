import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class ListsRepository {
  // Create
  Future<DataState<String>> createList({
    required String listName,
    required List<ListItemModel> items,
  });
  Future<DataState<void>> addItemsToList({
    required String listSlug,
    required List<ListItemModel> items,
  });

  // Read
  Future<DataState<List<ListModel>>> getLists({String? url});
  Future<DataState<ListModel>> getListBySlug({required String slug});
  Future<DataState<List<ListItemModel>>> getListItems({
    required String listSlug,
    String? url,
  });
  Future<DataState<List<ListItemModel>>> getBookListMemberships({
    required String bookSlug,
  });

  // Update
  Future<DataState<void>> renameList({
    required String listSlug,
    required String newName,
  });

  // Delete
  Future<DataState<void>> deleteList({required String listSlug});
  Future<DataState<void>> deleteListItem({required String itemUuid});
  Future<DataState<void>> deleteListItems({required List<String> itemUuids});
}

class ListsRepositoryImplementation extends ListsRepository {
  final ApiService _apiService;
  ListsRepositoryImplementation(this._apiService);

  static const String _createListEndpoint = '/lists/';
  static String _manageListEndpoint(String listSlug) => '/lists/$listSlug/';
  static String _listItemsEndpoint(String listSlug) =>
      '/lists/$listSlug/items/';
  static String _manageListItemEndpoint(String itemUuid) =>
      '/list-items/$itemUuid/';
  static const String _manageListItemsBulkEndpoint = '/list-items/';
  static String _bookListMembershipsEndpoint(String bookSlug) =>
      '/list-items/book/$bookSlug/';

  @override
  Future<DataState<ListModel>> getListBySlug({required String slug}) async {
    try {
      final response = await _apiService.getRequest(
        _manageListEndpoint(slug),
        useCache: CacheEnum.ignore,
        isAnonymous: true,
      );

      if (!response.hasData) {
        return const DataState.failure(Failure.notFound());
      }

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return ListModel.fromJson(data.first);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> renameList({
    required String listSlug,
    required String newName,
  }) async {
    try {
      final response = await _apiService.patchRequest(
        _manageListEndpoint(listSlug),
        {'name': newName},
        isAnonymous: false,
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
  Future<DataState<void>> addItemsToList({
    required String listSlug,
    required List<ListItemModel> items,
  }) async {
    try {
      final itemsData = items.map((item) => item.toCleanJson()).toList();

      final response = await _apiService.postRequest(
        _listItemsEndpoint(listSlug),
        itemsData,
        isAnonymous: false,
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
    required List<ListItemModel> items,
  }) async {
    try {
      final itemsData = items.map((item) => item.toCleanJson()).toList();

      final response = await _apiService.postRequest(_createListEndpoint, {
        'name': listName,
        'items': itemsData,
      }, isAnonymous: false);

      if (response.hasError || !response.hasData) {
        return const DataState.failure(Failure.badResponse());
      }
      return DataState.success(data: response.data!.first['slug'] as String);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> deleteListItem({required String itemUuid}) async {
    try {
      final response = await _apiService.deleteRequest(
        _manageListItemEndpoint(itemUuid),
        isAnonymous: false,
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
  Future<DataState<void>> deleteListItems({
    required List<String> itemUuids,
  }) async {
    try {
      final response = await _apiService.deleteRequest(
        _manageListItemsBulkEndpoint,
        data: itemUuids,
        contentType: 'application/json',
        isAnonymous: false,
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
        isAnonymous: false,
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
  Future<DataState<List<ListItemModel>>> getListItems({
    required String listSlug,
    String? url,
  }) async {
    try {
      final response = await _apiService.getRequest(
        url ?? _listItemsEndpoint(listSlug),
        useCache: CacheEnum.ignore,
        isAnonymous: false,
      );

      if (!response.hasData) {
        return const DataState.failure(Failure.notFound());
      }
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: ListItemModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<ListModel>>> getLists({String? url}) async {
    try {
      final response = await _apiService.getRequest(
        url ?? _createListEndpoint,
        useCache: CacheEnum.ignore,
        isAnonymous: false,
      );
      if (!response.hasData) {
        return const DataState.failure(Failure.notFound());
      }
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: ListModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<ListItemModel>>> getBookListMemberships({
    required String bookSlug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        _bookListMembershipsEndpoint(bookSlug),
        useCache: CacheEnum.ignore,
        isAnonymous: false,
      );

      if (!response.hasData) {
        return const DataState.success(data: []);
      }

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: ListItemModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
