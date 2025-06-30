import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DashboardConnectionWrapper extends StatefulWidget {
  final Scaffold scaffold;
  const DashboardConnectionWrapper({super.key, required this.scaffold});

  @override
  State<DashboardConnectionWrapper> createState() =>
      _DashboardConnectionWrapperState();
}

class _DashboardConnectionWrapperState
    extends State<DashboardConnectionWrapper> {
  bool isDisposed = false;
  bool isShrunk = false;

  void _onDispose() async {
    setState(() {
      isShrunk = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      isDisposed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.sizeOf(context).width;
    final availableHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        widget.scaffold,
        BlocBuilder<ConnectivityCubit, ConnectivityState>(
          buildWhen: (p, c) => p.showAlert != c.showAlert,
          builder: (context, state) {
            return Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 300),
                child: state.showAlert
                    ? SizedBox(
                        key: const ValueKey('loader_mask'),
                        width: availableWidth,
                        height: availableHeight,
                        child: ColoredBox(
                          color: CustomColors.secondaryBlueColor.withValues(
                            alpha: .5,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('loader_mask_empty')),
              ),
            );
          },
        ),
        BlocBuilder<ConnectivityCubit, ConnectivityState>(
          buildWhen: (p, c) => p.showAlert != c.showAlert,
          builder: (context, state) {
            final double targetSize;
            if (state.showAlert && !isShrunk) {
              targetSize = availableWidth * 0.8;
            } else if (isShrunk && !isDisposed) {
              targetSize = 40;
            } else {
              targetSize = 0;
            }

            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              top: !isDisposed
                  ? (availableHeight / 2) - (targetSize / 2)
                  : availableHeight - 100,
              left: (availableWidth - targetSize) / 2,
              right: (availableWidth - targetSize) / 2,
              child: AnimatedContainer(
                width: targetSize,
                height: targetSize,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _NoInternetWidget(
                      showContent: constraints.maxWidth > availableWidth * 0.79,
                      isDisposed: isDisposed,
                      onDispose: () {
                        _onDispose();
                        context.read<ConnectivityCubit>().hideAlert();
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _NoInternetWidget extends StatelessWidget {
  final bool isDisposed;
  final VoidCallback onDispose;
  final bool showContent;
  const _NoInternetWidget({
    required this.isDisposed,
    required this.onDispose,
    required this.showContent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.primaryYellowColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.veryLargePadding,
          horizontal: Dimensions.mediumPadding,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: Duration.zero,
          child: isDisposed || !showContent
              ? const SizedBox.shrink(key: ValueKey('no_connection_empty'))
              : Column(
                  key: const ValueKey('no_connection_content'),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      CustomIcons.signal_disconnected,
                      size: 20,
                      color: CustomColors.black,
                    ),
                    Text(
                      LocaleKeys.no_connection_content.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: CustomColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      style: whiteElevatedButton,
                      onPressed: () {
                        onDispose.call();
                        context.read<ConnectivityCubit>().hideAlert();
                      },
                      child: Text(LocaleKeys.no_connection_button.tr()),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
