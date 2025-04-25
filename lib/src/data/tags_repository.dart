import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/utils/api/api_utils.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class TagsRepository {
  Future<DataState<List<TagModel>>> getTags({
    List<TagModel> tags = const <TagModel>[],
    String? search,
    String? url,
  });
}

class TagsRepositoryImplementation extends TagsRepository {
  static const _tagsEndpoint = '/suggested-tags';
  final ApiService _apiService;
  TagsRepositoryImplementation(this._apiService);

  @override
  Future<DataState<List<TagModel>>> getTags({
    List<TagModel> tags = const <TagModel>[],
    String? search,
    String? url,
  }) async {
    try {
      String effectiveUrl = ApiUtils.applyTags(
        tags: tags,
        apiUrl: url ?? _tagsEndpoint,
      );
      effectiveUrl = ApiUtils.applySearch(
        apiUrl: effectiveUrl,
        search: search,
      );
      final response = await _apiService.getRequest(effectiveUrl);
      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: TagModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }
}
