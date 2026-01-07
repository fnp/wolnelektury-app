import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/features/common/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/connectivity/connectivity_cubit.dart';

mixin RepositoryHelperMixin {
  /// Checks if the repository is online and authenticated.
  bool get tryOnline {
    final isConnected = get.get<ConnectivityCubit>().state.isConnected;
    final isLogged = get.get<AuthCubit>().state.isAuthenticated;
    return isConnected && isLogged;
  }
}
