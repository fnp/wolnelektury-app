import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/favourites/favourites_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/minimized_player/minimized_player_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/progress/progress_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DashboardProviders extends StatelessWidget {
  const DashboardProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RouterCubit(),
        ),
        BlocProvider(
          create: (_) => FavouritesCubit(get.get()),
        ),
        BlocProvider(
          create: (_) => ProgressCubit(get.get()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => AudioCubit(get.get(), get.get()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => ScrollCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) {
            final insets = MediaQuery.viewInsetsOf(context);
            final size = MediaQuery.sizeOf(context);
            final paddings = MediaQuery.paddingOf(context);
            final effectiveHeight = size.height -
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
          create: (_) => AuthCubit(get.get())..tryAutoLogin(),
        ),
      ],
      child: child,
    );
  }
}
