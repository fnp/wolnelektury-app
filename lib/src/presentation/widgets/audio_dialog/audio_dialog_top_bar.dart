import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/dropdown/custom_dropdown.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';

class AudioDialogTopBar extends StatelessWidget {
  const AudioDialogTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (p, c) => p.isPreparingPlaylist != c.isPreparingPlaylist,
          builder: (context, state) {
            return CustomButton(
              backgroundColor: CustomColors.red,
              iconColor: CustomColors.white,
              icon: Icons.close,
              onPressed: () {
                if (state.isPreparingSession) {
                  return;
                }
                audioCubit.stop();
                Navigator.of(context).pop();
              },
            );
          },
        ),
        const Spacer(),
        BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (p, c) =>
              p.audiobook != c.audiobook ||
              p.currentlyPlayingPart != c.currentlyPlayingPart,
          builder: (context, state) {
            return SizedBox(
              width: 200,
              child: CustomDropdown<int>(
                maxElements: 5,
                highlightButton: false,
                width: 200,
                items:
                    state.audiobook?.parts.mapIndexed((index, part) {
                      return CustomDropdownElement(
                        title: LocaleKeys.audio_dialog_part.tr(
                          namedArgs: {'part': (index + 1).toString()},
                        ),
                        element: index,
                      );
                    }).toList() ??
                    [],
                onSelected: (selected) {
                  BlocProvider.of<AudioCubit>(context).selectPart(selected);
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                label: LocaleKeys.audio_dialog_part.tr(
                  namedArgs: {
                    'part': (state.currentlyPlayingPart + 1).toString(),
                  },
                ),
              ),
            );
          },
        ),
        const Spacer(),
        CustomButton(
          backgroundColor: CustomColors.black,
          iconColor: CustomColors.white,
          icon: CustomIcons.hide,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
