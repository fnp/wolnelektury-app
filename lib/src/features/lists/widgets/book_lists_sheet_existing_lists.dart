import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
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
        creatorCubit.getMoreLists();
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
                          final listSlug = effectiveList[index].slug;
                          final listName = effectiveList[index].name;
                          return _Element(
                            listSlug: listSlug,
                            listName: listName,
                            bookSlug: currentlyWorkingOnBookSlug,
                            onAdd: () {
                              creatorCubit.addBookToListWithQueue(
                                listSlug,
                                currentlyWorkingOnBookSlug,
                              );
                            },
                            onRemove: () {
                              creatorCubit.removeBookFromListWithQueue(
                                listSlug,
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
  final String listSlug;
  final String listName;
  final String bookSlug;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  const _Element({
    required this.listSlug,
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
        return p.isBookInList(listSlug, bookSlug) !=
                c.isBookInList(listSlug, bookSlug) ||
            p.allLists != c.allLists;
      },
      builder: (context, state) {
        final isBookInList = state.isBookInList(listSlug, bookSlug);
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
                    switchInCurve: defaultCurve,
                    switchOutCurve: defaultCurve,
                    child: isBookInList
                        ? CustomButton(
                            semanticLabel: LocaleKeys
                                .common_semantic_remove_book_from_list
                                .tr(namedArgs: {'listName': listName}),
                            key: ValueKey('remove_$listName'),
                            backgroundColor: CustomColors.white,
                            icon: CustomIcons.delete_forever,
                            onPressed: onRemove,
                          )
                        : CustomButton(
                            semanticLabel: LocaleKeys
                                .common_semantic_add_book_to_list
                                .tr(namedArgs: {'listName': listName}),
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
