import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_cover/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/lists/cubits/lists_cubit/lists_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

/// Base class for list elements with factory constructors
abstract class MyLibraryListElement extends StatelessWidget {
  final ListItemModel item;
  final String listName;
  final bool isListOwner;

  const MyLibraryListElement({
    super.key,
    required this.item,
    required this.listName,
    required this.isListOwner,
  });

  /// Factory for book list items
  factory MyLibraryListElement.book({
    Key? key,
    required ListItemModel item,
    required String listName,
    required bool isListOwner,
  }) {
    return _MyLibraryListBookElement(
      key: key,
      item: item,
      listName: listName,
      isListOwner: isListOwner,
    );
  }

  /// Factory for bookmark list items
  factory MyLibraryListElement.bookmark({
    Key? key,
    required ListItemModel item,
    required String listName,
    required bool isListOwner,
  }) {
    return _MyLibraryListBookmarkElement(
      key: key,
      item: item,
      listName: listName,
      isListOwner: isListOwner,
    );
  }
}

/// Book list element implementation
class _MyLibraryListBookElement extends MyLibraryListElement {
  const _MyLibraryListBookElement({
    super.key,
    required super.item,
    required super.listName,
    required super.isListOwner,
  });

  bool determineVisibility(ListsState state) {
    return !state.isBookInList(item.listSlug, item.book?.slug ?? '') ||
        (state.softDeletedItem?.uuid == item.uuid &&
            state.softDeletedItem?.listSlug == item.listSlug);
  }

  @override
  Widget build(BuildContext context) {
    if (item.book == null) {
      return const SizedBox.shrink();
    }
    final listsCubit = context.read<ListsCubit>();
    return BlocBuilder<ListsCubit, ListsState>(
      buildWhen: (p, c) {
        return p.softDeletedItem != c.softDeletedItem ||
            p.isBookInList(item.listSlug, item.book?.slug ?? '') !=
                c.isBookInList(item.listSlug, item.book?.slug ?? '');
      },
      builder: (context, state) {
        final shouldHide = determineVisibility(state);

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          child: shouldHide
              ? const SizedBox(width: double.infinity)
              : Skeletonizer(
                  enableSwitchAnimation: true,
                  enabled: state.isLoading,
                  child: BookPageCoverWithButtons.listItem(
                    key: ValueKey(item.book?.slug),
                    item: item,
                    onDelete: isListOwner
                        ? () {
                            listsCubit.removeItemFromList(item: item);
                            CustomSnackbar.success(
                              context,
                              LocaleKeys.book_lists_sheet_delete.tr(),
                              onRevert: () {
                                listsCubit.undoSoftRemoval();
                              },
                            );
                          }
                        : null,
                    book: state.isLoading ? BookModel.skeleton() : item.book!,
                  ),
                ),
        );
      },
    );
  }
}

/// Bookmark list element implementation
class _MyLibraryListBookmarkElement extends MyLibraryListElement {
  const _MyLibraryListBookmarkElement({
    super.key,
    required super.item,
    required super.listName,
    required super.isListOwner,
  });

  bool determineVisibility(ListsState state) {
    return !state.isBookmarkInList(item.listSlug, item.bookmark?.uuid ?? '') ||
        (state.softDeletedItem?.uuid == item.uuid &&
            state.softDeletedItem?.listSlug == item.listSlug);
  }

  @override
  Widget build(BuildContext context) {
    if (item.bookmark == null) {
      return const SizedBox.shrink();
    }

    final bookmark = item.bookmark!;
    final listsCubit = context.read<ListsCubit>();
    final theme = Theme.of(context);

    return BlocBuilder<ListsCubit, ListsState>(
      buildWhen: (p, c) {
        return p.softDeletedItem != c.softDeletedItem ||
            p.isBookmarkInList(item.listSlug, bookmark.uuid ?? '') !=
                c.isBookmarkInList(item.listSlug, bookmark.uuid ?? '');
      },
      builder: (context, state) {
        final shouldHide = determineVisibility(state);

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          child: shouldHide
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(
                    bottom: Dimensions.smallPadding,
                  ),
                  child: InkWellWrapper(
                    borderRadius: BorderRadius.circular(
                      Dimensions.smallBorderRadius,
                    ),
                    onTap: () {
                      if (bookmark.uuid != null) {
                        router.pushNamed(
                          bookmarkPageConfig.name,
                          pathParameters: {'uuid': bookmark.uuid!},
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.smallPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.smallBorderRadius,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: Dimensions.mediumPadding),
                          // Bookmark icon on the left
                          const Icon(
                            CustomIcons.bookmark,
                            color: CustomColors.primaryYellowColor,
                            size: 32,
                          ),
                          const SizedBox(width: Dimensions.largePadding),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Book slug as title
                                Text(
                                  bookmark.slug,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                // Show anchor if available
                                if (bookmark.anchor != null) ...[
                                  const SizedBox(
                                    height: Dimensions.smallPadding,
                                  ),
                                  Text(
                                    LocaleKeys.audio_dialog_paragraph.tr(
                                      namedArgs: {
                                        'paragraph': bookmark.anchor!,
                                      },
                                    ),
                                    style: theme.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],

                                // Show note if available
                                if (bookmark.note.isNotEmpty) ...[
                                  const SizedBox(
                                    height: Dimensions.smallPadding,
                                  ),
                                  Text(
                                    bookmark.note,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.textTheme.bodySmall?.color
                                          ?.withOpacity(0.7),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Delete button for list owners
                          if (isListOwner) ...[
                            const SizedBox(width: Dimensions.smallPadding),
                            CustomButton(
                              semanticLabel: LocaleKeys
                                  .common_semantic_delete_bookmark
                                  .tr(),
                              onPressed: () {
                                listsCubit.removeItemFromList(item: item);
                                CustomSnackbar.success(
                                  context,
                                  LocaleKeys.book_lists_sheet_delete.tr(),
                                  onRevert: () {
                                    listsCubit.undoSoftRemoval();
                                  },
                                );
                              },
                              icon: CustomIcons.delete_forever,
                              backgroundColor: CustomColors.red,
                              iconColor: CustomColors.white,
                              size: 36,
                              iconSize: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
