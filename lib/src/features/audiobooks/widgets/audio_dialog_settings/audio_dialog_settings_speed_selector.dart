import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/enums/audio_player_speed_enum.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogSettingsSpeedSelector extends StatelessWidget {
  const AudioDialogSettingsSpeedSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
          ),
          child: BlocBuilder<AudioCubit, AudioState>(
            buildWhen: (p, c) => p.speed != c.speed,
            builder: (context, state) {
              return Text(
                LocaleKeys.audio_dialog_settings_speed_selector.tr(
                  namedArgs: {'speed': state.speed.name},
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
        SizedBox(
          height: Dimensions.elementHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Dimensions.borderRadiusOfCircle,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
              ),
              child: BlocBuilder<AudioCubit, AudioState>(
                buildWhen: (p, c) => p.speed != c.speed,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: AudioPlayerSpeedEnum.values
                        .map(
                          (speed) => _Element(
                            speed: speed,
                            isSelected: state.speed == speed,
                            key: ValueKey(speed),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Element extends StatelessWidget {
  const _Element({required this.speed, required this.isSelected, super.key});

  final AudioPlayerSpeedEnum speed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        audioCubit.changeSpeed(speed);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected
              ? CustomColors.black
              : CustomColors.primaryYellowColor,
          shape: BoxShape.circle,
        ),
        child: AnimatedContainer(
          curve: defaultCurve,
          duration: const Duration(milliseconds: 150),
          width: isSelected ? 30 : 20,
          height: isSelected ? 30 : 20,
          child: Center(
            child: AnimatedBoxFade(
              isChildVisible: isSelected,
              child: const Icon(
                CustomIcons.avg_pace,
                color: CustomColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
