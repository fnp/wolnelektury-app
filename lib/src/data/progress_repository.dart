import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/serializer/serializer.dart';

abstract class ProgressRepository {
  Future<DataState<List<ProgressModel>>> getProgresses({String? url});
  Future<DataState<TextProgressModel>> getTextProgressByBook({
    required String slug,
  });
  Future<DataState<AudioProgressModel>> getAudioProgressByBook({
    required String slug,
  });
  // Try to update offline book if exists or keep the data when user is not logged
  Future<DataState<TextProgressModel>> setTextProgress({
    required String slug,
    required int textAnchor,
  });
  // Try to update offline book if exists or keep the data when user is not logged
  Future<DataState<void>> setAudioProgress({
    required String slug,
    required int position,
  });
}

class ProgressRepositoryImplementation extends ProgressRepository {
  static const String progressEndpoint = '/progress/';
  static String progressByBookEndpoint(String slug) => '/progress/$slug/';
  static String progressTextEndpoint(String slug) => '/progress/$slug/text/';
  static String progressAudioEndpoint(String slug) => '/progress/$slug/audio/';

  final ApiService _apiService;

  ProgressRepositoryImplementation(this._apiService);

  @override
  Future<DataState<TextProgressModel>> getTextProgressByBook({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        progressByBookEndpoint(slug),
        useCache: CacheEnum.ignore,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return DataState.success(
        data: TextProgressModel.fromJson(response.data!.first),
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<List<ProgressModel>>> getProgresses({String? url}) async {
    try {
      final effectiveUrl = url ?? progressEndpoint;

      final response = await _apiService.getRequest(
        effectiveUrl,
        useCache: CacheEnum.ignore,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return DataState.fromApiResponse(
        response: response,
        converter: (data) {
          return serializer(data: data, serializer: ProgressModel.fromJson);
        },
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> setAudioProgress({
    required String slug,
    required int position,
  }) async {
    try {
      final response = await _apiService.putRequest(
        progressAudioEndpoint(slug),
        {'audio_timestamp': position},
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
  Future<DataState<TextProgressModel>> setTextProgress({
    required String slug,
    required int textAnchor,
  }) async {
    try {
      final response = await _apiService.putRequest(
        progressTextEndpoint(slug),
        {'text_anchor': textAnchor},
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return DataState.success(
        data: TextProgressModel.fromJson(response.data!.first),
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<AudioProgressModel>> getAudioProgressByBook({
    required String slug,
  }) async {
    try {
      final response = await _apiService.getRequest(
        progressAudioEndpoint(slug),
        useCache: CacheEnum.ignore,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return DataState.success(
        data: AudioProgressModel.fromJson(response.data!.first),
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
