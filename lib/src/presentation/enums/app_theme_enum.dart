enum AppTheme { light, dark, adaptive }

AppTheme getAppThemeByName(String name) {
  for (AppTheme theme in AppTheme.values) {
    if (theme.name == name) {
      return theme;
    }
  }
  return AppTheme.adaptive;
}
