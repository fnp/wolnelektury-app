import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.icon,
    this.backgroundColor = CustomColors.primaryYellowColor,
    this.iconColor = CustomColors.black,
    this.onPressed,
    this.size = Dimensions.elementHeight,
    this.iconSize = 24,
    super.key,
  });

  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox.square(
        dimension: size,
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusOfCircle,
            ),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(
                Dimensions.smallPadding,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
