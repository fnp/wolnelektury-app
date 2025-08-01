import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class MyLibraryBookmarkBook extends StatelessWidget {
  final BookmarkModel bookmark;
  final bool isLoading;
  const MyLibraryBookmarkBook({
    super.key,
    required this.bookmark,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(isLoading.hashCode),
      create: (context) {
        final singleBookCubit = SingleBookCubit(get.get(), get.get());
        if (isLoading) {
          return singleBookCubit;
        }
        return singleBookCubit..loadBookData(slug: bookmark.slug);
      },
      child: BlocBuilder<SingleBookCubit, SingleBookState>(
        buildWhen: (p, c) {
          return p.book != c.book || p.isLoading != c.isLoading;
        },
        builder: (context, state) {
          final effectiveLoading = isLoading || state.isLoading;
          if (!effectiveLoading && state.book == null) {
            return const SizedBox.shrink();
          }
          final skeletonizedBook = BookModel.empty();
          return Skeletonizer(
            enableSwitchAnimation: true,
            enabled: effectiveLoading,
            containersColor: CustomColors.lightGrey,
            child: BookmarkWidget(
              bookmark: bookmark,
              book: effectiveLoading ? skeletonizedBook : state.book!,
              isLoading: effectiveLoading,
              backgroundColor: CustomColors.primaryYellowColor,
            ),
          );
        },
      ),
    );
  }
}
