import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/features/bookmarks/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/features/bookmarks/widgets/bookmark_listener.dart';
import 'package:wolnelektury/src/features/common/widgets/bookmarks/create_bookmark_widget.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryBookmarksEditSheet extends StatelessWidget {
  final BookmarkModel bookmark;

  const MyLibraryBookmarksEditSheet({super.key, required this.bookmark});

  static void show({
    required BuildContext context,
    required BookmarkModel bookmark,
    required Function(BookmarkModel) onEditSuccess,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      builder: (builderContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(builderContext).bottom,
        ),
        child: BlocProvider.value(
          value: context.read<BookmarksCubit>()..setEditingBookmark(bookmark),
          child: BlocListener<BookmarksCubit, BookmarksState>(
            listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
            listener: (context, state) {
              if (state.isBookmarkSuccess?.$2 == true) {
                Navigator.of(context).pop();

                final newBookmark = state.getBookmarkByLocation(
                  bookmark.location,
                );
                if (newBookmark != null && newBookmark != bookmark) {
                  onEditSuccess(newBookmark);
                }
              }
            },
            child: MyLibraryBookmarksEditSheet(bookmark: bookmark),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkCubit = context.read<BookmarksCubit>();
    return BookmarkListener(
      child: SafeArea(
        top: false,
        bottom: true,
        child: CreateBookmarkWidget(
          onDelete: () {
            bookmarkCubit.deleteBookmarkInstantly();
          },
          bookmark: bookmark,
          onUpdate: (note) {
            bookmarkCubit.updateBookmark(note: note);
          },
          onGoBack: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
