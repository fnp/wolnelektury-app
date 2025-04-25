import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/user_model.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({
    required this.authChild,
    this.nonAuthChild = const SizedBox(),
    super.key,
  });

  final Widget Function(UserModel user) authChild;
  final Widget nonAuthChild;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) {
        return p.isAuthenticated != c.isAuthenticated;
      },
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state.isAuthenticated
              ? authChild.call(state.user!)
              : nonAuthChild,
        );
      },
    );
  }
}
