import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_header.dart';
import 'package:wolnelektury/src/presentation/widgets/settings_page/change_password_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/settings_page/delete_account_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/settings_page/socials_bottom_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/settings_page/theme_toggle_switch.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (p, c) {
            return !p.isSettingNotificationError &&
                c.isSettingNotificationError;
          },
          listener: (context, state) {
            if (state.isSettingNotificationError) {
              CustomSnackbar.error(
                context,
                LocaleKeys.settings_notifications_error.tr(),
              );
            }
          },
        ),
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (p, c) {
            return !p.notificationsPermissionDenied &&
                c.notificationsPermissionDenied;
          },
          listener: (context, state) {
            if (state.notificationsPermissionDenied) {
              CustomSnackbar.error(
                context,
                'Permisje do powiadomień zostały zablokowane. Możesz je zmienić w ustawieniach aplikacji.',
                icon: const Icon(
                  Icons.settings,
                  color: CustomColors.white,
                  size: 18,
                ),
                onIconTap: () {
                  BlocProvider.of<SettingsCubit>(context).openSettings();
                },
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (p, c) {
          return p.isAuthenticated != c.isAuthenticated;
        },
        builder: (context, state) {
          final settingsCubit = BlocProvider.of<SettingsCubit>(context);
          final isAuthorized = state.isAuthenticated;
          return Padding(
            padding: const EdgeInsets.all(Dimensions.mediumPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(title: LocaleKeys.settings_title.tr()),
                const SizedBox(height: Dimensions.spacer),
                if (isAuthorized)
                  _SettingsContainer(
                    text: LocaleKeys.settings_notifications.tr(),
                    padding: const EdgeInsets.only(
                      left: Dimensions.veryLargePadding,
                    ),
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      buildWhen: (p, c) {
                        return p.notificationsEnabled != c.notificationsEnabled;
                      },
                      builder: (context, state) {
                        return FlutterSwitch(
                          activeColor: CustomColors.green,
                          inactiveColor: CustomColors.red,
                          height: 38,
                          toggleSize: 30,
                          width: 80,
                          padding: 5,
                          value: state.notificationsEnabled ?? false,
                          onToggle: (v) {
                            settingsCubit.setNotificationsSettings(v);
                          },
                        );
                      },
                    ),
                  ),
                _SettingsContainer(
                  text: LocaleKeys.settings_theme.tr(),
                  padding: const EdgeInsets.only(
                    left: Dimensions.veryLargePadding,
                  ),
                  child: ThemeToggleSwitch(
                    initialMode: BlocProvider.of<SettingsCubit>(
                      context,
                    ).state.theme,
                  ),
                ),
                _SettingsContainer(
                  text: LocaleKeys.settings_social_title.tr(),
                  onTap: () {
                    SocialsBottomSheet.show(context: context);
                  },
                ),
                if (isAuthorized)
                  _SettingsContainer(
                    text: LocaleKeys.settings_change_password_title.tr(),
                    onTap: () {
                      ChangePasswordDialog.show(context: context);
                    },
                  ),
                _SettingsContainer(text: LocaleKeys.settings_rate.tr()),
                if (isAuthorized)
                  _SettingsContainer(
                    text: LocaleKeys.settings_delete.tr(),
                    onTap: () {
                      DeleteAccountDialog.show(context: context);
                    },
                  ),
                if (isAuthorized) ...[
                  const SizedBox(height: Dimensions.mediumPadding),
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).logout();
                            Navigator.of(context).pop();
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(LocaleKeys.settings_logout.tr()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: Dimensions.largePadding),
                const Spacer(),
                BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (p, c) {
                    return p.version != c.version;
                  },
                  builder: (context, state) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: Dimensions.veryLargePadding,
                        ),
                        child: Text(
                          'v//${(state.version ?? '')}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: CustomColors.secondaryBlueColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  const _SettingsContainer({
    required this.text,
    this.padding = const EdgeInsets.only(
      left: Dimensions.veryLargePadding,
      right: Dimensions.mediumPadding,
    ),
    this.child,
    this.onTap,
  });

  final String text;
  final Widget? child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.mediumPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          border: Border.all(color: theme.colorScheme.surface),
        ),
        child: InkWellWrapper(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          child: Padding(
            padding: padding,
            child: SizedBox(
              height: Dimensions.elementHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ),
                  child ??
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: CustomColors.black,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
