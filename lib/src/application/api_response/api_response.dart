import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse({
    List<Map<String, dynamic>>? data,

    // Pagination info
    int? totalItems,
    @Default(ApiResponsePagination()) ApiResponsePagination paginationData,

    // Errors part
    String? error,
    int? statusCode,
  }) = _ApiResponse;

  factory ApiResponse.fromApiServiceResponse(
    Response<dynamic> response,
  ) {
    final convertedResponse = response.data is Map
        ? List<Map<String, dynamic>>.from([response.data])
        : List<Map<String, dynamic>>.from(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        data: convertedResponse,
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse(
        error: 'Error: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
  }

  factory ApiResponse.fromApiServiceCollectionResponse(
    Response<dynamic> response,
  ) {
    if (response.data['member'] == null) {
      return ApiResponse(
        data: [],
        totalItems: 0,
        paginationData: const ApiResponsePagination(),
        statusCode: response.statusCode,
        error: 'No data found',
      );
    }

    final convertedResponse = response.data['member'] is Map
        ? List<Map<String, dynamic>>.from([response.data['member']])
        : List<Map<String, dynamic>>.from(response.data['member']);

    final paginationData = ApiResponsePagination.fromJson(
      response.data['view'] ?? {},
    );

    final totalItems = response.data['totalItems'];

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        data: convertedResponse,
        totalItems: totalItems,
        paginationData: paginationData,
        statusCode: response.statusCode,
      );
    }

    return ApiResponse(
      error: 'Error: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }
}

@freezed
class ApiResponsePagination with _$ApiResponsePagination {
  const factory ApiResponsePagination({
    String? first,
    String? last,
    String? next,
    String? previous,
  }) = _ApiResponsePagination;

  factory ApiResponsePagination.fromJson(Map<String, dynamic> json) =>
      _$ApiResponsePaginationFromJson(json);
}

extension ApiResponseX on ApiResponse {
  bool get hasError => error != null;
  bool get hasData => data != null && data!.isNotEmpty;
}
