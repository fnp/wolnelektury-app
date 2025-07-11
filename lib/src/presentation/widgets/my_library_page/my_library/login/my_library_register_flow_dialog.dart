import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryRegisterFlowDialog extends StatelessWidget {
  const MyLibraryRegisterFlowDialog({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  static void show({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    showDialog(
      // Needs this, this dialog displays snackbar which need to be on top
      // of the dialog
      useRootNavigator: false,
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: MyLibraryRegisterFlowDialog(email: email, password: password),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) =>
          p.isLoginSuccess != c.isLoginSuccess ||
          p.isLoginSuccessFromRegisterFlow != c.isLoginSuccessFromRegisterFlow,
      listener: (context, state) {
        if (state.isLoginSuccess == true) {
          Navigator.of(context).pop();
          return;
        }

        if (state.isLoginSuccessFromRegisterFlow == false) {
          CustomSnackbar.error(
            context,
            LocaleKeys.login_register_flow_dialog_error.tr(),
          );
        }
      },
      child: DialogWrapper(
        title: LocaleKeys.login_register_flow_dialog_title.tr().toUpperCase(),
        icon: Icons.email_rounded,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.login_register_flow_dialog_content,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            const SizedBox(height: Dimensions.spacer),
            Row(
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (p, c) => p.isLoading != c.isLoading,
                  builder: (context, state) {
                    return Expanded(
                      child: ElevatedButton(
                        style: yellowElevatedButton,
                        onPressed: () {
                          if (state.isLoading) return;
                          BlocProvider.of<AuthCubit>(context).login(
                            email: email,
                            password: password,
                            fromRegisterFlow: true,
                          );
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
                              : Text(
                                  LocaleKeys.login_register_flow_dialog_button,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).tr(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
