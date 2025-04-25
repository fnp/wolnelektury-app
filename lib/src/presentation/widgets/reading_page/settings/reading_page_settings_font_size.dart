import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_slider.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class ReadingPageSettingsFontSize extends StatelessWidget {
  static const double _minThreshold = 0.08;
  static const double _maxThreshold = 0.9;
  const ReadingPageSettingsFontSize({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    return BlocBuilder<ReadingPageCubit, ReadingPageState>(
      buildWhen: (p, c) => p.textSizeFactor != c.textSizeFactor,
      builder: (context, state) {
        return CustomSlider(
          fill: false,
          backgroundEndChild: const Positioned(
            right: 12,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.text_increase,
              color: CustomColors.black,
              size: 17,
            ),
          ),
          backgroundStartChild: const Positioned(
            left: 12,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.text_decrease,
              color: CustomColors.black,
              size: 17,
            ),
          ),
          sliderChild: const SizedBox.square(
            dimension: 30,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: CustomColors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          slideDoubleValue: state.textSizeFactor,
          onPointerMove: (localPosition, maxWidth) {
            final value = localPosition / maxWidth;
            if (value < _minThreshold) {
              return;
            }
            if (value > _maxThreshold) {
              return;
            }
            cubit.changeTextSize(value);
          },
          onPointerDown: (localPosition, maxWidth) {
            final value = localPosition / maxWidth;
            if (value < _minThreshold) {
              return;
            }
            if (value > _maxThreshold) {
              return;
            }
            cubit.changeTextSize(value);
          },
        );
      },
    );
  }
}
