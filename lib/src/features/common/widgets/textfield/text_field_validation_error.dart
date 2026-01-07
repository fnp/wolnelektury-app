import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class TextFieldValidationError extends StatelessWidget {
  const TextFieldValidationError({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.smallPadding,
          horizontal: Dimensions.mediumPadding,
        ),
        child: Text(
          message,
          textAlign: TextAlign.end,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
