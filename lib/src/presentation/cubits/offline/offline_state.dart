part of 'offline_cubit.dart';

@freezed
sealed class OfflineState with _$OfflineState {
  const factory OfflineState({
    @Default(false) bool isLoading,
    @Default([]) List<OfflineBookModel> audiobooks,
    @Default([]) List<OfflineBookModel> readers,
  }) = _OfflineState;
}
