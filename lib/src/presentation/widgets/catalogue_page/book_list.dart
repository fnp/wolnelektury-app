import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_overview_widget.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookList extends StatelessWidget {
  final bool isLoading;
  final List<BookModel> books;

  const BookList({
    super.key,
    required this.isLoading,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);

    return Skeletonizer.sliver(
      enabled: isLoading,
      child: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Dimensions.mediumPadding,
          mainAxisSpacing: Dimensions.largePadding,
          childAspectRatio: calculateAspectRatio(
            textScaler.scale(1.0),
          ),
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookOverviewWidget(book: book);
        },
        itemCount: books.length,
      ),
    );
  }

  double calculateAspectRatio(double textScale) {
    const minScale = 0.8;
    const maxScale = 3.11;
    const minRatio = 0.3;
    const maxRatio = 0.50;

    final normalized =
        ((textScale - minScale) / (maxScale - minScale)).clamp(0.0, 1.0);

    final inverseNormalized = 1.0 - normalized;

    return (minRatio + (maxRatio - minRatio) * inverseNormalized)
        .clamp(minRatio, maxRatio);
  }
}
