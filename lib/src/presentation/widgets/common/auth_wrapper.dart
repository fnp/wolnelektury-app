import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({required this.child, super.key});

  final Widget Function(bool isAuthenticated, bool wasLoggedInWhileOnline)
  child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) {
        return p.isAuthenticated != c.isAuthenticated ||
            p.wasLoggedInWhileOnline != c.wasLoggedInWhileOnline;
      },
      builder: (context, state) {
        return child(state.isAuthenticated, state.wasLoggedInWhileOnline);
      },
    );
  }
}
