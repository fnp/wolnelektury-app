part of 'progress_cubit.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<ProgressModel> progresses,
    @Default(ApiResponsePagination()) ApiResponsePagination pagination,
  }) = _ProgressState;
}
