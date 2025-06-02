import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/utils/failure/failure.dart';

export '../failure/failure.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState<T> {
  const DataState._();

  const factory DataState.success(
    T data, {
    ApiResponsePagination? pagination,
  }) = _Success;

  const factory DataState.failed(Failure failure) = _Failed;

  factory DataState.fromApiResponse({
    required ApiResponse response,
    required T Function(List<Map<String, dynamic>> data) converter,
  }) {
    if (response.hasError) {
      return const DataState.failed(Failure.badResponse());
    }
    if (response.hasData) {
      try {
        return DataState.success(
          converter(response.data!),
          pagination: response.paginationData,
        );
      } catch (e) {
        AppLogger.instance.e('DataState', 'fromApiResponse', e);
      }
    }
    return const DataState.failed(Failure.notFound());
  }
}

extension DataStateX<T> on DataState<T> {
  bool get isSuccess => this is _Success<T>;
}
