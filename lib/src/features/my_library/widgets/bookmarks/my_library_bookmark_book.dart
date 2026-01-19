import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/audiobooks/widgets/audio_dialog.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/features/my_library/widgets/bookmarks/my_library_bookmarks_edit_sheet.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class MyLibraryBookmarkBook extends HookWidget {
  final BookmarkModel bookmark;
  final bool isLoading;
  const MyLibraryBookmarkBook({
    super.key,
    required this.bookmark,
    required this.isLoading,
  });

  void onListen({
    required int? timestamp,
    required bool isPlaying,
    required BuildContext context,
  }) {
    if (timestamp == null) {
      return;
    }
    final audioCubit = context.read<AudioCubit>();
    AudioDialog.show(context: context, slug: bookmark.slug);
    if (isPlaying && audioCubit.state.book?.slug == bookmark.slug) {
      audioCubit.seekToLocallySelectedPosition(optionalSeconds: timestamp);
    } else {
      final singleBookCubit = context.read<SingleBookCubit>();
      singleBookCubit
        ..getBookData(
          slug: bookmark.slug,
          onFinished: (book, isOffline) {
            audioCubit.pickBook(
              book,
              targetTimestamp: timestamp,
              tryOffline: isOffline,
            );
          },
        )
        ..checkIfMediaAreDownloaded(bookmark.slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBookmark = useState<BookmarkModel>(bookmark);

    useEffect(() {
      effectiveBookmark.value = bookmark;
      return null;
    }, [bookmark]);

    return BlocProvider(
      key: ValueKey(isLoading.hashCode),
      create: (context) {
        final singleBookCubit = SingleBookCubit(get.get(), get.get());
        if (isLoading) {
          return singleBookCubit;
        }
        return singleBookCubit
          ..getBookData(slug: bookmark.slug)
          ..checkIfMediaAreDownloaded(bookmark.slug);
      },
      child: BlocBuilder<SingleBookCubit, SingleBookState>(
        buildWhen: (p, c) {
          return p.book != c.book ||
              p.isLoading != c.isLoading ||
              p.isAudiobookDownloaded != c.isAudiobookDownloaded ||
              p.isReaderDownloaded != c.isReaderDownloaded;
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
              bookmark: effectiveBookmark.value,
              book: effectiveLoading ? skeletonizedBook : state.book!,
              isLoading: effectiveLoading,
              backgroundColor: CustomColors.primaryYellowColor,
              onListen: (int? timestamp, bool isPlaying) {
                onListen(
                  timestamp: timestamp,
                  isPlaying: isPlaying,
                  context: context,
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
