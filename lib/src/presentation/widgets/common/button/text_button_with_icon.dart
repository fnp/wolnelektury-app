import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class TextButtonWithIcon extends StatelessWidget {
  const TextButtonWithIcon({
    super.key,
    required this.nonActiveText,
    this.nonActiveIcon,
    this.onPressed,
    this.isActive = false,
    this.activeColor,
    this.nonActiveColor,
    this.activeText,
    this.activeIcon,
    this.trailing,
  }) : assert(
         nonActiveIcon != null || trailing != null,
         'Either nonActiveIcon or trailing must be provided',
       );

  final Color? activeColor;
  final Color? nonActiveColor;

  final String nonActiveText;
  final String? activeText;

  final IconData? nonActiveIcon;
  final IconData? activeIcon;

  final bool isActive;

  final VoidCallback? onPressed;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: Dimensions.elementHeight,
      child: InkWellWrapper(
        splashColor: CustomColors.grey.withValues(alpha: 0.3),
        highlightColor: CustomColors.grey.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            color: isActive
                ? activeColor
                : nonActiveColor ?? theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusOfCircle,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.veryLargePadding,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    isActive ? activeText ?? nonActiveText : nonActiveText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CustomColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (trailing != null)
                trailing!
              else
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.smallPadding,
                    bottom: Dimensions.smallPadding,
                    right: Dimensions.mediumPadding,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      isActive ? activeIcon ?? nonActiveIcon : nonActiveIcon,
                      key: ValueKey<IconData>(
                        isActive
                            ? activeIcon ?? nonActiveIcon!
                            : nonActiveIcon!,
                      ),
                      size: 22,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
