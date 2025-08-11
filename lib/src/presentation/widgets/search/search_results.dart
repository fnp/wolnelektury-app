import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/domain/text_search_result_model.dart';
import 'package:wolnelektury/src/presentation/cubits/search/search_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/book_list.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (p, c) {
        return p.generic != c.generic ||
            p.books != c.books ||
            p.texts != c.texts ||
            p.isLoadingResults != c.isLoadingResults;
      },
      builder: (context, state) {
        return AnimatedBoxFade(
          isChildVisible: !state.isLoadingResults,
          collapsedChild: const Center(child: CustomLoader(strokeWidth: 2)),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if ((state.generic?.author ?? []).isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: PageSubtitle(
                    subtitle: LocaleKeys.search_authors.tr().toUpperCase(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.mediumPadding,
                      vertical: Dimensions.spacer,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.generic!.author.length,
                    itemBuilder: (context, index) {
                      return _AuthorElement(
                        author: state.generic!.author[index],
                      );
                    },
                  ),
                ),
              ],
              if (state.books.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: PageSubtitle(
                    subtitle: LocaleKeys.search_books.tr().toUpperCase(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.mediumPadding,
                      vertical: Dimensions.spacer,
                    ),
                  ),
                ),
                BookList(isLoading: false, books: state.books),
              ],
              if (state.texts.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: PageSubtitle(
                    subtitle: LocaleKeys.search_texts.tr().toUpperCase(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.mediumPadding,
                      vertical: Dimensions.spacer,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.texts.length,
                    itemBuilder: (context, index) {
                      return _TextElement(textSearch: state.texts[index]);
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TextElement extends StatelessWidget {
  final TextSearchResultModel textSearch;
  const _TextElement({required this.textSearch});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: theme.colorScheme.onPrimary, thickness: 1),
        Padding(
          padding: const EdgeInsets.all(Dimensions.mediumPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textSearch.book.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                textSearch.book.authors.map((author) => author.name).join(', '),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: Dimensions.mediumPadding),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final snippet = textSearch.snippets[index];
                  return InkWellWrapper(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      router.pushNamed(
                        readingPageConfigWithAnchor.name,
                        extra: textSearch.book,
                        pathParameters: {
                          'slug': textSearch.book.slug,
                          'anchor': snippet.anchor,
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.smallPadding),
                      child: Html(
                        data: snippet.headline,
                        style: {
                          'body': Style(
                            fontSize: FontSize(
                              theme.textTheme.bodyMedium?.fontSize ?? 14,
                            ),
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                          'strong': Style(
                            backgroundColor: CustomColors.primaryYellowColor,
                          ),
                        },
                      ),
                    ),
                  );
                },
                itemCount: textSearch.snippets.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AuthorElement extends StatelessWidget {
  final DetailedAuthorModel author;
  const _AuthorElement({required this.author});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Dimensions.elementHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        child: InkWellWrapper(
          onTap: () {
            router.pushNamed(
              authorPageConfig.name,
              pathParameters: {'slug': author.slug},
            );
          },
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          child: Row(
            children: [
              const SizedBox(width: Dimensions.veryLargePadding),
              Expanded(
                child: Text(
                  author.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if ((author.photo ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.mediumPadding,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: author.photo!,
                      fit: BoxFit.cover,
                      width: Dimensions.elementHeight,
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
