import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/utils/duration/format_time.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogSlider extends StatelessWidget {
  final BookModel book;
  const AudioDialogSlider({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final smallTextStyle = theme.textTheme.bodySmall?.copyWith(
      color: CustomColors.black,
      fontWeight: FontWeight.w500,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.modalsPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.black,
                  ),
                ),
              ),
              BlocBuilder<AudioCubit, AudioState>(
                buildWhen: (p, c) =>
                    p.currentlyPlayingPart != c.currentlyPlayingPart,
                builder: (context, state) {
                  return Flexible(
                    child: Text(
                      LocaleKeys.audio_dialog_part.tr(
                        namedArgs: {
                          'part': (state.currentlyPlayingPart + 1).toString(),
                        },
                      ),
                      style: smallTextStyle,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.smallPadding),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.modalsPadding - 20,
          ),
          child: _Slider(),
        ),
        const SizedBox(height: Dimensions.smallPadding),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.modalsPadding,
          ),
          child: BlocBuilder<AudioCubit, AudioState>(
            buildWhen: (p, c) =>
                p.statePosition != c.statePosition ||
                p.localPosition != c.localPosition,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(
                      state.localPosition ?? state.statePosition,
                    ),
                    style: smallTextStyle,
                  ),
                  Text(
                    formatTime(
                      state.wholeDuration,
                    ),
                    style: smallTextStyle,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider();

  double determineSliderBarWidth({
    required BuildContext context,
    required double availableWidth,
  }) {
    final audioState = BlocProvider.of<AudioCubit>(context).state;
    final seconds = audioState.localPosition ?? audioState.statePosition;

    return seconds / audioState.wholeDuration * availableWidth;
  }

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth =
            constraints.maxWidth - Dimensions.veryLargePadding * 2;

        return BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (p, c) =>
              p.statePosition != c.statePosition ||
              p.localPosition != c.localPosition,
          builder: (context, state) {
            return SizedBox(
              height: Dimensions.elementHeight,
              child: Listener(
                // -20 because of padding
                // Padding is required to fit thumb into the stack, which is wider than the slider
                onPointerMove: (event) {
                  if ((event.localPosition.dx - 20) < 0) {
                    audioCubit.updateLocalPosition(0);
                    return;
                  }
                  if ((event.localPosition.dx - 20) > availableWidth) {
                    audioCubit.updateLocalPosition(state.wholeDuration);
                    return;
                  }
                  audioCubit.updateLocalPosition(
                    (((event.localPosition.dx - 20) / availableWidth) *
                            state.wholeDuration)
                        .floor(),
                  );
                },
                // -20 because of padding
                // Padding is required to fit thumb into the stack, which is wider than the slider
                onPointerUp: (event) {
                  int? optionalSeconds;

                  if (state.localPosition == null) {
                    optionalSeconds =
                        (((event.localPosition.dx - 20) / availableWidth) *
                                state.wholeDuration)
                            .floor();
                  }

                  audioCubit.seekToLocallySelectedPosition(
                    optionalSeconds: optionalSeconds,
                  );
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: Dimensions.veryLargePadding,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Dimensions.borderRadiusOfCircle,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: Dimensions.elementHeight / 2,
                              width: availableWidth,
                              decoration: const BoxDecoration(
                                color: CustomColors.white,
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              width: determineSliderBarWidth(
                                context: context,
                                availableWidth: availableWidth,
                              ),
                              child: Container(
                                height: Dimensions.elementHeight / 2,
                                decoration: const BoxDecoration(
                                  color: CustomColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      left: min(
                        determineSliderBarWidth(
                          context: context,
                          availableWidth: availableWidth,
                        ),
                        availableWidth + 20,
                      ),
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      child: Container(
                        height: Dimensions.elementHeight,
                        width: Dimensions.elementHeight,
                        decoration: const BoxDecoration(
                          color: CustomColors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
