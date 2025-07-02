part of 'synchronizer_cubit.dart';

@freezed
sealed class SynchronizerState with _$SynchronizerState {
  const factory SynchronizerState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
  }) = _SynchronizerState;
}
