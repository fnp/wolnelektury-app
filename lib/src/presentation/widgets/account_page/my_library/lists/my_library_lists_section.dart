import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/lists/my_library_list.dart';
import 'package:wolnelektury/src/presentation/widgets/book_lists/book_lists_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryListsSection extends StatelessWidget {
  const MyLibraryListsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: BlocListener<ListCreatorCubit, ListCreatorState>(
        listenWhen: (p, c) {
          return p.isAddingFailure != c.isAddingFailure ||
              p.isDeleteFailure != c.isDeleteFailure ||
              p.isRemovingBookFailure != c.isRemovingBookFailure;
        },
        listener: (context, state) {
          if (state.isAddingFailure) {
            CustomSnackbar.error(
              context,
              LocaleKeys.my_library_lists_creation_failure.tr(),
            );
            return;
          }
          if (state.isDeleteFailure) {
            CustomSnackbar.error(
              context,
              LocaleKeys.my_library_lists_deletion_failure.tr(),
            );
            return;
          }
          if (state.isRemovingBookFailure) {
            CustomSnackbar.error(
              context,
              LocaleKeys.my_library_lists_book_removal_failure.tr(),
            );
            return;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PageSubtitle(subtitle: MyLibraryEnum.lists.title),
            AddNewListElement(
              onSave: (text) {
                BlocProvider.of<ListCreatorCubit>(
                  context,
                ).addEmptyList(name: text);
              },
            ),
            const SizedBox(height: Dimensions.spacer),
            Expanded(
              child: CustomScrollPage(
                onLoadMore: () {
                  BlocProvider.of<ListCreatorCubit>(context).loadMoreLists();
                },
                builder: (scrollController) {
                  return BlocBuilder<ListCreatorCubit, ListCreatorState>(
                    buildWhen: (p, c) {
                      return p.isLoading != c.isLoading ||
                          p.isAdding != c.isAdding ||
                          p.pendingList != c.pendingList;
                    },
                    builder: (context, state) {
                      final isPending = state.pendingList != null;
                      final effLength = state.isAdding
                          ? state.allLists.length + 1
                          : state.allLists.length;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: effLength,
                        itemBuilder: (context, index) {
                          if (index == 0 && state.isAdding) {
                            return AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn,
                              child: isPending
                                  ? MyLibraryList(bookList: state.pendingList!)
                                  : const SizedBox(),
                            );
                          }

                          final effIndex = state.isAdding ? index - 1 : index;

                          return MyLibraryList(
                            key: ValueKey(state.allLists[effIndex].slug),
                            bookList: state.allLists[effIndex],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
