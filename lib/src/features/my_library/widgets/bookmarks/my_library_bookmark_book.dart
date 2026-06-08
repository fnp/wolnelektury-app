import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/features/my_library/widgets/bookmarks/my_library_bookmarks_edit_sheet.dart';
import 'package:wolnelektury/src/utils/audio/on_listen.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class MyLibraryBookmarkBook extends HookWidget {
  final BookmarkModel bookmark;
  final bool isLoading;
  const MyLibraryBookmarkBook({
    super.key,
    required this.bookmark,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBookmark = useState<BookmarkModel>(bookmark);

    useEffect(() {
      effectiveBookmark.value = bookmark;
      return null;
    }, [bookmark]);

    return BlocProvider(
      create: (context) {
        return SingleBookCubit(get.get(), get.get())
          ..checkIfMediaAreDownloaded(bookmark.book.slug);
      },
      child: BlocBuilder<SingleBookCubit, SingleBookState>(
        buildWhen: (p, c) {
          return p.isAudiobookDownloaded != c.isAudiobookDownloaded ||
              p.isReaderDownloaded != c.isReaderDownloaded;
        },
        builder: (context, state) {
          return Skeletonizer(
            enableSwitchAnimation: true,
            enabled: isLoading,
            containersColor: CustomColors.lightGrey,
            child: BookmarkWidget(
              bookmark: effectiveBookmark.value,
              isLoading: isLoading,
              backgroundColor: CustomColors.primaryYellowColor,
              onListen: (int? timestamp, bool isPlaying) {
                onListen(
                  timestamp: timestamp,
                  isPlaying: isPlaying,
                  context: context,
                  book: effectiveBookmark.value.book,
                  slug: effectiveBookmark.value.book.slug,
                );
              },
              onEdit: () {
                MyLibraryBookmarksEditSheet.show(
                  context: context,
                  bookmark: effectiveBookmark.value,
                  onEditSuccess: (bookmark) {
                    effectiveBookmark.value = bookmark;
                  },
                );
              },
              isAudioAvailableOffline: state.isAudiobookDownloaded,
              isReaderAvailableOffline: state.isReaderDownloaded,
            ),
          );
        },
      ),
    );
  }
}
