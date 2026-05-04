import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/common/widgets/empty_widget.dart';
import 'package:wolnelektury/src/features/lists/cubits/lists_cubit/lists_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_element.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_header.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

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
    return BlocBuilder<ListsCubit, ListsState>(
      buildWhen: (p, c) {
        return p.doesLocalListExistsAlready(itemList.slug) !=
            c.doesLocalListExistsAlready(itemList.slug);
      },
      builder: (context, state) {
        final isExisting =
            state.doesLocalListExistsAlready(itemList.slug) || state.isLoading;

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
    final listsCubit = context.read<ListsCubit>();

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
              listsCubit.getMoreListItems(itemList.slug);
            },
            builder: (scrollController) {
              return CustomScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: Dimensions.spacer / 2),
                  ),

                  if (itemList.items.isEmpty)
                    EmptyWidget(
                      image: Images.empty,
                      message: LocaleKeys.common_empty_lists_content_title.tr(),
                      onTap: () {
                        router.pushNamed(cataloguePageConfig.name);
                      },
                      buttonText: LocaleKeys.common_empty_search_in_catalogue
                          .tr(),
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
                            return MyLibraryListElement.book(
                              key: ValueKey(element.uuid),
                              item: element,
                              listName: itemList.name,
                              isListOwner: isListOwner,
                            );
                          }
                          if (element.isBookmark) {
                            return MyLibraryListElement.bookmark(
                              key: ValueKey(element.uuid),
                              item: element,
                              listName: itemList.name,
                              isListOwner: isListOwner,
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
