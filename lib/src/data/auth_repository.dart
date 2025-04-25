import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/api_service.dart';
import 'package:wolnelektury/src/domain/register_agreement_model.dart';
import 'package:wolnelektury/src/domain/user_model.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

abstract class AuthRepository {
  Future<DataState<void>> login({
    required String username,
    required String password,
  });

  Future<DataState<void>> register({
    required String username,
    required String password,
    List<int> options = const [],
  });

  Future<DataState<UserModel>> getUser();

  Future<DataState<RegisterAgreementModel>> getRegisterAgreements();
}

class AuthRepositoryImplementation extends AuthRepository {
  final ApiService _apiService;
  AuthRepositoryImplementation(this._apiService);

  @override
  Future<DataState<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiService.postRequest('/login/', {
        'username': username,
        'password': password,
      });

      if (response.hasError || response.data?.isEmpty == true) {
        return const DataState.failed(Failure.badResponse());
      }

      final result = await _apiService.setTokens(response: response);

      if (!result) {
        return const DataState.failed(Failure.badResponse());
      }

      return const DataState.success(null);
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<void>> register({
    required String username,
    required String password,
    List<int> options = const [],
  }) async {
    try {
      final response = await _apiService.postRequest('/register/', {
        'email': username,
        'password': password,
        'options': options,
      });

      if (response.hasError) {
        return const DataState.failed(Failure.badResponse());
      }

      return const DataState.success(null);
    } catch (e) {
      return const DataState.failed(
        Failure.badResponse(),
      );
    }
  }

  @override
  Future<DataState<UserModel>> getUser() async {
    final response = await _apiService.getRequest(
      '/me',
      useCache: CacheEnum.ignore,
    );

    if (response.error != null) {
      return const DataState.failed(Failure.badResponse());
    }

    try {
      final user = UserModel.fromJson(response.data![0]);
      return DataState.success(user);
    } catch (e) {
      return const DataState.failed(Failure.badResponse());
    }
  }

  @override
  Future<DataState<RegisterAgreementModel>> getRegisterAgreements() async {
    final response = await _apiService.getRequest(
      '/register/',
    );

    if (response.error != null) {
      return const DataState.failed(Failure.badResponse());
    }

    try {
      final agreements = RegisterAgreementModel.fromJson(response.data![0]);
      return DataState.success(agreements);
    } catch (e) {
      return const DataState.failed(Failure.badResponse());
    }
  }
}
