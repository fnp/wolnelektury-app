import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_overview_widget.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookList extends StatelessWidget {
  static const double _textScaleThreshold = 1.4;
  final bool isLoading;
  final List<BookModel> books;

  const BookList({super.key, required this.isLoading, required this.books});

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final gridNumber = crossAxisCount(textScaler.scale(1.0));

    return Skeletonizer.sliver(
      enabled: isLoading,
      child: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridNumber,
          crossAxisSpacing: Dimensions.mediumPadding,
          mainAxisSpacing: Dimensions.largePadding,
          childAspectRatio: calculateAspectRatio(textScaler.scale(1.0)),
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookOverviewWidget(
            book: book,
            gridNumber: gridNumber.toDouble(),
          );
        },
        itemCount: books.length,
      ),
    );
  }

  int crossAxisCount(double textScale) {
    if (textScale < _textScaleThreshold) {
      return 3;
    } else {
      return 2;
    }
  }

  double calculateAspectRatio(double textScale) {
    const minScale = 0.8;
    const maxScale = 3.11;
    const minRatio = 0.35;
    const maxRatio = 0.50;

    final normalized = ((textScale - minScale) / (maxScale - minScale)).clamp(
      0,
      1,
    );

    final inverseNormalized = 1.0 - normalized;
    final ratio = (minRatio + (maxRatio - minRatio) * inverseNormalized).clamp(
      minRatio,
      maxRatio,
    );
    if (textScale > _textScaleThreshold) {
      return ratio;
    }
    if (textScale > 1) {
      return ratio - 0.05;
    }
    return ratio;
  }
}
