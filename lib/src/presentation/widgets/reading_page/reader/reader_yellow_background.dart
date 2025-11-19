import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class ReaderYellowBackground extends StatelessWidget {
  final int index;
  const ReaderYellowBackground({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingPageCubit, ReadingPageState>(
      buildWhen: (p, c) => p.selectedIndex != c.selectedIndex,
      builder: (context, innerState) {
        return Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: innerState.selectedIndex == index
                    ? CustomColors.primaryYellowColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }
}
