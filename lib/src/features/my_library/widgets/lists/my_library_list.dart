import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_book.dart';
import 'package:wolnelektury/src/features/my_library/widgets/lists/my_library_list_header.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryList extends StatelessWidget {
  final BookListModel bookList;
  final bool isCompact;
  final bool isListOwner;
  final bool isOnListPage;

  const MyLibraryList({
    super.key,
    required this.bookList,
    required this.isCompact,
    this.isListOwner = true,
  }) : isOnListPage = !isCompact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) {
        return p.doesLocalListExistsAlready(bookList.slug) !=
            c.doesLocalListExistsAlready(bookList.slug);
      },
      builder: (context, state) {
        final isExisting =
            state.doesLocalListExistsAlready(bookList.slug) ||
            state.fetchedSingleList?.slug == bookList.slug;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: defaultCurve,
          alignment: Alignment.topCenter,
          child: isExisting
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: Dimensions.largePadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyLibraryListHeader(
                        bookList: bookList,
                        isListOwner: isListOwner,
                        isCompact: isCompact,
                        isOnListPage: isOnListPage,
                      ),
                      if (bookList.books.isNotEmpty && !isCompact) ...[
                        _List(bookList: bookList, isListOwner: isListOwner),
                      ],
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity),
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  final BookListModel bookList;
  final bool isListOwner;
  const _List({required this.bookList, required this.isListOwner});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return MyLibraryListBook(
          key: ValueKey(bookList.books[index]),
          bookSlug: bookList.books[index],
          listSlug: bookList.slug,
          listName: bookList.name,
          isListOwner: isListOwner,
        );
      },
      itemCount: bookList.books.length,
    );
  }
}
