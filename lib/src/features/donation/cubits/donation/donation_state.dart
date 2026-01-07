part of 'donation_cubit.dart';

@freezed
sealed class DonationState with _$DonationState {
  const factory DonationState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
  }) = _DonationState;
}
