import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageContentWarnings extends StatelessWidget {
  final List<String> contentWarnings;
  const BookPageContentWarnings({super.key, required this.contentWarnings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.smallPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: Dimensions.mediumPadding,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: theme.colorScheme.onError,
                size: 20,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.book_content_warning.tr(
                    namedArgs: {'warnings': contentWarnings.join(', ')},
                  ),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onError,
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
