import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_size.dart';
import 'package:wolnelektury/src/features/common/widgets/dialog_wrapper.dart';
import 'package:wolnelektury/src/features/common/widgets/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/features/settings/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ChangePasswordDialog extends StatefulWidget {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  const ChangePasswordDialog({super.key});

  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<SettingsCubit>(),
        child: ScaffoldMessenger(
          key: messengerKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<SettingsCubit, SettingsState>(
              listenWhen: (p, c) {
                return p.isChangingPasswordSuccess !=
                    c.isChangingPasswordSuccess;
              },
              listener: (context, state) {
                if (state.isChangingPasswordSuccess == true) {
                  Navigator.of(context).pop();
                  CustomSnackbar.success(
                    context,
                    LocaleKeys.settings_change_password_success.tr(),
                  );
                } else if (state.isChangingPasswordSuccess == false) {
                  CustomSnackbar.error(
                    context,
                    messengerKey: messengerKey,
                    LocaleKeys.settings_change_password_error.tr(),
                  );
                }
              },
              child: Builder(
                builder: (context) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const ChangePasswordDialog(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late ThemeData theme;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool showCurrentPasswordError = false;
  bool showNewPasswordError = false;
  bool showRepeatPasswordError = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      final currentPassword = _currentPasswordController.text.trim();
      final newPassword = _newPasswordController.text.trim();
      final repeatPassword = _repeatPasswordController.text.trim();

      showCurrentPasswordError = currentPassword.isEmpty;
      showNewPasswordError = newPassword.isEmpty || newPassword.length < 5;
      showRepeatPasswordError =
          repeatPassword.isEmpty || repeatPassword != newPassword;
    });
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      title: LocaleKeys.settings_change_password_title_alt.tr().toUpperCase(),
      icon: Icons.lock,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.settings_change_password_content.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.spacer, width: double.infinity),

            // Current password
            TextField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CustomColors.black,
              ),
              controller: _currentPasswordController,
              decoration: InputDecoration(
                hintText: LocaleKeys.settings_change_password_current.tr(),
                fillColor: theme.colorScheme.primaryFixed,
              ),
              onChanged: (value) {
                if (showCurrentPasswordError) validate();
              },
            ),
            AnimatedBoxSize(
              isChildVisible: showCurrentPasswordError,
              child: TextFieldValidationError(
                message: LocaleKeys.settings_change_password_current_validation
                    .tr(),
              ),
            ),
            const SizedBox(height: Dimensions.smallPadding),

            // New password
            TextField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CustomColors.black,
              ),
              controller: _newPasswordController,
              decoration: InputDecoration(
                hintText: LocaleKeys.settings_change_password_new.tr(),
                fillColor: theme.colorScheme.primaryFixed,
              ),
              onChanged: (value) {
                if (showNewPasswordError) validate();
              },
            ),
            AnimatedBoxSize(
              isChildVisible: showNewPasswordError,
              child: TextFieldValidationError(
                message: LocaleKeys.settings_change_password_new_validation
                    .tr(),
              ),
            ),
            const SizedBox(height: Dimensions.smallPadding),

            // Repeat password
            TextField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CustomColors.black,
              ),
              controller: _repeatPasswordController,
              decoration: InputDecoration(
                hintText: LocaleKeys.settings_change_password_repeat.tr(),
                fillColor: theme.colorScheme.primaryFixed,
              ),
              onChanged: (value) {
                if (showRepeatPasswordError) validate();
              },
            ),
            AnimatedBoxSize(
              isChildVisible: showRepeatPasswordError,
              child: TextFieldValidationError(
                message: LocaleKeys.settings_change_password_repeat_validation
                    .tr(),
              ),
            ),
            const SizedBox(height: Dimensions.smallPadding),

            Row(
              children: [
                Expanded(
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (p, c) {
                      return p.isChangingPassword != c.isChangingPassword;
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: yellowElevatedButton,
                        onPressed: () {
                          validate();
                          if (!showCurrentPasswordError &&
                              !showNewPasswordError &&
                              !showRepeatPasswordError) {
                            context.read<SettingsCubit>().changePassword(
                              newPassword: _newPasswordController.text.trim(),
                              oldPassword: _currentPasswordController.text
                                  .trim(),
                            );
                          }
                        },
                        child: AnimatedBoxFade(
                          isChildVisible: !state.isChangingPassword,
                          duration: const Duration(milliseconds: 300),
                          collapsedChild: const CustomLoader(
                            size: 15,
                            strokeWidth: 2,
                            color: CustomColors.black,
                          ),
                          child: Text(
                            LocaleKeys.settings_change_password_button.tr(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: CustomColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
