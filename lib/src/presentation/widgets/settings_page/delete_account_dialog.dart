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
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DeleteAccountDialog extends StatefulWidget {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  const DeleteAccountDialog({super.key});

  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) => MultiBlocProvider(
        providers: [BlocProvider.value(value: context.read<SettingsCubit>())],
        child: ScaffoldMessenger(
          key: messengerKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<SettingsCubit, SettingsState>(
              listenWhen: (p, c) {
                return p.isDeletingAccountSuccess != c.isDeletingAccountSuccess;
              },
              listener: (context, state) {
                if (state.isDeletingAccountSuccess == true) {
                  Navigator.of(context).pop();
                  CustomSnackbar.success(
                    context,
                    LocaleKeys.settings_delete_account_success.tr(),
                  );
                } else if (state.isDeletingAccountSuccess == false) {
                  CustomSnackbar.error(
                    context,
                    messengerKey: messengerKey,
                    LocaleKeys.settings_delete_account_error.tr(),
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
                      const DeleteAccountDialog(),
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
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  late ThemeData theme;
  final _currentPasswordController = TextEditingController();
  bool showCurrentPasswordError = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      showCurrentPasswordError = _currentPasswordController.text.trim().isEmpty;
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
      title: LocaleKeys.settings_delete_account_title.tr().toUpperCase(),
      icon: Icons.delete_forever,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.settings_delete_account_content.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: Dimensions.spacer),

            // Current password field
            TextField(
              obscureText: true,
              controller: _currentPasswordController,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CustomColors.black,
              ),
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
              duration: const Duration(milliseconds: 200),
              child: TextFieldValidationError(
                message: LocaleKeys.settings_change_password_current_validation
                    .tr(),
              ),
            ),

            const SizedBox(height: Dimensions.spacer),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: Dimensions.mediumPadding,
              children: [
                ElevatedButton(
                  style: yellowElevatedButton,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    LocaleKeys.settings_delete_account_cancel.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (p, c) =>
                        p.isDeletingAccount != c.isDeletingAccount,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          validate();
                          if (!showCurrentPasswordError) {
                            context.read<SettingsCubit>().deleteAccount(
                              _currentPasswordController.text.trim(),
                            );
                          }
                        },
                        child: AnimatedBoxFade(
                          isChildVisible: !state.isDeletingAccount,
                          duration: const Duration(milliseconds: 300),
                          collapsedChild: CustomLoader(
                            size: 15,
                            strokeWidth: 2,
                            color: theme.colorScheme.onError,
                          ),
                          child: Text(
                            LocaleKeys.settings_delete_account_button.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onError,
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
