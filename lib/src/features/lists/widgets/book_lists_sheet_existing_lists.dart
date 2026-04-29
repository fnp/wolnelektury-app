import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/common/widgets/custom_scroll_page.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_editor/list_editor_cubit.dart';
import 'package:wolnelektury/src/features/lists/cubits/lists_cubit/lists_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class BookListsSheetExistingLists extends StatelessWidget {
  final String currentlyWorkingOnBookSlug;
  final List<ListModel> effectiveList;
  const BookListsSheetExistingLists({
    super.key,
    required this.currentlyWorkingOnBookSlug,
    required this.effectiveList,
  });

  @override
  Widget build(BuildContext context) {
    final editorCubit = context.read<ListEditorCubit>();
    final listsCubit = context.read<ListsCubit>();

    return CustomScrollPage(
      ignoreTopbar: true,
      onLoadMore: () {
        listsCubit.getMoreLists();
      },
      builder: (scrollController) {
        return BlocBuilder<ListEditorCubit, ListEditorState>(
          buildWhen: (p, c) {
            return p.isFetchingMemberships != c.isFetchingMemberships;
          },
          builder: (context, outerState) {
            return BlocBuilder<ListsCubit, ListsState>(
              buildWhen: (p, c) => p.isLoading != c.isLoading,
              builder: (context, state) {
                return AnimatedBoxFade(
                  collapsedChild: const Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.spacer),
                    child: CustomLoader(),
                  ),
                  isChildVisible:
                      state.isLoading == false &&
                      outerState.isFetchingMemberships == false,
                  child: state.isLoading || outerState.isFetchingMemberships
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
                                editorCubit.addElement(
                                  bookSlug: currentlyWorkingOnBookSlug,
                                  listSlug: listSlug,
                                );
                              },
                              onRemove: () {
                                editorCubit.removeElement(
                                  bookSlug: currentlyWorkingOnBookSlug,
                                  listSlug: listSlug,
                                );
                              },
                            );
                          },
                        ),
                );
              },
            );
          },
        );
      },
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
    return BlocBuilder<ListEditorCubit, ListEditorState>(
      buildWhen: (p, c) {
        return p.isItemInGivenList(listSlug, bookSlug) !=
                c.isItemInGivenList(listSlug, bookSlug) ||
            p.itemsToAdd != c.itemsToAdd ||
            p.itemsToRemove != c.itemsToRemove;
      },
      builder: (context, state) {
        final isBookInList = state.isItemInGivenList(listSlug, bookSlug);
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.veryLargePadding,
                      ),
                      child: Text(
                        listName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
