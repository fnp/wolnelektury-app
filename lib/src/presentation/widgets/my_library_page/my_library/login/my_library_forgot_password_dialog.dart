import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_size.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/utils/regex/regexes.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryForgotPasswordDialog extends StatefulWidget {
  const MyLibraryForgotPasswordDialog({super.key});

  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) => const MyLibraryForgotPasswordDialog(),
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
              style: theme.textTheme.bodyMedium,
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
                      //TODO connect with backend
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    LocaleKeys.login_reset_dialog_button.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
