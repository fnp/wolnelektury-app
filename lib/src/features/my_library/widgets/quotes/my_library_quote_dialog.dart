import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/quote_model.dart';
import 'package:wolnelektury/src/features/common/widgets/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

/// Shows the full quote with an option to open the text at its location.
class MyLibraryQuoteDialog extends StatelessWidget {
  final QuoteModel quote;

  const MyLibraryQuoteDialog({super.key, required this.quote});

  static void show({required BuildContext context, required QuoteModel quote}) {
    showDialog(
      context: context,
      builder: (_) => MyLibraryQuoteDialog(quote: quote),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxQuoteHeight = MediaQuery.sizeOf(context).height * 0.4;
    final authors = quote.book.authors.map((e) => e.name).join(', ');

    return DialogWrapper(
      title: LocaleKeys.my_library_quote_dialog_title.tr(),
      icon: Icons.format_quote,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.veryLargePadding,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxQuoteHeight),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: sourceSerif4Family,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: Dimensions.mediumPadding),
                        Text(
                          quote.book.title,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (authors.isNotEmpty)
                          Text(authors, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: yellowElevatedButton,
              onPressed: () {
                Navigator.of(context).pop();
                router.pushNamed(
                  // Quotes carry the paragraph anchor they were taken from
                  ReaderPageConfigWithAnchor.name,
                  extra: quote.book,
                  pathParameters: {
                    'slug': quote.book.slug,
                    if (quote.startElem != null) 'anchor': quote.startElem!,
                  },
                );
              },
              child: Text(
                LocaleKeys.my_library_quote_dialog_go_to_text.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
