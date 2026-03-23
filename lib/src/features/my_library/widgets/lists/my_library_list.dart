import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_book_list_header.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_book.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_bookmark.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryList extends StatelessWidget {
  final ListModel itemList;
  final bool isCompact;
  final bool isListOwner;
  final bool isOnListPage;

  const MyLibraryList({
    super.key,
    required this.itemList,
    required this.isCompact,
    this.isListOwner = true,
  }) : isOnListPage = !isCompact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.doesLocalListExistsAlready(itemList.slug) !=
            c.doesLocalListExistsAlready(itemList.slug);
      },
      builder: (context, state) {
        final isExisting =
            state.doesLocalListExistsAlready(itemList.slug) ||
            state.fetchedSingleList?.slug == itemList.slug;

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          alignment: Alignment.topCenter,
          child: isExisting
              ? (!isCompact
                    ? _ScrollableList(
                        itemList: itemList,
                        isListOwner: isListOwner,
                      )
                    : _HeaderByType(
                        itemList: itemList,
                        isCompact: isCompact,
                        isListOwner: isListOwner,
                        isOnListPage: isOnListPage,
                      ))
              : const SizedBox(width: double.infinity),
        );
      },
    );
  }
}

class _HeaderByType extends StatelessWidget {
  final bool isCompact;
  final bool isListOwner;
  final bool isOnListPage;
  final ListModel itemList;
  const _HeaderByType({
    required this.itemList,
    required this.isCompact,
    required this.isListOwner,
    required this.isOnListPage,
  });

  @override
  Widget build(BuildContext context) {
    final listType = itemList.listType;
    switch (listType) {
      case ListType.books:
        return MyLibraryBookListHeader(
          bookList: itemList,
          isListOwner: isListOwner,
          isCompact: isCompact,
          isOnListPage: isOnListPage,
        );
      case ListType.bookmarks:
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return MyLibraryListBookmark(
              key: ValueKey(itemList.bookmarks[index]),
              bookmarkId: itemList.bookmarks[index].uuid ?? '',
              listSlug: itemList.slug,
              listName: itemList.name,
              isListOwner: isListOwner,
            );
          }, childCount: itemList.bookmarks.length),
        );
    }
  }
}

class _ScrollableList extends StatelessWidget {
  final ListModel itemList;
  final bool isListOwner;
  const _ScrollableList({required this.itemList, required this.isListOwner});

  @override
  Widget build(BuildContext context) {
    final listCreatorCubit = context.read<ListCreatorCubit>();

    return CustomScrollPage(
      onLoadMore: () {
        listCreatorCubit.getMoreListItems(itemList.slug);
      },
      builder: (scrollController) {
        return CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: Dimensions.spacer / 2),
            ),
            SliverToBoxAdapter(
              child: MyLibraryBookListHeader(
                bookList: itemList,
                isListOwner: isListOwner,
                isCompact: false,
                isOnListPage: true,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: Dimensions.spacer / 2),
            ),
            _ListByType(itemList: itemList, isListOwner: isListOwner),
            const SliverToBoxAdapter(
              child: SizedBox(height: Dimensions.spacer),
            ),
          ],
        );
      },
    );
  }
}

class _ListByType extends StatelessWidget {
  final ListModel itemList;
  final bool isListOwner;
  const _ListByType({required this.itemList, required this.isListOwner});

  @override
  Widget build(BuildContext context) {
    final listType = itemList.listType;
    switch (listType) {
      case ListType.books:
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return MyLibraryListBook(
              key: ValueKey(itemList.books[index]),
              item: itemList.items[index],
              listName: itemList.name,
              isListOwner: isListOwner,
            );
          }, childCount: itemList.books.length),
        );
      case ListType.bookmarks:
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return MyLibraryListBookmark(
              key: ValueKey(itemList.bookmarks[index]),
              bookmarkId: itemList.bookmarks[index].uuid ?? '',
              listSlug: itemList.slug,
              listName: itemList.name,
              isListOwner: isListOwner,
            );
          }, childCount: itemList.bookmarks.length),
        );
    }
  }
}
