part of 'connectivity_cubit.dart';

@freezed
sealed class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({
    ConnectivityResult? result,
    @Default(false) bool showAlert,
    @Default(false) bool disableNavigation,
  }) = _ConnectivityState;
}

extension ConnectivityStateX on ConnectivityState {
  bool get isConnected => result != ConnectivityResult.none;
}
