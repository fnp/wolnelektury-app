import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.slideDoubleValue,
    this.onPointerMove,
    this.onPointerDown,
    this.backgroundColor = CustomColors.white,
    this.sliderColor = CustomColors.black,
    this.sliderChild = const SizedBox.shrink(),
    this.fill = true,
    this.backgroundStartChild,
    this.backgroundEndChild,
  });

  final double slideDoubleValue;
  final Function(double currentPosition, double maxPosition)? onPointerDown;
  final Function(double currentPosition, double maxPosition)? onPointerMove;
  final Color backgroundColor;
  final Color sliderColor;
  final Widget sliderChild;
  final bool fill;
  final Positioned? backgroundStartChild;
  final Positioned? backgroundEndChild;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.borderRadiusOfCircle,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth - Dimensions.elementHeight;
          final indicatorPosition = maxWidth * slideDoubleValue;
          return SizedBox(
            height: Dimensions.elementHeight,
            width: double.infinity,
            child: Listener(
              onPointerDown: (event) => onPointerDown?.call(
                event.localPosition.dx - Dimensions.elementHeight / 2,
                maxWidth,
              ),
              onPointerMove: (event) => onPointerMove?.call(
                event.localPosition.dx - Dimensions.elementHeight / 2,
                maxWidth,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusOfCircle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (backgroundStartChild != null) backgroundStartChild!,
                  if (backgroundEndChild != null) backgroundEndChild!,
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 75),
                      width: indicatorPosition + Dimensions.elementHeight,
                      decoration: BoxDecoration(
                        color: fill ? sliderColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          Dimensions.borderRadiusOfCircle,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: sliderChild,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
