import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_size.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/utils/regex/regexes.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryForgotPasswordDialog extends StatefulWidget {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  const MyLibraryForgotPasswordDialog({super.key});

  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider(
        create: (context) => SettingsCubit(get.get(), get.get()),
        child: ScaffoldMessenger(
          key: messengerKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<SettingsCubit, SettingsState>(
              listenWhen: (p, c) {
                return p.resetPasswordSuccess != c.resetPasswordSuccess;
              },
              listener: (context, state) {
                if (state.resetPasswordSuccess == true) {
                  Navigator.of(context).pop();
                  CustomSnackbar.success(
                    context,
                    LocaleKeys.login_reset_dialog_success.tr(),
                  );
                } else if (state.resetPasswordSuccess == false) {
                  CustomSnackbar.error(
                    context,
                    messengerKey: messengerKey,
                    LocaleKeys.login_reset_dialog_error.tr(),
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
                      const MyLibraryForgotPasswordDialog(),
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
  State<MyLibraryForgotPasswordDialog> createState() =>
      _MyLibraryForgotPasswordDialogState();
}

class _MyLibraryForgotPasswordDialogState
    extends State<MyLibraryForgotPasswordDialog> {
  late ThemeData theme;
  final _controller = TextEditingController();
  bool showEmailError = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      showEmailError =
          _controller.text.isEmpty ||
          !Regexes.emailRegex.hasMatch(_controller.text);
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
      title: LocaleKeys.login_reset_dialog_title.tr().toUpperCase(),
      icon: Icons.lock,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.login_reset_dialog_content,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
          const SizedBox(height: Dimensions.spacer),
          SizedBox(
            height: Dimensions.elementHeight,
            child: TextField(
              textInputAction: TextInputAction.done,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CustomColors.black,
              ),
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: theme.colorScheme.primaryFixed,
                hintText: LocaleKeys.account_email.tr(),
              ),
              onChanged: (value) {
                if (showEmailError) {
                  validate();
                }
              },
            ),
          ),
          AnimatedBoxSize(
            isChildVisible: showEmailError,
            child: TextFieldValidationError(
              message: LocaleKeys.login_email_validation.tr(),
            ),
          ),
          const SizedBox(height: Dimensions.smallPadding),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: yellowElevatedButton,
                  onPressed: () {
                    validate();
                    if (!showEmailError) {
                      context.read<SettingsCubit>().resetPassword(
                        _controller.text,
                      );
                    }
                  },
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (p, c) {
                      return p.isSendingResetPassword !=
                          c.isSendingResetPassword;
                    },
                    builder: (context, state) {
                      if (state.isSendingResetPassword) {
                        return const SizedBox(
                          width: 15,
                          height: 15,
                          child: CustomLoader(
                            strokeWidth: 2,
                            color: CustomColors.black,
                          ),
                        );
                      }
                      return Text(
                        LocaleKeys.login_reset_dialog_button.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
