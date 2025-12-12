import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_label.dart';
import 'package:wolnelektury/src/presentation/widgets/common/textfield/text_field_validation_error.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/login/my_library_register_flow_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/register/register_form_agreement_checkbox.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/register/register_form_info_box.dart';
import 'package:wolnelektury/src/utils/regex/regexes.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryRegisterForm extends StatelessWidget {
  const MyLibraryRegisterForm({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimensions.veryLargePadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Form(onLogin: onLogin),
        const MyLibraryRegisterFormInfoBox(),
      ],
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({required this.onLogin});
  final VoidCallback onLogin;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late ThemeData theme;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool showPasswordError = false;
  bool showEmailError = false;
  bool showAgreementError = false;
  bool showConfirmPasswordError = false;

  bool get isAnyError =>
      showPasswordError ||
      showEmailError ||
      showAgreementError ||
      showConfirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  void _validate(BuildContext context) {
    final agreementsState = BlocProvider.of<AuthCubit>(context).state;
    setState(() {
      showAgreementError = !agreementsState.areAllRequiredAgreementsChecked;
      showPasswordError = _passwordController.text.isEmpty;
      showEmailError =
          _emailController.text.isEmpty ||
          !Regexes.emailRegex.hasMatch(_emailController.text);
      showConfirmPasswordError =
          _confirmPasswordController.text.isEmpty ||
          _confirmPasswordController.text != _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => p.isRegisterSuccess != c.isRegisterSuccess,
      listener: (context, state) {
        if (state.isRegisterSuccess == true) {
          MyLibraryRegisterFlowDialog.show(
            context: context,
            email: _emailController.text,
            password: _passwordController.text,
          );
        }
        if (state.isRegisterSuccess == false) {
          CustomSnackbar.error(context, LocaleKeys.login_errors_register.tr());
        }
      },
      child: Form(
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
                  child: TextFieldLabel(label: LocaleKeys.login_email.tr()),
                ),
                Expanded(
                  child: AnimatedBoxFade(
                    isChildVisible: showEmailError,
                    child: TextFieldValidationError(
                      message: LocaleKeys.login_email_validation.tr(),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              controller: _emailController,
              onChanged: (_) {
                if (showEmailError) {
                  _validate(context);
                }
              },
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
            TextField(
              textInputAction: TextInputAction.go,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              controller: _passwordController,
              onChanged: (_) {
                if (showPasswordError) {
                  _validate(context);
                }
              },
            ),
            const SizedBox(height: Dimensions.mediumPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextFieldLabel(
                    label: LocaleKeys.login_repeat_password.tr(),
                  ),
                ),
                Expanded(
                  child: AnimatedBoxFade(
                    isChildVisible: showConfirmPasswordError,
                    child: TextFieldValidationError(
                      message: LocaleKeys.login_repeat_password_validation.tr(),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              textInputAction: TextInputAction.go,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              controller: _confirmPasswordController,
              onChanged: (_) {
                if (showConfirmPasswordError) {
                  _validate(context);
                }
              },
            ),
            const SizedBox(height: Dimensions.mediumPadding),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (p, c) => p.agreements != c.agreements,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      state.agreements?.options
                          .map(
                            (e) => MyLibraryRegisterFormAgreementCheckbox(
                              agreement: e,
                              isError: showAgreementError,
                            ),
                          )
                          .toList() ??
                      [],
                );
              },
            ),
            const SizedBox(height: Dimensions.veryLargePadding),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.mediumPadding,
                    ),
                    child: GestureDetector(
                      onTap: widget.onLogin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.login_has_account,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ).tr(),
                          const SizedBox(width: Dimensions.smallPadding),
                          Text(
                            LocaleKeys.login_login,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              color: CustomColors.secondaryBlueColor,
                              decorationColor: CustomColors.secondaryBlueColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: greenElevatedButton,
                    onPressed: () {
                      _validate(context);
                      if (!isAnyError) {
                        BlocProvider.of<AuthCubit>(context).register(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
                    child: BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (p, c) => p.isLoading != c.isLoading,
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: state.isLoading
                              ? const CustomLoader(
                                  color: Colors.white,
                                  size: 18,
                                  strokeWidth: 2,
                                )
                              : const Text(
                                  LocaleKeys.login_register,
                                  textAlign: TextAlign.center,
                                ).tr(),
                        );
                      },
                    ),
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
