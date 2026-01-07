import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/features/readers/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class ReaderBreathingBackground extends StatefulWidget {
  final int index;
  const ReaderBreathingBackground({super.key, required this.index});

  @override
  State<ReaderBreathingBackground> createState() =>
      _ReaderBreathingBackgroundState();
}

class _ReaderBreathingBackgroundState extends State<ReaderBreathingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.3,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingPageCubit, ReadingPageState>(
      buildWhen: (p, c) {
        return p.highlightedIndex != c.highlightedIndex ||
            p.isEnabledHighlighting != c.isEnabledHighlighting;
      },
      builder: (context, innerState) {
        final isSelected =
            innerState.highlightedIndex == widget.index &&
            innerState.isEnabledHighlighting;

        return Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: CustomColors.primaryYellowColor.withAlpha(
                        (_animation.value * 255).toInt(),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const SizedBox.expand(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
