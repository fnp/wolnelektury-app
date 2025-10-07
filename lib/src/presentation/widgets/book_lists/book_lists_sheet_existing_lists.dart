import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class BookListsSheetExistingLists extends StatelessWidget {
  final String currentlyWorkingOnBookSlug;
  final List<BookListModel> effectiveList;
  const BookListsSheetExistingLists({
    super.key,
    required this.currentlyWorkingOnBookSlug,
    required this.effectiveList,
  });

  @override
  Widget build(BuildContext context) {
    final creatorCubit = BlocProvider.of<ListCreatorCubit>(context);

    return CustomScrollPage(
      ignoreTopbar: true,
      onLoadMore: () {
        creatorCubit.loadMoreLists();
      },
      builder: (scrollController) =>
          BlocBuilder<ListCreatorCubit, ListCreatorState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) {
              return AnimatedBoxFade(
                collapsedChild: const Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.spacer),
                  child: CustomLoader(),
                ),
                isChildVisible: state.isLoading == false,
                child: state.isLoading
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: effectiveList.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: Dimensions.mediumPadding,
                          );
                        },
                        itemBuilder: (context, index) {
                          final listName = effectiveList[index].name;
                          return _Element(
                            listName: listName,
                            bookSlug: currentlyWorkingOnBookSlug,
                            onAdd: () {
                              creatorCubit.addBookToListWithQueue(
                                listName,
                                currentlyWorkingOnBookSlug,
                              );
                            },
                            onRemove: () {
                              creatorCubit.removeBookFromListWithQueue(
                                listName,
                                currentlyWorkingOnBookSlug,
                              );
                            },
                          );
                        },
                      ),
              );
            },
          ),
    );
  }
}

class _Element extends StatelessWidget {
  final String listName;
  final String bookSlug;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  const _Element({
    required this.listName,
    required this.onAdd,
    required this.onRemove,
    required this.bookSlug,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.isBookInList(listName, bookSlug) !=
                c.isBookInList(listName, bookSlug) ||
            p.allLists != c.allLists;
      },
      builder: (context, state) {
        final isBookInList = state.isBookInList(listName, bookSlug);
        return SizedBox(
          height: Dimensions.elementHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.borderRadiusOfCircle,
              ),
              color: isBookInList ? CustomColors.green : CustomColors.white,
            ),
            child: InkWellWrapper(
              borderRadius: BorderRadius.circular(
                Dimensions.borderRadiusOfCircle,
              ),
              onTap: () {
                if (isBookInList) {
                  onRemove();
                } else {
                  onAdd();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.veryLargePadding,
                    ),
                    child: FittedBox(
                      child: Text(
                        listName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.fastOutSlowIn,
                    switchOutCurve: Curves.fastOutSlowIn,
                    child: isBookInList
                        ? CustomButton(
                            key: ValueKey('remove_$listName'),
                            backgroundColor: CustomColors.white,
                            icon: CustomIcons.delete_forever,
                            onPressed: onRemove,
                          )
                        : CustomButton(
                            key: ValueKey('add_$listName'),
                            backgroundColor: CustomColors.white,
                            icon: CustomIcons.add,
                            onPressed: onAdd,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
