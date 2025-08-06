import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key, this.book, this.slug})
    : assert(
        book != null || slug != null,
        'Either book or slug must be provided',
      );

  final BookModel? book;
  final String? slug;

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      return BlocProvider(
        create: (context) {
          return SingleBookCubit(get.get(), get.get())
            ..loadBookData(slug: slug!);
        },
        child: BlocBuilder<SingleBookCubit, SingleBookState>(
          buildWhen: (p, c) {
            return p.book != c.book || p.isLoading != c.isLoading;
          },
          builder: (context, state) {
            if (!state.isLoading && state.book == null) {
              //todo error
              return const Center(child: Text('Error loading book'));
            }
            final effectiveBook = state.isLoading
                ? BookModel.empty()
                : state.book;

            return _Content(book: effectiveBook!);
          },
        ),
      );
    }
    return _Content(book: book!);
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.mediumPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BookPageCoverWithButtons(book: book),
            if (book.description != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 40,
                  ),
                  child: SelectionArea(child: Html(data: book.description!)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
