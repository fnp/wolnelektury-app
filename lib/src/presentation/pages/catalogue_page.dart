import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/books/books_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_overview_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/catalogue_filtering.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/catalogue_sorting.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BooksCubit(get.get())..getBooks(),
        ),
        BlocProvider(
          create: (_) => FilteringCubit(get.get())..getTags(),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<FilteringCubit, FilteringState>(
            listenWhen: (p, c) => p.selectedTags != c.selectedTags,
            listener: (context, state) {
              BlocProvider.of<BooksCubit>(context).getBooks(
                tags: state.selectedTags,
              );
            },
            child: CustomScrollPage(
              onLoadMore: () {
                BlocProvider.of<BooksCubit>(context).loadMore();
              },
              builder: (controller) {
                return CustomScrollView(
                  controller: controller,
                  slivers: [
                    SliverStickyHeader(
                      overlapsContent: false,
                      header: ColoredBox(
                        color: theme.colorScheme.surface,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.mediumPadding,
                            vertical: Dimensions.veryLargePadding,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: CatalogueSorting()),
                              SizedBox(width: Dimensions.mediumPadding),
                              Expanded(child: CatalogueFiltering()),
                            ],
                          ),
                        ),
                      ),
                      sliver: const _BooksList(),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _BooksList extends StatelessWidget {
  const _BooksList();

  @override
  Widget build(BuildContext context) {
    final skeletonizedBooks = List.filled(
      9,
      BookModel.empty(),
    );

    return SliverPadding(
      padding: const EdgeInsets.only(
        right: Dimensions.mediumPadding,
        left: Dimensions.mediumPadding,
        bottom: Dimensions.mediumPadding,
      ),
      sliver: BlocBuilder<BooksCubit, BooksState>(
        buildWhen: (p, c) => p.isLoading != c.isLoading || p.books != c.books,
        builder: (context, state) {
          final effectiveBooks =
              state.isLoading ? skeletonizedBooks : state.books;
          final textScaler = MediaQuery.textScalerOf(context);
          return Skeletonizer.sliver(
            enabled: state.isLoading,
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
                final book = effectiveBooks[index];
                return BookOverviewWidget(book: book);
              },
              itemCount: state.isLoading
                  ? skeletonizedBooks.length
                  : state.books.length,
            ),
          );
        },
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
