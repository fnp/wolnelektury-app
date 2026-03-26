import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_element.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_header.dart';
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
                    : MyLibraryListHeader(
                        bookList: itemList,
                        isListOwner: isListOwner,
                        isCompact: isCompact,
                        isOnListPage: isOnListPage,
                      ))
              : const SizedBox(width: double.infinity),
        );
      },
    );
  }
}

class _ScrollableList extends StatelessWidget {
  final ListModel itemList;
  final bool isListOwner;
  const _ScrollableList({required this.itemList, required this.isListOwner});

  @override
  Widget build(BuildContext context) {
    final listCreatorCubit = context.read<ListCreatorCubit>();

    return Column(
      children: [
        const SizedBox(height: Dimensions.largePadding),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
          ),
          child: MyLibraryListHeader(
            bookList: itemList,
            isListOwner: isListOwner,
            isCompact: false,
            isOnListPage: true,
          ),
        ),
        Expanded(
          child: CustomScrollPage(
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
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.mediumPadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final element = itemList.items[index];
                          if (element.isBook) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimensions.mediumPadding,
                              ),
                              child: MyLibraryListElement.book(
                                key: ValueKey(element.uuid),
                                item: element,
                                listName: itemList.name,
                                isListOwner: isListOwner,
                              ),
                            );
                          }
                          if (element.isBookmark) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimensions.mediumPadding,
                              ),
                              child: MyLibraryListElement.bookmark(
                                key: ValueKey(element.uuid),
                                item: element,
                                listName: itemList.name,
                                isListOwner: isListOwner,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        childCount: itemList.items.length,
                        findChildIndexCallback: (Key key) {
                          if (key is ValueKey<String?>) {
                            final uuid = key.value;
                            return itemList.items.indexWhere(
                              (item) => item.uuid == uuid,
                            );
                          }
                          return null;
                        },
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: true,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: Dimensions.spacer),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
