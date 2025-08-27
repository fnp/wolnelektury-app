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

  Future<DataState<void>> changePassword({
    required String newPassword,
    required String oldPassword,
  });

  Future<DataState<void>> deleteAccount(String password);

  Future<DataState<bool>> getNotificationsSettings();
  Future<DataState<void>> setNotificationsSettings(bool enabled);
}

class AuthRepositoryImplementation extends AuthRepository {
  final ApiService _apiService;
  static const String _settingsEndpoint = '/settings/';
  static const String _deleteAccountEndpoint = '/deleteAccount/';
  static const String _changePasswordEndpoint = '/password/';
  static const String _loginEndpoint = '/login/';
  static const String _registerEndpoint = '/register/';

  AuthRepositoryImplementation(this._apiService);

  @override
  Future<DataState<void>> setNotificationsSettings(bool enabled) async {
    try {
      final response = await _apiService.putRequest(_settingsEndpoint, {
        'notifications': enabled,
      });

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<bool>> getNotificationsSettings() async {
    try {
      final response = await _apiService.getRequest(
        _settingsEndpoint,
        useCache: CacheEnum.ignore,
      );

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return DataState.success(
        data: response.data?.firstOrNull?['notifications'] ?? false,
      );
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> deleteAccount(String password) async {
    try {
      final response = await _apiService.postRequest(_deleteAccountEndpoint, {
        'password': password,
      });

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> changePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    try {
      final response = await _apiService.postRequest(_changePasswordEndpoint, {
        'new_password': newPassword,
        'old_password': oldPassword,
      });

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiService.postRequest(_loginEndpoint, {
        'username': username,
        'password': password,
      });

      if (response.hasError || response.data?.isEmpty == true) {
        return const DataState.failure(Failure.badResponse());
      }

      final result = await _apiService.setTokens(response: response);

      if (!result) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<void>> register({
    required String username,
    required String password,
    List<int> options = const [],
  }) async {
    try {
      final response = await _apiService.postRequest(_registerEndpoint, {
        'email': username,
        'password': password,
        'options': options,
      });

      if (response.hasError) {
        return const DataState.failure(Failure.badResponse());
      }

      return const DataState.success(data: null);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<UserModel>> getUser() async {
    final response = await _apiService.getRequest(
      '/me',
      useCache: CacheEnum.ignore,
    );

    if (response.error != null) {
      return const DataState.failure(Failure.badResponse());
    }

    try {
      final user = UserModel.fromJson(response.data!.first);
      return DataState.success(data: user);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }

  @override
  Future<DataState<RegisterAgreementModel>> getRegisterAgreements() async {
    final response = await _apiService.getRequest(_registerEndpoint);

    if (response.error != null) {
      return const DataState.failure(Failure.badResponse());
    }

    try {
      final agreements = RegisterAgreementModel.fromJson(response.data!.first);
      return DataState.success(data: agreements);
    } catch (e) {
      return const DataState.failure(Failure.badResponse());
    }
  }
}
