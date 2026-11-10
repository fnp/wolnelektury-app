import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

/// Simple display of a quote's text and its source book.
class QuoteWidget extends StatelessWidget {
  final QuoteModel quote;

  const QuoteWidget({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          quote.text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontFamily: sourceSerif4Family,
            fontStyle: FontStyle.italic,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.smallPadding),
        Text(
          quote.book.title,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
