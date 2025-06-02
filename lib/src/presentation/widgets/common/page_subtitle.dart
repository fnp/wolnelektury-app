import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class PageSubtitle extends StatelessWidget {
  final String subtitle;
  const PageSubtitle({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(
        Dimensions.veryLargePadding,
      ),
      child: Text(
        subtitle.toUpperCase(),
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w900,
          height: 1,
        ),
      ),
    );
  }
}
