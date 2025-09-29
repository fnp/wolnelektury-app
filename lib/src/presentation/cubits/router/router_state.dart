part of 'router_cubit.dart';

@freezed
sealed class RouterState with _$RouterState {
  const factory RouterState({
    required String location,
    required String previousLocation,
    @Default(MyLibraryEnum.audiobooks) MyLibraryEnum lastEnteredMyLibraryEnum,
  }) = _RouterState;
}

extension RouterStateX on RouterState {
  bool get isMainPage => mainPathsOrder.contains(location);
  bool get isSettingsPage => location == settingsPageConfig.path;
  bool get isMyLibraryPage => location == myLibraryPageConfig.path;
}
