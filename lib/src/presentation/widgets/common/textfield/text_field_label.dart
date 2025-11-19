import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.smallPadding,
        horizontal: Dimensions.mediumPadding,
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
