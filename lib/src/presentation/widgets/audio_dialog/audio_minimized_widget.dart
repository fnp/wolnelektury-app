import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/minimized_player/minimized_player_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioMinimizedWidget extends StatefulWidget {
  const AudioMinimizedWidget({super.key});

  @override
  State<AudioMinimizedWidget> createState() => _AudioMinimizedWidgetState();
}

class _AudioMinimizedWidgetState extends State<AudioMinimizedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isPressedDown = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    final playerCubit = BlocProvider.of<MinimizedPlayerCubit>(context);
    const size = Dimensions.minimizedPlayerSize;
    const topElmntsHeight =
        Dimensions.elementHeight + 2 * Dimensions.veryLargePadding;

    return BlocBuilder<ScrollCubit, ScrollState>(
      buildWhen: (p, c) => p.showAppBar != c.showAppBar,
      builder: (context, scrollState) {
        final topOffset = scrollState.showAppBar
            ? topElmntsHeight + Dimensions.appBarHeight
            : topElmntsHeight;
        return BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (p, c) => p.isPlayingMinimized != c.isPlayingMinimized,
          builder: (context, outerState) {
            return BlocBuilder<MinimizedPlayerCubit, MinimizedPlayerState>(
              buildWhen: (p, c) => p.position != c.position,
              builder: (context, state) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeInOut,
                  left: state.position?.dx ?? 0,
                  top: state.position?.dy ?? 0,
                  child: Listener(
                    onPointerMove: (event) {
                      if (!isPressedDown) return;
                      playerCubit.changePosition(
                        Offset(
                          event.position.dx - size / 2,
                          event.position.dy - topOffset,
                        ),
                      );
                    },
                    onPointerUp: (_) => isPressedDown = false,
                    child: AnimatedBoxFade(
                      isChildVisible: outerState.isPlayingMinimized,
                      child: InkWell(
                        onLongPress: () {
                          isPressedDown = true;
                          HapticFeedback.selectionClick();
                        },
                        onTap: () {
                          AudioDialog.show(
                            context: context,
                            onClosed: () => audioCubit.dialogShown(false),
                            slug: audioCubit.state.book?.slug ?? '',
                          );
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.white,
                          ),
                          child: SizedBox.square(
                            dimension: size,
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.lerp(
                                      CustomColors.red,
                                      CustomColors.red.withValues(alpha: 0.5),
                                      _controller.value,
                                    ),
                                  ),
                                  child: child,
                                );
                              },
                              child: const Icon(
                                CustomIcons.music_cast,
                                color: CustomColors.black,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
