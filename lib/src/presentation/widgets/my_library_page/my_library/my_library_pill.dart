import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class MyLibraryPill extends StatelessWidget {
  final bool isSelected;
  final MyLibraryEnum pillType;
  final VoidCallback onTap;

  const MyLibraryPill({
    super.key,
    required this.isSelected,
    required this.pillType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: defaultCurve,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          color: isSelected
              ? CustomColors.secondaryBlueColor
              : theme.colorScheme.tertiaryContainer,
        ),
        child: SizedBox(
          height: Dimensions.elementHeight,
          child: InkWellWrapper(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusOfCircle,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.largePadding,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        pillType.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? CustomColors.white
                              : theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
