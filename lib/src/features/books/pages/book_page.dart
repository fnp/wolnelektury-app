import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_content_warnings.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_cover/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_details_table.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_recommendations.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_target_audiences.dart';
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
    final theme = Theme.of(context);
    if (book == null) {
      return BlocProvider(
        create: (context) {
          return SingleBookCubit(get.get(), get.get())
            ..getBookData(slug: slug!)
            ..getRecommendedBooks(slug: slug!);
        },
        child: BlocBuilder<SingleBookCubit, SingleBookState>(
          buildWhen: (p, c) {
            return p.book != c.book || p.isLoading != c.isLoading;
          },
          builder: (context, state) {
            if (!state.isLoading && state.book == null) {
              return Center(
                child: Text(
                  LocaleKeys.book_error.tr(),
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }
            final effectiveBook = state.isLoading
                ? BookModel.empty()
                : state.book;

            return Skeletonizer(
              enabled: state.isLoading,
              child: _Content(book: effectiveBook!),
            );
          },
        ),
      );
    }
    return BlocProvider(
      create: (context) {
        return SingleBookCubit(get.get(), get.get())
          ..getRecommendedBooks(slug: slug!);
      },
      child: _Content(book: book!),
    );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookPageCoverWithButtons(book: book, allowListButton: true),
            const SizedBox(height: Dimensions.veryLargePadding),
            if (book.contentWarnings.isNotEmpty) ...[
              BookPageContentWarnings(contentWarnings: book.contentWarnings),
              const SizedBox(height: Dimensions.veryLargePadding),
            ],
            if (book.audiences.isNotEmpty) ...[
              BookPageTargetAudiences(audiences: book.audiences),
              const SizedBox(height: Dimensions.veryLargePadding),
            ],
            BookPageDetailsTable(book: book),
            if (book.description != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.largePadding,
                  ),
                  child: SelectionArea(child: Html(data: book.description!)),
                ),
              ),

            const BookPageRecommendations(),
          ],
        ),
      ),
    );
  }
}
