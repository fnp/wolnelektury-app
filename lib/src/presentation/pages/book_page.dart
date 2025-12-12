import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/presentation/cubits/filtering/filtering_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
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
    final theme = Theme.of(context);
    if (book == null) {
      return BlocProvider(
        create: (context) {
          return SingleBookCubit(get.get(), get.get())
            ..getBookData(slug: slug!);
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
            BookPageCoverWithButtons(book: book, allowListButton: true),
            const SizedBox(height: Dimensions.veryLargePadding),
            if (book.contentWarnings.isNotEmpty) ...[
              _ContentWarnings(contentWarnings: book.contentWarnings),
              const SizedBox(height: Dimensions.veryLargePadding),
            ],
            if (book.audiences.isNotEmpty) ...[
              _Audiences(audiences: book.audiences),
              const SizedBox(height: Dimensions.veryLargePadding),
            ],
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
            title: LocaleKeys.book_epoch.tr(),
            pills: [
              ...book.epochs.map(
                (e) => _Pill(
                  onTap: () {
                    if (e.id == null) return;
                    final filterCubit = context.read<FilteringCubit>();
                    filterCubit.toggleTag(
                      TagModel.fromId(e.id!, name: e.name!),
                      resetRest: true,
                    );
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  label: e.name!,
                ),
              ),
            ],
          ),
        ],
        if (book.kinds.isNotEmpty) ...[
          _DetailsTableRow(
            title: LocaleKeys.book_kind.tr(),
            pills: [
              ...book.kinds.map(
                (k) => _Pill(
                  onTap: () {
                    if (k.id == null) return;
                    final filterCubit = context.read<FilteringCubit>();
                    filterCubit.toggleTag(
                      TagModel.fromId(k.id!, name: k.name!),
                      resetRest: true,
                    );
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  label: k.name!,
                ),
              ),
            ],
          ),
        ],
        if (book.genres.isNotEmpty) ...[
          _DetailsTableRow(
            title: LocaleKeys.book_genre.tr(),
            pills: [
              ...book.genres.map(
                (g) => _Pill(
                  onTap: () {
                    if (g.id == null) return;
                    final filterCubit = context.read<FilteringCubit>();
                    filterCubit.toggleTag(
                      TagModel.fromId(g.id!, name: g.name!),
                      resetRest: true,
                    );
                    router.pushNamed(cataloguePageConfig.name);
                  },
                  label: g.name!,
                ),
              ),
            ],
          ),
          if (book.elevenReaderLink != null)
            _DetailsTableRow(
              title: LocaleKeys.book_available_in.tr(),
              pills: [
                _Pill(
                  backgroundColor: CustomColors.secondaryBlueColor,
                  textColor: CustomColors.white,
                  onTap: () {
                    launchUrlString(book.elevenReaderLink!);
                  },
                  label: 'ElevenReader',
                ),
              ],
            ),
        ],
      ],
    );
  }
}

class _ContentWarnings extends StatelessWidget {
  final List<String> contentWarnings;
  const _ContentWarnings({required this.contentWarnings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.smallPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: Dimensions.mediumPadding,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: theme.colorScheme.onError,
                size: 20,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.book_content_warning.tr(
                    namedArgs: {'warnings': contentWarnings.join(', ')},
                  ),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onError,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Audiences extends StatelessWidget {
  final List<String> audiences;
  const _Audiences({required this.audiences});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.smallPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: Dimensions.mediumPadding,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: theme.colorScheme.onSecondary,
                size: 20,
              ),
              Expanded(
                child: Text(
                  audiences.join(', ').firstLetterUppercase,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsTableRow extends StatelessWidget {
  final String title;
  final List<Widget> pills;

  const _DetailsTableRow({required this.title, required this.pills});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: Dimensions.mediumPadding),
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: pills,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  const _Pill({
    required this.onTap,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
      ),
      child: InkWellWrapper(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
            vertical: Dimensions.smallPadding,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
