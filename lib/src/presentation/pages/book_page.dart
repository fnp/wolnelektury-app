import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPage extends StatelessWidget {
  const BookPage({
    super.key,
    this.book,
  });

  final BookModel? book;

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      // todo error handling
      return const Center(child: Text('Error'));
    }
    return _Content(
      book: book!,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(
          Dimensions.mediumPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BookPageCoverWithButtons(
              book: book,
            ),
            if (book.description != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 40,
                  ),
                  child: SelectionArea(
                    child: Html(
                      data: book.description!,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
