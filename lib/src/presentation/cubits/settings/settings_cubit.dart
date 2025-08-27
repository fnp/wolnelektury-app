import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_settings_service.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/data/auth_repository.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

class SettingsCubit extends SafeCubit<SettingsState> {
  final AppStorageSettingsService _settingsStorage;
  final AuthRepository _authRepository;
  SettingsCubit(this._settingsStorage, this._authRepository)
    : super(const SettingsState()) {
    _init();
  }

  Future<void> _loadNotificationSettings() async {
    emit(state.copyWith(isLoadingNotifications: true));
    final enabled = await _authRepository.getNotificationsSettings();
    enabled.handle(
      success: (d, __) {
        emit(
          state.copyWith(
            notificationsEnabled: d,
            isLoadingNotifications: false,
          ),
        );
      },
      failure: (f) {
        emit(
          state.copyWith(
            notificationsEnabled: false,
            isLoadingNotifications: false,
          ),
        );
      },
    );
  }

  Future<void> setNotificationsSettings(bool enabled) async {
    emit(state.copyWith(isSettingNotificationError: false));
    final bool previousValue = state.notificationsEnabled ?? false;
    emit(state.copyWith(notificationsEnabled: enabled));
    final result = await _authRepository.setNotificationsSettings(enabled);
    result.handle(
      success: (_, __) {},
      failure: (f) {
        emit(
          state.copyWith(
            notificationsEnabled: previousValue,
            isSettingNotificationError: true,
          ),
        );
      },
    );
  }

  Future<void> _init() async {
    final settings = await _settingsStorage.readAppSettings();
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(settings: settings, version: packageInfo.version));
    _loadNotificationSettings();
  }

  Future<void> setTheme(AppTheme theme) async {
    final settings = await _settingsStorage.setTheme(theme);
    emit(state.copyWith(settings: settings));
  }

  Future<void> deleteAccount(String password) async {
    emit(
      state.copyWith(isDeletingAccount: true, isDeletingAccountSuccess: null),
    );
    final result = await _authRepository.deleteAccount(password);
    result.handle(
      success: (_, _) {
        get.get<AuthCubit>().logout();
        emit(
          state.copyWith(
            isDeletingAccount: false,
            isDeletingAccountSuccess: true,
          ),
        );
      },
      failure: (f) {
        emit(
          state.copyWith(
            isDeletingAccount: false,
            isDeletingAccountSuccess: false,
          ),
        );
      },
    );
    emit(
      state.copyWith(isDeletingAccount: false, isDeletingAccountSuccess: false),
    );
  }

  Future<void> changePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    emit(
      state.copyWith(isChangingPassword: true, isChangingPasswordSuccess: null),
    );
    final result = await _authRepository.changePassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
    result.handle(
      success: (_, _) {
        emit(
          state.copyWith(
            isChangingPassword: false,
            isChangingPasswordSuccess: true,
          ),
        );
      },
      failure: (f) {
        emit(
          state.copyWith(
            isChangingPassword: false,
            isChangingPasswordSuccess: false,
          ),
        );
      },
    );
  }
}
