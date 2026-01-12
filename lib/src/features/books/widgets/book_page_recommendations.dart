import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/book_overview_widget.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookPageRecommendations extends StatelessWidget {
  const BookPageRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final skeletonizedBooks = List.filled(3, BookModel.empty());
    final availableWidth = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return BlocBuilder<SingleBookCubit, SingleBookState>(
      buildWhen: (p, c) {
        return p.isLoadingRecommendations != c.isLoadingRecommendations ||
            p.recommendedBooks != c.recommendedBooks;
      },
      builder: (context, state) {
        final effectiveBooks = state.isLoadingRecommendations
            ? skeletonizedBooks
            : state.recommendedBooks;

        if (effectiveBooks.isEmpty && !state.isLoadingRecommendations) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.mediumPadding,
              ),
              child: Text(
                LocaleKeys.book_read_more.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: Dimensions.largePadding),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Skeletonizer(
                enabled: state.isLoadingRecommendations,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Dimensions.mediumPadding,
                  children: effectiveBooks.map((book) {
                    return SizedBox(
                      width: availableWidth / 3,
                      child: BookOverviewWidget(book: book, gridNumber: 3),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: Dimensions.veryLargePadding),
          ],
        );
      },
    );
  }
}
