import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageTargetAudiences extends StatelessWidget {
  final List<String> audiences;
  const BookPageTargetAudiences({super.key, required this.audiences});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.smallPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: Dimensions.mediumPadding,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: theme.colorScheme.onSecondary,
                size: 20,
              ),
              Expanded(
                child: Text(
                  audiences.join(', ').firstLetterUppercase,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
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
