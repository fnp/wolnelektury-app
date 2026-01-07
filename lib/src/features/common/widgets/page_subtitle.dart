import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class PageSubtitle extends StatelessWidget {
  final String subtitle;
  final EdgeInsetsGeometry padding;
  const PageSubtitle({
    super.key,
    required this.subtitle,
    this.padding = const EdgeInsets.all(Dimensions.veryLargePadding),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              subtitle.toUpperCase(),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w900,
                height: 1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
