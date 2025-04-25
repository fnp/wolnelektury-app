part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    AppSetting? settings,
  }) = _SettingsState;
}

extension SettingsStateX on SettingsState {
  AppTheme get theme => getAppThemeByName(settings?.theme ?? '');
}
