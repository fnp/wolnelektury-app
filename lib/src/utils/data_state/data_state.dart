import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/utils/failure/failure.dart';

export '../failure/failure.dart';

part 'data_state.freezed.dart';

@freezed
sealed class DataState<T> with _$DataState<T> {
  const factory DataState.success({
    required T data,
    ApiResponsePagination? pagination,
  }) = DataStateSuccess<T>;

  const factory DataState.failure(Failure failure) = DataStateFailure<T>;

  factory DataState.fromApiResponse({
    required ApiResponse response,
    required T Function(List<Map<String, dynamic>> data) converter,
  }) {
    if (response.hasError) {
      return const DataState.failure(Failure.badResponse());
    }

    if (response.hasData) {
      try {
        return DataState.success(
          data: converter(response.data!),
          pagination: response.paginationData,
        );
      } catch (e, stackTrace) {
        AppLogger.instance.e('DataState', 'fromApiResponse', e, stackTrace);
        return const DataState.failure(Failure.badResponse());
      }
    }

    return const DataState.failure(Failure.notFound());
  }
}

extension DataStateX<T> on DataState<T> {
  bool get isSuccess => this is DataStateSuccess<T>;

  void handle({
    required void Function(T data, ApiResponsePagination? pagination) success,
    required void Function(Failure failure) failure,
  }) {
    return switch (this) {
      DataStateSuccess<T>(:final data, :final pagination) => success(
        data,
        pagination,
      ),
      DataStateFailure<T>(failure: final failure0) => failure(failure0),
    };
  }

  void asyncHandle({
    required Future<void> Function(T data, ApiResponsePagination? pagination)
    success,
    required Future<void> Function(Failure failure) failure,
  }) async {
    return switch (this) {
      DataStateSuccess<T>(:final data, :final pagination) => await success(
        data,
        pagination,
      ),
      DataStateFailure<T>(failure: final failure0) => await failure(failure0),
    };
  }
}
