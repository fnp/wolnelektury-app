import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/likes/likes_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/synchronizer/synchronizer_cubit.dart';
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
              final likesCubit = context.read<LikesCubit>();
              CustomSnackbar.success(context, LocaleKeys.login_success.tr());
              context.read<SynchronizerCubit>().sentOutProgressSync();
              context.read<SynchronizerCubit>().sendOutBookmarksSync();
              context.read<SynchronizerCubit>().sendOutLikesSync(
                onFinish: () {
                  likesCubit.init();
                },
              );
            }
            if (state.isLoginSuccess == false) {
              CustomSnackbar.error(context, LocaleKeys.login_errors_login.tr());
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (p, c) {
            return p.user != null && c.user == null;
          },
          listener: (context, state) {
            CustomSnackbar.success(context, LocaleKeys.login_logout.tr());
          },
        ),
        BlocListener<RouterCubit, RouterState>(
          listenWhen: (p, c) => p.location != c.location,
          listener: (context, state) {
            if (state.location == searchPageConfig.path ||
                state.location == filtersPageConfig.path) {
              context.read<ScrollCubit>().hideAppBar();
            } else {
              context.read<ScrollCubit>().showAppBar();
            }
            if (state.location != cataloguePageConfig.path) {
              final modeCubit = context.read<AppModeCubit>();
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
        BlocListener<DownloadCubit, DownloadState>(
          listenWhen: (p, c) => p.progress != 1 && c.progress == 1,
          listener: (context, state) {
            CustomSnackbar.success(
              context,
              LocaleKeys
                  .my_library_offline_snackbar_audiobook_downloading_success
                  .tr(),
            );
          },
        ),
        BlocListener<DownloadCubit, DownloadState>(
          listenWhen: (p, c) {
            return p.downloadingBookAudiobookSlug == null &&
                c.downloadingBookAudiobookSlug != null;
          },
          listener: (context, state) {
            CustomSnackbar.success(
              context,
              LocaleKeys.my_library_offline_snackbar_audiobook_downloading_start
                  .tr(),
            );
          },
        ),
        BlocListener<DownloadCubit, DownloadState>(
          listenWhen: (p, c) {
            return p.isAlreadyDownloadingAudiobookError !=
                c.isAlreadyDownloadingAudiobookError;
          },
          listener: (context, state) {
            if (state.isAlreadyDownloadingAudiobookError == true) {
              CustomSnackbar.error(
                context,
                LocaleKeys
                    .my_library_offline_snackbar_audiobook_already_downloading
                    .tr(),
              );
            }
          },
        ),
        BlocListener<DownloadCubit, DownloadState>(
          listenWhen: (p, c) {
            return p.isGenericAudiobookError != c.isGenericAudiobookError;
          },
          listener: (context, state) {
            if (state.isGenericAudiobookError == true) {
              CustomSnackbar.error(
                context,
                LocaleKeys.my_library_offline_snackbar_audiobook_error.tr(),
              );
            }
          },
        ),
        BlocListener<ConnectivityCubit, ConnectivityState>(
          listenWhen: (p, c) {
            return !p.isConnected && c.isConnected;
          },
          listener: (context, state) {
            final authCubit = context.read<AuthCubit>();
            final likesCubit = context.read<LikesCubit>();
            final syncCubit = context.read<SynchronizerCubit>();
            authCubit.tryAutoLogin().then((_) {
              if (!context.mounted) return;

              if (context.read<AuthCubit>().state.isAuthenticated) {
                syncCubit.sentOutProgressSync();
                syncCubit.sendOutBookmarksSync();
                syncCubit.sendOutLikesSync(
                  onFinish: () {
                    likesCubit.init();
                  },
                );
              }
            });
          },
        ),
        BlocListener<ConnectivityCubit, ConnectivityState>(
          listenWhen: (p, c) {
            return p.isConnected && !c.isConnected;
          },
          listener: (context, state) {
            final authCubit = context.read<AuthCubit>();
            authCubit.clearOnLostConnection();
          },
        ),
      ],
      child: child,
    );
  }
}
