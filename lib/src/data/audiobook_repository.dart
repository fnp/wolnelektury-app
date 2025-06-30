import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
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
  final AppStorageService _appStorageService;

  AudiobookRepositoryImplementation(this._apiService, this._appStorageService);

  @override
  Future<DataState<List<AudioBookPart>>> getAudiobook({
    required String slug,
    bool tryOffline = false,
  }) async {
    try {
      if (tryOffline) {
        final offlineBook = await _appStorageService.readOfflineBook(slug);
        if (offlineBook?.audiobook != null) {
          final parsed = AudiobookModel.fromJson(
            offlineBook!.audiobook!.toJson(),
          );
          return DataState.success(data: parsed.parts);
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
