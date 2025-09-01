part of 'settings_cubit.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    AppSetting? settings,
    String? version,

    // Notifications, null means that the value is not fetched yet
    @Default(false) bool isLoadingNotifications,
    @Default(false) bool isSettingNotificationError,
    bool? notificationsEnabled,

    @Default(false) bool notificationsPermissionDenied,

    @Default(false) bool isChangingPassword,
    bool? isChangingPasswordSuccess,
    @Default(false) bool isDeletingAccount,
    bool? isDeletingAccountSuccess,
  }) = _SettingsState;
}

extension SettingsStateX on SettingsState {
  AppTheme get theme => getAppThemeByName(settings?.theme ?? '');
}
