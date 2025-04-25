import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class AudiobookRepository {
  Future<DataState<List<AudioBookPart>>> getAudiobook({
    required String slug,
  });
}

class AudiobookRepositoryImplementation extends AudiobookRepository {
  static String _audiobooksEndpoint(String slug) => '/books/$slug/media/mp3/';

  final ApiService _apiService;

  AudiobookRepositoryImplementation(
    this._apiService,
  );

  @override
  Future<DataState<List<AudioBookPart>>> getAudiobook({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        _audiobooksEndpoint(slug),
      );

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: AudioBookPart.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }
}
