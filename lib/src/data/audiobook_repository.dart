import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_offline_service.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class AudiobookRepository {
  Future<DataState<List<AudioBookPart>>> getAudiobook({
    required String slug,
    bool tryOffline = false,
  });
}

class AudiobookRepositoryImplementation extends AudiobookRepository {
  static String _audiobooksEndpoint(String slug) => '/books/$slug/media/mp3/';

  final ApiService _apiService;
  final AppStorageOfflineService _offlineStorage;

  AudiobookRepositoryImplementation(this._apiService, this._offlineStorage);

  @override
  Future<DataState<List<AudioBookPart>>> getAudiobook({
    required String slug,
    bool tryOffline = false,
  }) async {
    try {
      if (tryOffline) {
        final offlineBook = await _offlineStorage.readOfflineBook(slug);
        if (offlineBook?.audiobook != null) {
          return DataState.success(data: offlineBook!.audiobook!.parts);
        }
        return const DataState.failure(Failure.notFound());
      }

      final response = await _apiService.getRequest(_audiobooksEndpoint(slug));

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: AudioBookPart.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
