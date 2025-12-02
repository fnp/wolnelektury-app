import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_settings/audio_dialog_settings_read_here.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_settings/audio_dialog_settings_sleep_slider.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog_settings/audio_dialog_settings_speed_selector.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogSettings extends StatelessWidget {
  const AudioDialogSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CustomColors.primaryYellowColor,
        borderRadius: BorderRadius.circular(Dimensions.modalsBorderRadius),
      ),
      child: BlocBuilder<AudioCubit, AudioState>(
        buildWhen: (p, c) => p.isSettingsOpened != c.isSettingsOpened,
        builder: (context, state) {
          return AnimatedBoxFade(
            duration: const Duration(milliseconds: 500),
            isChildVisible: state.isSettingsOpened,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 3,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.modalsPadding,
                  vertical: Dimensions.veryLargePadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AudioDialogSettingsSpeedSelector(),
                    AudioDialogSettingsSleepSlider(),
                    // AudioDialogSettingsPartSelector(),
                    AudioDialogSettingsReadHere(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
