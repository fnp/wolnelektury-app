import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/app_mode_enum.dart';
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
              BlocProvider.of<FavouritesCubit>(context).init();
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
            if (state.location != cataloguePageConfig.path) {
              final modeCubit = BlocProvider.of<AppModeCubit>(context);
              if (modeCubit.state.mode == AppModeEnum.listCreationMode) {
                modeCubit.changeMode(AppModeEnum.defaultMode);
              }
            }
          },
        ),
        BlocListener<ListCreatorCubit, ListCreatorState>(
          listenWhen: (p, c) => p.isSuccess != c.isSuccess,
          listener: (context, state) {
            if (state.isSuccess == true) {
              CustomSnackbar.success(
                context,
                LocaleKeys.book_lists_sheet_success.tr(),
              );
            } else if (state.isSuccess == false) {
              CustomSnackbar.error(
                context,
                LocaleKeys.book_lists_sheet_error.tr(),
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
