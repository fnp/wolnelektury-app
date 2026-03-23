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
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryListBook extends StatelessWidget {
  final ListItemModel item;
  final String listName;
  final bool isListOwner;
  const MyLibraryListBook({
    super.key,
    required this.item,
    required this.listName,
    required this.isListOwner,
  });

  bool determineVisibility(ListCreatorState state) {
    return !state.isBookInList(item.listSlug, item.bookSlug!) ||
        (state.itemToRemoveFromList?.uuid == item.uuid &&
            state.itemToRemoveFromList?.listSlug == item.listSlug);
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
          final cubit = BlocProvider.of<ListCreatorCubit>(context);
          return BlocBuilder<ListCreatorCubit, ListCreatorState>(
            buildWhen: (p, c) {
              return p.itemToRemoveFromList != c.itemToRemoveFromList ||
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
                    : Padding(
                        padding: const EdgeInsets.only(
                          bottom: Dimensions.spacer,
                        ),
                        child: Skeletonizer(
                          enableSwitchAnimation: true,
                          enabled: state.isLoading,
                          child: BookPageCoverWithButtons(
                            key: ValueKey(item.bookSlug),
                            onDelete: isListOwner
                                ? () {
                                    cubit.removeItemFromList(item: item);
                                    CustomSnackbar.success(
                                      context,
                                      LocaleKeys.book_lists_sheet_delete.tr(),
                                      onRevert: () {
                                        cubit.undoRemoveItemFromList();
                                      },
                                    );
                                  }
                                : null,
                            book: state.isLoading
                                ? BookModel.empty()
                                : state.book!,
                          ),
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
