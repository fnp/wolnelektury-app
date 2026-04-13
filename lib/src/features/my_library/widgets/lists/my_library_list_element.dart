import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/books/widgets/book_page_cover/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/features/lists/cubits/lists_cubit/lists_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

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
    return !state.isBookInList(item.listSlug, item.bookSlug!) ||
        (state.softDeletedItem?.uuid == item.uuid &&
            state.softDeletedItem?.listSlug == item.listSlug);
  }

  @override
  Widget build(BuildContext context) {
    if (item.bookSlug == null) {
      return const SizedBox.shrink();
    }
    return BlocProvider(
      create: (context) {
        return SingleBookCubit(get.get(), get.get())
          ..getBookData(slug: item.bookSlug!);
      },
      child: BlocBuilder<SingleBookCubit, SingleBookState>(
        buildWhen: (p, c) {
          return p.book != c.book || p.isLoading != c.isLoading;
        },
        builder: (context, state) {
          if (!state.isLoading && state.book == null) {
            return const SizedBox.shrink();
          }
          final listsCubit = context.read<ListsCubit>();
          return BlocBuilder<ListsCubit, ListsState>(
            buildWhen: (p, c) {
              return p.softDeletedItem != c.softDeletedItem ||
                  p.isBookInList(item.listSlug, item.bookSlug!) !=
                      c.isBookInList(item.listSlug, item.bookSlug!);
            },
            builder: (context, innerState) {
              final shouldHide = determineVisibility(innerState);

              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: defaultCurve,
                child: shouldHide
                    ? const SizedBox(width: double.infinity)
                    : Skeletonizer(
                        enableSwitchAnimation: true,
                        enabled: state.isLoading,
                        child: BookPageCoverWithButtons.listItem(
                          key: ValueKey(item.bookSlug),
                          item: item,
                          onDelete: isListOwner
                              ? () {
                                  listsCubit.deleteItemFromList(item: item);
                                  CustomSnackbar.success(
                                    context,
                                    LocaleKeys.book_lists_sheet_delete.tr(),
                                    onRevert: () {
                                      listsCubit.undoSoftRemoval();
                                    },
                                  );
                                }
                              : null,
                          book: state.isLoading
                              ? BookModel.empty()
                              : state.book!,
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Bookmark list element implementation (empty for now)
class _MyLibraryListBookmarkElement extends MyLibraryListElement {
  const _MyLibraryListBookmarkElement({
    super.key,
    required super.item,
    required super.listName,
    required super.isListOwner,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement bookmark list element
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: defaultCurve,
      child: Skeletonizer(
        enableSwitchAnimation: true,
        enabled: false,
        child: Container(
          height: 100,
          color: Colors.grey[200],
          child: const Center(child: Text('Bookmark element - TODO')),
        ),
      ),
    );
  }
}
