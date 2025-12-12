import 'package:dio/dio.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/app_secure_storage_service.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_cache_service.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/cache_enum.dart';

class ApiService {
  final Dio _dio;
  final AppStorageCacheService _cacheStorage;
  ApiService(this._dio, this._cacheStorage);

  Future<ApiResponse> getRequest(
    String endpoint, {
    allowRetry = true,
    useCache = CacheEnum.use,
  }) async {
    if (useCache == CacheEnum.use) {
      final response = await _cacheStorage.readCache(endpoint);
      if (response != null && response.data != null) {
        final parsedResponse = _handleResponse(response);
        // If cache has data, return it
        // otherwise, make a request
        if (parsedResponse.hasData) return parsedResponse;
      }
    }

    final accessToken = await AppSecureStorageService().readAccessToken();

    try {
      final response = await _dio.get(
        endpoint,
        options: createOptions(accessToken: accessToken),
      );

      final parsedResponse = _handleResponse(response);
      if (useCache == CacheEnum.use) {
        // Save cache if response has data
        if (!parsedResponse.hasData) return parsedResponse;
        await _cacheStorage.saveCache(response);
      }

      return parsedResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Only retry once
        if (!allowRetry) return _dioExceptionHandler(e);

        final refreshSuccess = await _handleTokenRefresh();
        if (refreshSuccess) {
          return await getRequest(
            endpoint,
            // Disallow retrying, this is already a retry
            allowRetry: false,
          );
        } else {
          get.get<AuthCubit>().logout();
        }
      }
      return _dioExceptionHandler(e);
    }
  }

  ApiResponse _handleResponse(Response<dynamic> response) {
    if (response.data is Map && response.data['member'] != null) {
      return ApiResponse.fromApiServiceCollectionResponse(response);
    }
    return ApiResponse.fromApiServiceResponse(response);
  }

  Future<ApiResponse> postRequest(
    String endpoint,
    dynamic data, {
    String? contentType,
  }) async {
    final accessToken = await AppSecureStorageService().readAccessToken();
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: createOptions(
          accessToken: accessToken,
          contentType: contentType,
        ),
      );
      return ApiResponse.fromApiServiceResponse(response);
    } on DioException catch (e) {
      return _dioExceptionHandler(e);
    }
  }

  Future<ApiResponse> putRequest(String endpoint, dynamic data) async {
    try {
      final accessToken = await AppSecureStorageService().readAccessToken();
      final response = await _dio.put(
        endpoint,
        data: data,
        options: createOptions(accessToken: accessToken),
      );

      return ApiResponse.fromApiServiceResponse(response);
    } on DioException catch (e) {
      return _dioExceptionHandler(e);
    }
  }

  Future<ApiResponse> deleteRequest(String endpoint) async {
    try {
      final accessToken = await AppSecureStorageService().readAccessToken();
      final response = await _dio.delete(
        endpoint,
        options: createOptions(accessToken: accessToken),
      );

      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        return ApiResponse(statusCode: response.statusCode, data: null);
      } else {
        return ApiResponse(
          statusCode: response.statusCode,
          error: 'Error: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      return _dioExceptionHandler(e);
    }
  }

  Future<bool> _handleTokenRefresh() async {
    final refreshToken = await AppSecureStorageService().readRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    try {
      final response = await _dio.post(
        '/refreshToken',
        data: {'refresh_token': refreshToken},
      );

      final apiResponse = ApiResponse.fromApiServiceResponse(response);
      return await setTokens(response: apiResponse);
    } on DioException {
      return false;
    }
  }

  Future<bool> setTokens({required ApiResponse response}) async {
    final String? accessToken = response.data?[0]['access_token'] as String?;
    final String? refreshToken = response.data?[0]['refresh_token'] as String?;

    if (accessToken == null || refreshToken == null) {
      return false;
    }

    await AppSecureStorageService().writeTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    return true;
  }

  ApiResponse _dioExceptionHandler(DioException e) {
    if (e.response != null) {
      return ApiResponse(
        error: 'Error: ${e.response?.statusCode} - ${e.response?.data}',
        statusCode: e.response?.statusCode,
      );
    } else {
      return ApiResponse(error: 'Error: ${e.message}');
    }
  }

  Options? createOptions({String? accessToken, String? contentType}) {
    return accessToken != null
        ? Options(
            headers: {'Authorization': 'Token $accessToken'},
            receiveTimeout: const Duration(seconds: 10),
            contentType: contentType,
          )
        : null;
  }
}
