import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_size.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (builderContext) => BlocProvider.value(
        value: context.read<SettingsCubit>(),
        child: BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (p, c) {
            return p.isChangingPasswordSuccess != c.isChangingPasswordSuccess;
          },
          listener: (context, state) {
            if (state.isChangingPasswordSuccess == true) {
              Navigator.of(builderContext).pop();
              CustomSnackbar.success(
                context,
                LocaleKeys.settings_change_password_success.tr(),
              );
            } else if (state.isChangingPasswordSuccess == false) {
              CustomSnackbar.error(
                context,
                LocaleKeys.settings_change_password_error.tr(),
              );
            }
          },
          child: const ChangePasswordDialog(),
        ),
      ),
    );
  }

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late ThemeData theme;
  final _newPasswordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool showNewPasswordError = false;
  bool showRepeatPasswordError = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      final newPassword = _newPasswordController.text.trim();
      final repeatPassword = _repeatPasswordController.text.trim();

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
          SizedBox(
            height: Dimensions.elementHeight,
            child: TextField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              style: theme.textTheme.bodyMedium,
              controller: _newPasswordController,
              decoration: InputDecoration(
                hintText: LocaleKeys.settings_change_password_new.tr(),
                fillColor: theme.colorScheme.surface,
              ),
              onChanged: (value) {
                if (showNewPasswordError) validate();
              },
            ),
          ),
          AnimatedBoxSize(
            isChildVisible: showNewPasswordError,
            child: TextFieldValidationError(
              message: LocaleKeys.settings_change_password_new_validation.tr(),
            ),
          ),
          const SizedBox(height: Dimensions.smallPadding),

          // Repeat password
          SizedBox(
            height: Dimensions.elementHeight,
            child: TextField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              style: theme.textTheme.bodyMedium,
              controller: _repeatPasswordController,
              decoration: InputDecoration(
                hintText: LocaleKeys.settings_change_password_repeat.tr(),
                fillColor: theme.colorScheme.surface,
              ),
              onChanged: (value) {
                if (showRepeatPasswordError) validate();
              },
            ),
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
                        if (!showNewPasswordError && !showRepeatPasswordError) {
                          context.read<SettingsCubit>().changePassword(
                            _newPasswordController.text.trim(),
                          );
                        }
                      },
                      child: AnimatedBoxFade(
                        isChildVisible: !state.isChangingPassword,
                        duration: const Duration(milliseconds: 300),
                        collapsedChild: const CustomLoader(
                          size: 20,
                          strokeWidth: 2,
                        ),
                        child: Text(
                          LocaleKeys.settings_change_password_button.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
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
    );
  }
}
