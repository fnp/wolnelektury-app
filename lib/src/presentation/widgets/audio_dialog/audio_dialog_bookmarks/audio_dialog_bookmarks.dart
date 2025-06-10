import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/create_bookmark_widget.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class AudioDialogBookmarks extends StatefulWidget {
  const AudioDialogBookmarks({super.key});

  @override
  State<AudioDialogBookmarks> createState() => _AudioDialogBookmarksState();
}

class _AudioDialogBookmarksState extends State<AudioDialogBookmarks> {
  double maxSize = 250;

  void setSize(double newSize) {
    setState(() {
      maxSize = newSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AudioCubit>(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AudioCubit, AudioState>(
      buildWhen: (p, c) => p.isBookmarksOpened != c.isBookmarksOpened,
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: CustomColors.primaryYellowColor,
            borderRadius: BorderRadius.circular(Dimensions.modalsBorderRadius),
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
                      onTap: () {
                        setSize(250);
                      },
                      onDelete: () {},
                      onUpdate: (value) {},
                      onGoBack: () {
                        cubit.toggleBookmarks(false);
                      },
                      autofocus: true,
                      maxHeight: maxSize,
                    ),
                    const SizedBox(height: Dimensions.mediumPadding),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumPadding,
                        ),
                        child: Listener(
                          onPointerDown: (_) {
                            FocusScope.of(context).unfocus();
                            setSize(150);
                          },
                          child: const _ListOfExistingBookmarks(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
        return p.isLoading != c.isLoading;
      },
      builder: (context, state) {
        final effectiveBookmarks = state.isLoading
            ? [BookmarkModel.skeletonized()]
            : state.bookmarks;
        return Skeletonizer(
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
