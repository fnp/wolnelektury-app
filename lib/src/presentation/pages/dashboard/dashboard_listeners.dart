import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

class DashboardListeners extends StatelessWidget {
  const DashboardListeners({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (p, c) {
            return p.isLoginSuccess != c.isLoginSuccess;
          },
          listener: (context, state) {
            if (state.isLoginSuccess == true) {
              CustomSnackbar.success(
                context,
                LocaleKeys.login_success.tr(),
              );
            }
            if (state.isLoginSuccess == false) {
              CustomSnackbar.error(
                context,
                LocaleKeys.login_errors_login.tr(),
              );
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (p, c) {
            return p.user != null && c.user == null;
          },
          listener: (context, state) {
            CustomSnackbar.success(
              context,
              LocaleKeys.login_logout.tr(),
            );
          },
        ),
        BlocListener<RouterCubit, RouterState>(
          listenWhen: (p, c) => p.location != c.location,
          listener: (context, state) {
            BlocProvider.of<ScrollCubit>(context).showAppBar();
          },
        ),
      ],
      child: child,
    );
  }
}
