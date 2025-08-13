import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_settings_service.dart';
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

  Future<void> deleteAccount() async {
    emit(
      state.copyWith(isDeletingAccount: true, isDeletingAccountSuccess: null),
    );
    await Future.delayed(const Duration(seconds: 2));
    emit(
      state.copyWith(isDeletingAccount: false, isDeletingAccountSuccess: true),
    );
  }

  Future<void> changePassword(String newPassword) async {
    emit(
      state.copyWith(isChangingPassword: true, isChangingPasswordSuccess: null),
    );
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    emit(
      state.copyWith(
        isChangingPassword: false,
        isChangingPasswordSuccess: true,
      ),
    );
  }
}
