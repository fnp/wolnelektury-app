import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/minimized_player/minimized_player_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/download/download_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/likes/likes_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/my_library/cubits/synchronizer/synchronizer_cubit.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DashboardProviders extends StatelessWidget {
  const DashboardProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final syncCubit = context.read<SynchronizerCubit>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RouterCubit()),
        BlocProvider(
          create: (_) => DownloadCubit(get.get(), get.get(), get.get()),
        ),
        BlocProvider(create: (_) => LikesCubit(get.get())),
        BlocProvider(
          create: (_) => AudioCubit(get.get(), get.get(), get.get()),
        ),
        BlocProvider(create: (_) => ListCreatorCubit(get.get())),
        BlocProvider(create: (_) => ScrollCubit()),
        BlocProvider(
          create: (_) {
            final insets = MediaQuery.viewInsetsOf(context);
            final size = MediaQuery.sizeOf(context);
            final paddings = MediaQuery.paddingOf(context);
            final effectiveHeight =
                size.height -
                paddings.top -
                paddings.bottom -
                insets.bottom -
                insets.top -
                Dimensions.appBarHeight -
                Dimensions.bottomBarHeight -
                Dimensions.minimizedPlayerSize;
            final effectiveWidth = size.width - Dimensions.minimizedPlayerSize;
            return MinimizedPlayerCubit(
              maxHeight: effectiveHeight,
              maxWidth: effectiveWidth,
            );
          },
        ),
        BlocProvider(
          create: (_) {
            return get.get<AuthCubit>()..tryAutoLogin(
              onFailure: () {
                syncCubit.cleanupSyncData();
              },
            );
          },
        ),
      ],
      child: child,
    );
  }
}
