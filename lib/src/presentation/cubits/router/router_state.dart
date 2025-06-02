part of 'router_cubit.dart';

@freezed
class RouterState with _$RouterState {
  const factory RouterState({
    required String location,
    required String previousLocation,
  }) = _RouterState;
}

extension RouterStateX on RouterState {
  bool get isMainPage => mainPathsOrder.contains(location);
  bool get isAccountPage => location == accountPageConfig.path;
}
