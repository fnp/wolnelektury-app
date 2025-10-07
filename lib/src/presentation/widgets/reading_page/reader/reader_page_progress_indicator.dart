import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class ReadingPageProgressIndicator extends StatelessWidget {
  const ReadingPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ReadingPageCubit, ReadingPageState, int>(
      selector: (state) => state.visualProgress,
      builder: (context, progress) {
        return SizedBox(
          height: 3,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress / 100),
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  CustomColors.green,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
