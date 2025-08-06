import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/router/router_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_size.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ScrollCubit, ScrollState>(
      buildWhen: (p, c) => p.showAppBar != c.showAppBar,
      builder: (context, state) {
        return AnimatedBoxSize(
          isChildVisible: state.showAppBar,
          duration: const Duration(milliseconds: 300),
          collapsedChild: const SizedBox(height: Dimensions.appBarHeight),
          child: PreferredSize(
            preferredSize: const Size.fromHeight(Dimensions.appBarHeight),
            child: AppBar(
              titleSpacing: Dimensions.mediumPadding,
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.surface,
              surfaceTintColor: theme.colorScheme.surface,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Dimensions.elementHeight * 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: BlocBuilder<RouterCubit, RouterState>(
                            buildWhen: (p, c) => p.isMainPage != c.isMainPage,
                            builder: (context, state) {
                              if (!state.isMainPage) {
                                return SizedBox.square(
                                  dimension: Dimensions.elementHeight,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusOfCircle,
                                    ),
                                    onTap: () {
                                      if (state.isMainPage) return;
                                      router.pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: theme.colorScheme.onSurface,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child:
                              BlocBuilder<ConnectivityCubit, ConnectivityState>(
                                buildWhen: (p, c) =>
                                    p.isConnected != c.isConnected,
                                builder: (context, state) {
                                  if (!state.isConnected) {
                                    return const CustomButton(
                                      icon: CustomIcons.signal_disconnected,
                                      iconColor: CustomColors.black,
                                      backgroundColor: Colors.transparent,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SvgPicture.asset(Images.logo, width: 165)),
                  SizedBox(
                    width: Dimensions.elementHeight * 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          icon: Icons.search,
                          iconColor: CustomColors.black,
                          backgroundColor: CustomColors.primaryYellowColor,
                          onPressed: () {
                            router.pushNamed(searchPageConfig.name);
                          },
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: BlocBuilder<RouterCubit, RouterState>(
                            buildWhen: (p, c) =>
                                p.isMyLibraryPage != c.isMyLibraryPage,
                            builder: (context, state) {
                              if (state.isMyLibraryPage) {
                                return CustomButton(
                                  icon: CustomIcons.settings,
                                  iconColor: CustomColors.black,
                                  backgroundColor: CustomColors.white,
                                  onPressed: () {
                                    router.pushNamed(settingsPageConfig.name);
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
