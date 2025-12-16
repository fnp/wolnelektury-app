import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

abstract class DonationRepository {
  Future<DataState<String>> getDonationToken();
}

class DonationRepositoryImplementation extends DonationRepository {
  final ApiService _apiService;

  DonationRepositoryImplementation(this._apiService);

  static const String _getDonationTokenEndpoint = '/session-transfer/';

  @override
  Future<DataState<String>> getDonationToken() async {
    try {
      final response = await _apiService.postRequest(
        _getDonationTokenEndpoint,
        isAnonymous: false,
        {},
      );
      if (response.hasData) {
        return DataState.success(data: response.data?.first['token'] as String);
      }
      return const DataState.failure(Failure.notFound());
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
