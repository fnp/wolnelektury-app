import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryListBook extends StatelessWidget {
  final String bookSlug;
  final String listSlug;
  final String listName;
  const MyLibraryListBook({
    super.key,
    required this.bookSlug,
    required this.listSlug,
    required this.listName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SingleBookCubit(get.get(), get.get())
          ..loadBookData(slug: bookSlug);
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
              return p.bookToRemoveFromList != c.bookToRemoveFromList ||
                  p.isBookInList(listName, bookSlug) !=
                      c.isBookInList(listName, bookSlug);
            },
            builder: (context, innerState) {
              final shouldHide =
                  !innerState.isBookInList(listName, bookSlug) ||
                  (innerState.bookToRemoveFromList?.$1 == listSlug &&
                      innerState.bookToRemoveFromList?.$2 == bookSlug);
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: shouldHide
                    ? const SizedBox(width: double.infinity)
                    : Padding(
                        padding: const EdgeInsets.only(top: Dimensions.spacer),
                        child: Skeletonizer(
                          enableSwitchAnimation: true,
                          enabled: state.isLoading,
                          child: BookPageCoverWithButtons(
                            key: ValueKey(bookSlug),
                            onDelete: () {
                              cubit.removeBookFromList(
                                listSlug: listSlug,
                                bookSlug: bookSlug,
                              );
                              CustomSnackbar.success(
                                context,
                                LocaleKeys.book_lists_sheet_delete.tr(),
                                onRevert: () {
                                  cubit.undoRemoveBookFromList();
                                },
                              );
                            },
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
