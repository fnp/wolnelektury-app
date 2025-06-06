import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';
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
        return SingleBookCubit(get.get())..loadBookData(slug: bookSlug);
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
              return p.isBookInList(listName, bookSlug) !=
                  c.isBookInList(listName, bookSlug);
            },
            builder: (context, innerState) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: innerState.isBookInList(listName, bookSlug)
                    ? Padding(
                        padding: const EdgeInsets.only(top: Dimensions.spacer),
                        child: Skeletonizer(
                          enabled: state.isLoading,
                          child: BookPageCoverWithButtons(
                            key: ValueKey(bookSlug),
                            onDelete: () {
                              cubit.removeBookFromList(
                                listSlug: listSlug,
                                bookSlug: bookSlug,
                              );
                            },
                            book: state.isLoading
                                ? BookModel.empty()
                                : state.book!,
                          ),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              );
            },
          );
        },
      ),
    );
  }
}
