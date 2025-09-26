import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_overview_widget.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookList extends StatelessWidget {
  static const double _textScaleThreshold = 1.4;
  static const double _minWidthFor3Grid = 360;
  final bool isLoading;
  final List<BookModel> books;

  const BookList({super.key, required this.isLoading, required this.books});

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final gridNumber = crossAxisCount(
      textScaler.scale(1.0),
      MediaQuery.sizeOf(context).width,
    );
    return Skeletonizer.sliver(
      enabled: isLoading,
      child: SliverAlignedGrid.count(
        crossAxisCount: gridNumber,
        mainAxisSpacing: Dimensions.largePadding,
        crossAxisSpacing: Dimensions.mediumPadding,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookOverviewWidget(book: book, gridNumber: gridNumber);
        },
        itemCount: books.length,
      ),
    );
  }

  int crossAxisCount(double textScale, double widthOfScreen) {
    if (textScale > _textScaleThreshold || widthOfScreen < _minWidthFor3Grid) {
      return 2;
    } else {
      return 3;
    }
  }
}
