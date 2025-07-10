import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/books/books_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_list.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/catalogue_filtering.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/catalogue_sorting.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/list_creation_mode_controls.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppModeCubit, AppModeState>(
      buildWhen: (p, c) => p.mode != c.mode,
      builder: (context, state) {
        // If the app is in list creation mode, we show the controls at the bottom in Stack
        if (state.isListCreation) {
          return const Stack(
            children: [
              _Body(),
              Positioned(
                left: Dimensions.mediumPadding,
                right: Dimensions.mediumPadding,
                bottom: Dimensions.modalsPadding,
                child: ListCreationModeControls(),
              ),
            ],
          );
        }
        return const _Body();
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BooksCubit(get.get())..getBooks()),
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
              context.read<BooksCubit>().getBooks(tags: state.selectedTags);
            },
            child: Column(
              children: [
                ColoredBox(
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
                Expanded(
                  child: BlocBuilder<BooksCubit, BooksState>(
                    buildWhen: (p, c) {
                      return p.isLoading != c.isLoading;
                    },
                    builder: (context, state) {
                      return CustomScrollPage(
                        key: ValueKey(state.isLoading),
                        onLoadMore: () {
                          context.read<BooksCubit>().loadMore();
                        },
                        builder: (controller) {
                          return CustomScrollView(
                            controller: controller,
                            slivers: const [_BooksList()],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
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
    final skeletonizedBooks = List.filled(9, BookModel.empty());

    return SliverPadding(
      padding: const EdgeInsets.only(
        right: Dimensions.mediumPadding,
        left: Dimensions.mediumPadding,
        bottom: Dimensions.mediumPadding,
      ),
      sliver: BlocBuilder<BooksCubit, BooksState>(
        buildWhen: (p, c) => p.isLoading != c.isLoading || p.books != c.books,
        builder: (context, state) {
          final effectiveBooks = state.isLoading
              ? skeletonizedBooks
              : state.books;

          return BookList(isLoading: state.isLoading, books: effectiveBooks);
        },
      ),
    );
  }
}
