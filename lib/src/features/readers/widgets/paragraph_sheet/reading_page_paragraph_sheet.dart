import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/features/audiobooks/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/features/audiobooks/widgets/audio_dialog.dart';
import 'package:wolnelektury/src/features/bookmarks/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/features/books/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/features/common/cubits/scroll/scroll_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/features/common/widgets/auth_wrapper.dart';
import 'package:wolnelektury/src/features/common/widgets/bookmarks/create_bookmark_widget.dart';
import 'package:wolnelektury/src/features/common/widgets/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/features/common/widgets/connectivity_wrapper.dart';
import 'package:wolnelektury/src/features/readers/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/utils/share/share_utils.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageParagraphSheet extends StatelessWidget {
  const ReadingPageParagraphSheet({super.key});

  static void show({required BuildContext context, VoidCallback? onClosed}) {
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ReadingPageCubit>()),
            BlocProvider.value(value: context.read<BookmarksCubit>()),
            BlocProvider.value(value: context.read<AudioCubit>()),
            BlocProvider.value(value: context.read<ScrollCubit>()),
            BlocProvider.value(value: context.read<AuthCubit>()),
            BlocProvider(
              create: (context) {
                return SingleBookCubit(get.get(), get.get());
              },
            ),
          ],
          child: const ReadingPageParagraphSheet(),
        ),
      ),
    ).then((_) {
      onClosed?.call();
    });
  }

  void onListen({
    required int timestamp,
    required BuildContext context,
    required String slug,
  }) {
    final audioCubit = context.read<AudioCubit>();
    final isPlaying = audioCubit.state.isPlaying;
    AudioDialog.show(context: context, slug: slug);
    if (isPlaying && audioCubit.state.book?.slug == slug) {
      audioCubit.seekToLocallySelectedPosition(optionalSeconds: timestamp);
    } else {
      final singleBookCubit = context.read<SingleBookCubit>();
      singleBookCubit
        ..getBookData(
          slug: slug,
          onFinished: (book, isOffline) {
            audioCubit.pickBook(
              book,
              targetTimestamp: timestamp,
              tryOffline: isOffline,
            );
          },
        )
        ..checkIfMediaAreDownloaded(slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    final readingPageCubit = BlocProvider.of<ReadingPageCubit>(context);
    final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
    final selectedParagraph = readingPageCubit.state.selectedParagraph;
    return SafeArea(
      bottom: true,
      top: false,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: BlocListener<BookmarksCubit, BookmarksState>(
          listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
          listener: (context, state) {
            if (state.isBookmarkSuccess?.$2 == true) {
              readingPageCubit.toggleIsAddingBookmark();
              readingPageCubit.selectParagraph();
              bookmarkCubit.setEditingBookmark(null);
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ReadingPageCubit, ReadingPageState>(
            buildWhen: (p, c) => p.isAddingBookmark != c.isAddingBookmark,
            builder: (context, state) {
              return AnimatedBoxFade(
                isChildVisible: !state.isAddingBookmark,
                collapsedChild: const _BookmarkNote(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.mediumPadding,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: Dimensions.veryLargePadding),
                        //todo
                        // TextButtonWithIcon(
                        //   nonActiveText: 'przetłumacz (todo)',
                        //   nonActiveIcon: Icons.translate,
                        //   onPressed: () {},
                        //   activeColor: CustomColors.white,
                        // ),
                        // const SizedBox(height: Dimensions.mediumPadding),
                        _BookmarksWrapper(
                          child: (isAuth) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButtonWithIcon(
                                  nonActiveText: LocaleKeys
                                      .reading_sheet_bookmark_add
                                      .tr(),
                                  nonActiveIcon: Icons.bookmark_add_rounded,
                                  onPressed: () {
                                    if (!isAuth) {
                                      Navigator.of(context).pop();
                                      CustomSnackbar.loginRequired(context);
                                      return;
                                    }

                                    readingPageCubit.toggleIsAddingBookmark();
                                    final isBookmarked = bookmarkCubit.state
                                        .isSelectedParagraphBookmarked(
                                          selectedParagraph?.id,
                                        );
                                    bookmarkCubit.setEditingBookmark(
                                      isBookmarked,
                                    );
                                  },
                                  activeColor: CustomColors.white,
                                ),
                                const SizedBox(
                                  height: Dimensions.mediumPadding,
                                ),
                              ],
                            );
                          },
                        ),
                        _ListeningWrapper(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButtonWithIcon(
                                nonActiveText: LocaleKeys.reading_sheet_listen
                                    .tr(),
                                nonActiveIcon: Icons.headphones,
                                onPressed: () {
                                  if (selectedParagraph?.id == null) {
                                    return;
                                  }
                                  final timestamp = state.getTimestampForId(
                                    selectedParagraph!.id!,
                                  );
                                  if (timestamp == null) {
                                    return;
                                  }
                                  readingPageCubit.enableHighlighting(true);
                                  Navigator.of(context).pop();
                                  onListen(
                                    timestamp: timestamp.floor(),
                                    context: context,
                                    slug: readingPageCubit.state.currentSlug!,
                                  );
                                },
                                activeColor: CustomColors.white,
                              ),
                              const SizedBox(height: Dimensions.mediumPadding),
                            ],
                          ),
                        ),
                        TextButtonWithIcon(
                          nonActiveText: LocaleKeys.reading_sheet_share.tr(),
                          nonActiveIcon: Icons.ios_share,
                          onPressed: () {
                            ShareUtils.shareParagraph(
                              selectedParagraph?.id ?? '',
                              readingPageCubit.state.currentSlug ?? '',
                            );
                          },
                          activeColor: CustomColors.white,
                        ),
                        const SizedBox(height: Dimensions.spacer * 2),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BookmarkNote extends StatelessWidget {
  const _BookmarkNote();

  @override
  Widget build(BuildContext context) {
    final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
    final readingPageCubit = BlocProvider.of<ReadingPageCubit>(context);
    final anchorId = readingPageCubit.state.selectedParagraph?.id;
    final slug = readingPageCubit.state.currentSlug;
    return CreateBookmarkWidget(
      lines: 5,
      bookmark: bookmarkCubit.state.editingBookmark,
      onGoBack: () {
        readingPageCubit.toggleIsAddingBookmark();
      },
      onDelete: () {
        bookmarkCubit.deleteBookmarkInstantly();
      },
      onCreate: (note) {
        if (anchorId == null || slug == null) {
          return;
        }
        bookmarkCubit.createTextBookmark(
          slug: slug,
          anchor: anchorId,
          note: note,
        );
      },
      onUpdate: (note) {
        bookmarkCubit.updateBookmark(note: note);
      },
    );
  }
}

class _ListeningWrapper extends StatelessWidget {
  final Widget child;
  const _ListeningWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      builder: (context, hasConnection) {
        if (!hasConnection) {
          return const SizedBox.shrink();
        }
        return BlocBuilder<ReadingPageCubit, ReadingPageState>(
          buildWhen: (p, c) {
            return p.audioSyncPairs != c.audioSyncPairs;
          },
          builder: (context, state) {
            if (state.audioSyncPairs.isEmpty) {
              return const SizedBox.shrink();
            }
            return child;
          },
        );
      },
    );
  }
}

class _BookmarksWrapper extends StatelessWidget {
  final Widget Function(bool isAuthenticated) child;
  const _BookmarksWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      builder: (context, hasConnection) {
        if (!hasConnection) {
          return const SizedBox.shrink();
        }
        return AuthWrapper(
          child: (isAuthenticated) {
            return child(isAuthenticated);
          },
        );
      },
    );
  }
}
