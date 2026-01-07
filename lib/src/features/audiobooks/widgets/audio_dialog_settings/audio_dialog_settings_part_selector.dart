import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogSettingsPartSelector extends StatelessWidget {
  const AudioDialogSettingsPartSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: CustomColors.black,
      fontWeight: FontWeight.w500,
    );
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
            buildWhen: (p, c) => p.playToPart != c.playToPart,
            builder: (context, state) {
              return Text(
                LocaleKeys.audio_dialog_settings_part_selector.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: Dimensions.smallPadding),
        SizedBox(
          height: Dimensions.elementHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Dimensions.borderRadiusOfCircle,
              ),
            ),
            child: BlocBuilder<AudioCubit, AudioState>(
              buildWhen: (p, c) => p.playToPart != c.playToPart,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.veryLargePadding,
                    right: Dimensions.smallPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.playToPart == 0)
                        const SizedBox()
                      else
                        Expanded(
                          child: Text(
                            LocaleKeys
                                .audio_dialog_settings_part_selector_specific
                                .tr(
                                  namedArgs: {
                                    'part': state.playToPart.toString(),
                                  },
                                ),
                            style: textStyle,
                          ),
                        ),
                      const Spacer(),
                      if (state.playToPart != 0)
                        GestureDetector(
                          onTap: () {
                            audioCubit.resetPlayToPart();
                          },
                          child: const Icon(
                            CustomIcons.close,
                            color: CustomColors.darkModeGrey,
                            size: 16,
                          ),
                        ),
                      const SizedBox(width: Dimensions.smallPadding),
                      GestureDetector(
                        onTap: () {
                          if (state.playToPart == 0) {
                            return;
                          }
                          if (state.playToPart == 1) {
                            audioCubit.resetPlayToPart();
                            return;
                          }
                          audioCubit.decreasePlayToPart();
                        },
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.primaryYellowColor,
                          ),
                          child: SizedBox.square(
                            dimension: 30,
                            child: Icon(Icons.remove, size: 16),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          audioCubit.increasePlayToPart();
                        },
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.primaryYellowColor,
                          ),
                          child: SizedBox.square(
                            dimension: 30,
                            child: Icon(CustomIcons.add, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
