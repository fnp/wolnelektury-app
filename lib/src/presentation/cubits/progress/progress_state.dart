part of 'progress_cubit.dart';

@freezed
sealed class ProgressState with _$ProgressState {
  const factory ProgressState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<ProgressModel> progresses,
  }) = _ProgressState;
}
