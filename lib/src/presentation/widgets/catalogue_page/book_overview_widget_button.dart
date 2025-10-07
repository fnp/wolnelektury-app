import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class BookOverviewWidgetButton extends StatelessWidget {
  const BookOverviewWidgetButton({
    super.key,
    required this.nonActiveBackgroundColor,
    required this.nonActiveIcon,
    required this.onTap,
    this.isActive = false,
    this.activeIcon,
    this.activeBackgroundColor,
  });

  final VoidCallback onTap;

  final Color nonActiveBackgroundColor;
  final Color? activeBackgroundColor;

  final IconData nonActiveIcon;
  final IconData? activeIcon;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox.square(
        dimension: 25,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeBackgroundColor : nonActiveBackgroundColor,
          ),
          child: Icon(
            isActive ? activeIcon ?? nonActiveIcon : nonActiveIcon,
            color: CustomColors.black,
            size: 13,
          ),
        ),
      ),
    );
  }
}
