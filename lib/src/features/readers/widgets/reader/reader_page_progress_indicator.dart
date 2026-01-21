import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/readers/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageProgressIndicator extends StatelessWidget {
  const ReadingPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ReadingPageCubit>();
    return BlocBuilder<ReadingPageCubit, ReadingPageState>(
      buildWhen: (previous, current) {
        return previous.visualProgress != current.visualProgress ||
            previous.isVisualProgressIncreasing !=
                current.isVisualProgressIncreasing;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            cubit.showFullVisualProgressBar();
          },
          child: Stack(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: defaultCurve,
                child: SizedBox(
                  height: state.isVisualProgressIncreasing ? 5 : 25,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: state.visualProgress / 100,
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: defaultCurve,
                    builder: (context, value, _) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          CustomColors.green,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (!state.isVisualProgressIncreasing &&
                  state.remainingTimeInMinutes > 0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.mediumPadding,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          LocaleKeys.reader_progress_left.tr(
                            namedArgs: {
                              'minutes': state.remainingTimeInMinutes
                                  .toString(),
                            },
                          ),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
