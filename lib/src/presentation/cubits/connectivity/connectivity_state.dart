part of 'connectivity_cubit.dart';

@freezed
sealed class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({ConnectivityResult? result}) =
      _ConnectivityState;
}

extension ConnectivityStateX on ConnectivityState {
  bool get isConnected => result != ConnectivityResult.none;
}
