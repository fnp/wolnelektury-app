import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/book_page/book_page_cover_with_buttons.dart';

class MyLibraryLikedBook extends StatelessWidget {
  final String bookSlug;
  const MyLibraryLikedBook({super.key, required this.bookSlug});

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
          return Skeletonizer(
            enabled: state.isLoading,
            child: BookPageCoverWithButtons(
              book: state.isLoading ? BookModel.empty() : state.book!,
            ),
          );
        },
      ),
    );
  }
}
