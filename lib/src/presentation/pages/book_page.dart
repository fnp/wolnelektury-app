import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

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

            return Skeletonizer(
              enabled: state.isLoading,
              child: _Content(book: effectiveBook!),
            );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookPageCoverWithButtons(book: book),
            const SizedBox(height: Dimensions.spacer),
            _DetailsTable(book: book),
            if (book.description != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.largePadding,
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

class _DetailsTable extends StatelessWidget {
  final BookModel book;
  const _DetailsTable({required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimensions.mediumPadding,
      children: [
        if (book.epochs.isNotEmpty) ...[
          _DetailsTableRow(
            title: 'Epoka',
            values: book.epochs
                .map((e) => (e.id, e.name))
                .where((e) => e.$2 != null)
                .toList(),
          ),
        ],
        if (book.kinds.isNotEmpty) ...[
          _DetailsTableRow(
            title: 'Rodzaj',
            values: book.kinds
                .map((k) => (k.id, k.name))
                .where((e) => e.$2 != null)
                .toList(),
          ),
        ],
        if (book.genres.isNotEmpty) ...[
          _DetailsTableRow(
            title: 'Gatunek',
            values: book.genres
                .map((g) => (g.id, g.name))
                .where((e) => e.$2 != null)
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _DetailsTableRow extends StatelessWidget {
  final String title;
  final List<(int?, String?)> values;

  const _DetailsTableRow({required this.title, required this.values});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
          ),
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: values
                .map(
                  (e) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        Dimensions.borderRadiusOfCircle,
                      ),
                    ),
                    child: InkWellWrapper(
                      borderRadius: BorderRadius.circular(
                        Dimensions.borderRadiusOfCircle,
                      ),
                      onTap: () {
                        if (e.$1 == null) return;
                        final filterCubit = context.read<FilteringCubit>();
                        filterCubit.toggleTag(
                          TagModel.fromId(e.$1!, name: e.$2!),
                          resetRest: true,
                        );
                        router.pushNamed(cataloguePageConfig.name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumPadding,
                          vertical: Dimensions.smallPadding,
                        ),
                        child: Text(
                          e.$2!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
