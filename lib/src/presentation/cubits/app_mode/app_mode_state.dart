part of 'app_mode_cubit.dart';

@freezed
sealed class AppModeState with _$AppModeState {
  const factory AppModeState({
    @Default(AppModeEnum.defaultMode) AppModeEnum mode,
  }) = _AppModeState;
}

extension AppModeStateX on AppModeState {
  bool get isListCreation => mode == AppModeEnum.listCreationMode;
  bool get isDefault => mode == AppModeEnum.defaultMode;
  bool get shouldShowBottomBar => mode != AppModeEnum.listCreationMode;
}
