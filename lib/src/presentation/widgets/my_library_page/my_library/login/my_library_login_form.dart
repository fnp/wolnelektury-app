import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_label.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/login/my_library_forgot_password_dialog.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryLoginForm extends StatefulWidget {
  const MyLibraryLoginForm({super.key, required this.onRegister});

  final VoidCallback onRegister;

  @override
  State<MyLibraryLoginForm> createState() => _MyLibraryLoginFormState();
}

class _MyLibraryLoginFormState extends State<MyLibraryLoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showUsernameError = false;
  bool showPasswordError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validate() {
    setState(() {
      showUsernameError = _usernameController.text.isEmpty;
      showPasswordError = _passwordController.text.isEmpty;
    });
  }

  bool get isAnyError => showUsernameError || showPasswordError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      autovalidateMode: isAnyError
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFieldLabel(label: LocaleKeys.login_user_name.tr()),
              ),
              Expanded(
                child: AnimatedBoxFade(
                  isChildVisible: showUsernameError,
                  child: TextFieldValidationError(
                    message: LocaleKeys.login_user_name_validation.tr(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.elementHeight,
            child: TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              controller: _usernameController,
              onChanged: (_) {
                if (showUsernameError) {
                  _validate();
                }
              },
            ),
          ),
          const SizedBox(height: Dimensions.mediumPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFieldLabel(label: LocaleKeys.login_password.tr()),
              ),
              Expanded(
                child: AnimatedBoxFade(
                  isChildVisible: showPasswordError,
                  child: TextFieldValidationError(
                    message: LocaleKeys.login_password_validation_empty.tr(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.elementHeight,
            child: TextField(
              textInputAction: TextInputAction.go,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              controller: _passwordController,
              onSubmitted: (value) {
                _validate();
                if (!isAnyError) {
                  BlocProvider.of<AuthCubit>(context).login(
                    email: _usernameController.text,
                    password: _passwordController.text,
                  );
                }
              },
              onChanged: (_) {
                if (showPasswordError) {
                  _validate();
                }
              },
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    MyLibraryForgotPasswordDialog.show(context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: Dimensions.veryLargePadding,
                      left: Dimensions.mediumPadding,
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          LocaleKeys.login_forgot,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                            color: CustomColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.mediumPadding,
                  ),
                  child: GestureDetector(
                    onTap: widget.onRegister,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.login_no_account,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                        const SizedBox(width: Dimensions.smallPadding),
                        Text(
                          LocaleKeys.login_register,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            color: CustomColors.secondaryBlueColor,
                            fontWeight: FontWeight.w500,
                            decorationColor: CustomColors.secondaryBlueColor,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (p, c) => p.isLoading != c.isLoading,
                builder: (context, state) {
                  return Expanded(
                    child: ElevatedButton(
                      style: blueElevatedButton,
                      onPressed: () {
                        _validate();
                        if (!isAnyError) {
                          BlocProvider.of<AuthCubit>(context).login(
                            email: _usernameController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      child: AnimatedSwitcher(
                        switchInCurve: Curves.fastOutSlowIn,
                        switchOutCurve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 200),
                        child: state.isLoading
                            ? const CustomLoader(
                                color: Colors.white,
                                size: 18,
                                strokeWidth: 2,
                              )
                            : const Text(LocaleKeys.login_login).tr(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
