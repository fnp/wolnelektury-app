import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/single_book/single_book_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_dialog.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookmarkPage extends StatelessWidget {
  final String? uuid;
  const BookmarkPage({super.key, required this.uuid});

  void onListen({
    required int? timestamp,
    required bool isPlaying,
    required BuildContext context,
    required BookmarkModel bookmark,
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
            audioCubit
                .pickBook(
                  book,
                  overrideProgressTimestamp: timestamp,
                  tryOffline: isOffline,
                )
                .then((_) {
                  audioCubit.play(overridenPosition: timestamp);
                });
          },
        )
        ..checkIfMediaAreDownloaded(bookmark.slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (uuid == null) {
      return const _Failure();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: BlocProvider(
        create: (context) {
          return BookmarksCubit(get.get())..getBookmarkById(uuid: uuid!);
        },
        child: BlocBuilder<BookmarksCubit, BookmarksState>(
          buildWhen: (p, c) {
            return p.bookmarks != c.bookmarks || p.isLoading != c.isLoading;
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final bookmark = state.bookmarks.firstOrNull;
            if (bookmark == null) {
              return const _Failure();
            }
            return BlocProvider(
              create: (context) {
                return SingleBookCubit(get.get(), get.get())
                  ..getBookData(slug: bookmark.slug);
              },
              child: BlocBuilder<SingleBookCubit, SingleBookState>(
                buildWhen: (p, c) {
                  return p.book != c.book || p.isLoading != c.isLoading;
                },
                builder: (context, state) {
                  final skeletonizedBook = BookModel.empty();
                  if (!state.isLoading && state.book == null) {
                    return const _Failure();
                  }
                  return Column(
                    children: [
                      const PageSubtitle(subtitle: 'Udostępniona zakładka'),
                      BookmarkWidget(
                        isDeletable: false,
                        bookmark: bookmark,
                        book: state.book ?? skeletonizedBook,
                        isLoading: state.isLoading,
                        backgroundColor: CustomColors.primaryYellowColor,
                        onListen: (int? timestamp, bool isPlaying) {
                          onListen(
                            timestamp: timestamp,
                            isPlaying: isPlaying,
                            context: context,
                            bookmark: bookmark,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.largePadding,
        ),
        child: Text(
          LocaleKeys.common_bookmark_page_error.tr(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
