import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_settings_service.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_service.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

class SettingsCubit extends SafeCubit<SettingsState> {
  final AppStorageSettingsService _settingsStorage;
  SettingsCubit(this._settingsStorage) : super(const SettingsState()) {
    _init();
  }

  Future<void> _init() async {
    final settings = await _settingsStorage.readAppSettings();
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(settings: settings, version: packageInfo.version));
  }

  Future<void> setTheme(AppTheme theme) async {
    final settings = await _settingsStorage.setTheme(theme);
    emit(state.copyWith(settings: settings));
  }
}
