import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/enums/my_library_enum.dart';
import 'package:wolnelektury/src/features/bookmarks/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/common/widgets/page_subtitle.dart';
import 'package:wolnelektury/src/features/my_library/widgets/bookmarks/my_library_bookmark_book.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryBookmarksSection extends StatelessWidget {
  const MyLibraryBookmarksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageSubtitle(subtitle: MyLibraryEnum.bookmarks.title),
          Expanded(
            child: BlocBuilder<BookmarksCubit, BookmarksState>(
              buildWhen: (p, c) {
                return p.isLoading != c.isLoading ||
                    p.bookmarks.isNotEmpty && c.bookmarks.isEmpty ||
                    p.bookmarks.isEmpty && c.bookmarks.isNotEmpty;
              },
              builder: (context, state) {
                return AnimatedSwitcher(
                  switchInCurve: defaultCurve,
                  switchOutCurve: defaultCurve,
                  duration: const Duration(milliseconds: 300),
                  child: !state.isLoading && state.bookmarks.isEmpty
                      ? const _EmptyWidget()
                      : CustomScrollPage(
                          onRefresh: () {
                            return cubit.getMyLibraryBookmarks();
                          },
                          onLoadMore: () {
                            cubit.getMoreMyLibraryBookmarks();
                          },
                          builder: (scrollController) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                return MyLibraryBookmarkBook(
                                  bookmark: state.bookmarks[index],
                                  isLoading: state.isLoading,
                                );
                              },
                              itemCount: state.bookmarks.length,
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksCubit>();
    return EmptyWidget(
      image: Images.empty,
      message: LocaleKeys.common_empty_bookmarks_title.tr(),
      buttonText: LocaleKeys.common_empty_search_in_catalogue.tr(),
      onTap: () {
        router.goNamed(cataloguePageConfig.name);
      },
      onRefresh: () {
        cubit.getMyLibraryBookmarks();
      },
    );
  }
}
