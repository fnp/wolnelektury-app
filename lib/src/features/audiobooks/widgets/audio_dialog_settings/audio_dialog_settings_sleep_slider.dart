import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_slider.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogSettingsSleepSlider extends StatelessWidget {
  const AudioDialogSettingsSleepSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
          ),
          child: BlocBuilder<AudioCubit, AudioState>(
            buildWhen: (p, c) =>
                p.sleepTimer != c.sleepTimer ||
                p.currentMaxSleepTimer != c.currentMaxSleepTimer ||
                p.speed != c.speed,
            builder: (context, state) {
              return Text(
                LocaleKeys.audio_dialog_settings_sleep_timer.tr(
                  namedArgs: {
                    'time':
                        (min(state.sleepTimer, state.currentMaxSleepTimer) ~/
                                state.speed.value)
                            .toString(),
                  },
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: Dimensions.smallPadding),
        BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (p, c) =>
              p.sleepTimer != c.sleepTimer ||
              p.currentMaxSleepTimer != c.currentMaxSleepTimer,
          builder: (context, state) {
            return CustomSlider(
              sliderChild: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.only(right: Dimensions.smallPadding),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.white,
                    ),
                    child: SizedBox.square(
                      dimension: 30,
                      child: Icon(CustomIcons.timer, size: 20),
                    ),
                  ),
                ),
              ),
              slideDoubleValue:
                  min(state.currentMaxSleepTimer, state.sleepTimer) /
                  state.currentMaxSleepTimer,
              onPointerDown: (localPosition, maxWidth) {
                final x = localPosition;
                audioCubit.changeSleepTimer(
                  (state.currentMaxSleepTimer * x / maxWidth).round(),
                );
              },
              onPointerMove: (localPosition, maxWidth) {
                final x = localPosition;
                if (x < 0) {
                  audioCubit.changeSleepTimer(0);
                  return;
                }
                if (x > maxWidth) {
                  audioCubit.changeSleepTimer(state.currentMaxSleepTimer);
                  return;
                }

                audioCubit.changeSleepTimer(
                  (state.currentMaxSleepTimer * x / maxWidth).round(),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
