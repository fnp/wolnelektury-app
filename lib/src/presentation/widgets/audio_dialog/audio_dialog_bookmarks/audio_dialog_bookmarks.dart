import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/create_bookmark_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_bookmark_listener.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogBookmarks extends StatelessWidget {
  const AudioDialogBookmarks({super.key});

  @override
  Widget build(BuildContext context) {
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    final bookmarksCubit = BlocProvider.of<BookmarksCubit>(context);
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.modalsBorderRadius),
      child: BookmarkListener(
        scaffoldMessengerKey: AudioDialog.messengerKey,
        child: BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (p, c) => p.isBookmarksOpened != c.isBookmarksOpened,
          builder: (context, state) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: CustomColors.primaryYellowColor,
                borderRadius: BorderRadius.circular(
                  Dimensions.modalsBorderRadius,
                ),
              ),
              child: AnimatedBoxFade(
                duration: const Duration(milliseconds: 500),
                collapsedChild: const SizedBox.shrink(),
                isChildVisible: state.isBookmarksOpened,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: size.height * 0.66,
                    width: double.infinity,
                    child: Column(
                      children: [
                        CreateBookmarkWidget(
                          onCreate: (note) {
                            if (state.book == null) return;
                            final cubit = context.read<AudioCubit>();
                            final currentPosition = cubit.state.statePosition;
                            bookmarksCubit.createAudioBookmark(
                              slug: cubit.state.book!.slug,
                              timestamp: currentPosition,
                              note: note,
                            );
                          },
                          onDelete: () {},
                          onUpdate: (_) {},
                          onGoBack: () {
                            audioCubit.toggleBookmarks(false);
                          },
                          autofocus: true,
                          maxHeight: 180,
                        ),
                        const SizedBox(height: Dimensions.mediumPadding),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.mediumPadding,
                            ),
                            child: _ListOfExistingBookmarks(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListOfExistingBookmarks extends StatelessWidget {
  const _ListOfExistingBookmarks();

  @override
  Widget build(BuildContext context) {
    final book = BlocProvider.of<AudioCubit>(context).state.book;
    if (book == null) {
      return const SizedBox.shrink();
    }
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (p, c) {
        return p.isLoading != c.isLoading ||
            p.isBookmarkSuccess != c.isBookmarkSuccess;
      },
      builder: (context, state) {
        final effectiveBookmarks = state.isLoading
            ? [BookmarkModel.skeletonized()]
            : state.bookmarks;

        return Skeletonizer(
          enableSwitchAnimation: true,
          containersColor: CustomColors.grey,
          enabled: state.isLoading,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final isLast = index == effectiveBookmarks.length - 1;
              final isFirst = index == 0;
              return Padding(
                padding: EdgeInsets.only(
                  top: isFirst ? Dimensions.veryLargePadding : 0,
                  bottom: isLast ? Dimensions.spacer : 0,
                ),
                child: BookmarkWidget(
                  bookmark: effectiveBookmarks[index],
                  book: book,
                  isLoading: state.isLoading,
                  backgroundColor: CustomColors.grey,
                  messengerKey: AudioDialog.messengerKey,
                  onListen: (int? timestamp, bool isPlaying) {
                    final audioCubit = context.read<AudioCubit>();
                    if (isPlaying) {
                      audioCubit.seekToLocallySelectedPosition(
                        optionalSeconds: timestamp,
                      );
                    } else {
                      audioCubit.stop();
                      audioCubit.play(overridenPosition: timestamp);
                    }
                    audioCubit.toggleBookmarks(false);
                  },
                ),
              );
            },
            itemCount: effectiveBookmarks.length,
          ),
        );
      },
    );
  }
}
