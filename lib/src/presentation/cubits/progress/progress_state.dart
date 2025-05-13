part of 'progress_cubit.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState({
    @Default(false) bool isLoading,
    @Default([]) List<ProgressModel> progresses,
  }) = _ProgressState;
}
