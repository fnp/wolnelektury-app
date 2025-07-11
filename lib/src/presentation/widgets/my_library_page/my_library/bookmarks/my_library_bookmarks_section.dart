import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/bookmarks/my_library_bookmark_book.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryBookmarksSection extends StatelessWidget {
  const MyLibraryBookmarksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageSubtitle(subtitle: MyLibraryEnum.bookmarks.title),
          Expanded(
            child: BlocBuilder<BookmarksCubit, BookmarksState>(
              buildWhen: (p, c) => p.isLoading != c.isLoading,
              builder: (context, state) {
                final effectiveBookmarks = state.isLoading
                    ? List.generate(
                        5,
                        (_) => BookmarkModel.skeletonized(),
                      ).toList()
                    : state.bookmarks;
                return CustomScrollPage(
                  onLoadMore: () {
                    context.read<BookmarksCubit>().loadMoreMyLibraryBookmarks();
                  },
                  builder: (scrollController) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return MyLibraryBookmarkBook(
                          bookmark: effectiveBookmarks[index],
                          isLoading: state.isLoading,
                        );
                      },
                      itemCount: effectiveBookmarks.length,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
