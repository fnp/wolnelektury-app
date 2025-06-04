part of 'settings_cubit.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    AppSetting? settings,
    String? version,
  }) = _SettingsState;
}

extension SettingsStateX on SettingsState {
  AppTheme get theme => getAppThemeByName(settings?.theme ?? '');
}
