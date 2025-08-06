import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/hint_model.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class SearchRepository {
  Future<DataState<List<HintModel>>> getSearchHints(String query);
}

class SearchRepositoryImplementation extends SearchRepository {
  final ApiService _apiService;
  SearchRepositoryImplementation(this._apiService);

  static String _searchHintsEndpoint(String query) => '/search/hint?q=$query';

  @override
  Future<DataState<List<HintModel>>> getSearchHints(String query) async {
    try {
      final response = await _apiService.getRequest(
        _searchHintsEndpoint(query),
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
}
