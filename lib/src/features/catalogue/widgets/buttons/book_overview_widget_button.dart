import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class BookOverviewWidgetButton extends StatelessWidget {
  const BookOverviewWidgetButton({
    super.key,
    required this.nonActiveBackgroundColor,
    required this.nonActiveIcon,
    required this.onTap,
    required this.semanticLabel,
    this.isActive = false,
    this.activeIcon,
    this.activeBackgroundColor,
    double? size,
    double? iconSize,
  }) : size = size ?? 25.0,
       iconSize = iconSize ?? 16.0;

  final VoidCallback onTap;

  final Color nonActiveBackgroundColor;
  final Color? activeBackgroundColor;

  final IconData nonActiveIcon;
  final IconData? activeIcon;

  final bool isActive;

  final double size;
  final double iconSize;

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox.square(
          dimension: size,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: defaultCurve,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? activeBackgroundColor
                  : nonActiveBackgroundColor,
            ),
            child: Icon(
              isActive ? activeIcon ?? nonActiveIcon : nonActiveIcon,
              color: CustomColors.black,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
