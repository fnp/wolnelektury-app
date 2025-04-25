import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogControls extends StatelessWidget {
  const AudioDialogControls({super.key});

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: Dimensions.elementHeight,
        ),
        CustomButton(
          icon: CustomIcons.backward,
          backgroundColor: CustomColors.white,
          onPressed: () {
            audioCubit.backward15s();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
          ),
          child: BlocBuilder<AudioCubit, AudioState>(
            buildWhen: (p, c) =>
                p.isPlaying != c.isPlaying ||
                p.isPreparingSession != c.isPreparingSession,
            builder: (context, state) {
              return AnimatedBoxFade(
                isChildVisible: !state.isPreparingSession,
                collapsedChild: const _Loader(),
                child: CustomButton(
                  icon: state.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  backgroundColor: CustomColors.white,
                  onPressed: () {
                    if (state.isPlaying) {
                      audioCubit.pause();
                      return;
                    }
                    audioCubit.play();
                  },
                  size: Dimensions.elementHeight * 2,
                  iconSize: 48,
                ),
              );
            },
          ),
        ),
        CustomButton(
          icon: CustomIcons.forward,
          backgroundColor: CustomColors.white,
          onPressed: () {
            audioCubit.forward15s();
          },
        ),
        CustomButton(
          icon: Icons.more_horiz,
          backgroundColor: CustomColors.grey,
          onPressed: () => audioCubit.toggleSettings(true),
        ),
      ],
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: Dimensions.elementHeight * 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.white,
        ),
        child: CustomLoader(
          color: CustomColors.secondaryBlueColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
