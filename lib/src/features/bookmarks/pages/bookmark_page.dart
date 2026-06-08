import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/features/bookmarks/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/features/common/widgets/bookmarks/bookmark_widget.dart';
import 'package:wolnelektury/src/features/common/widgets/page_subtitle.dart';
import 'package:wolnelektury/src/utils/audio/on_listen.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class BookmarkPage extends StatelessWidget {
  final String? uuid;
  const BookmarkPage({super.key, required this.uuid});

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
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: defaultCurve,
              switchOutCurve: defaultCurve,
              child: state.isLoading
                  ? const Center(child: CustomLoader())
                  : state.bookmarks.isEmpty
                  ? const _Failure()
                  : _Body(bookmark: state.bookmarks.first),
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

class _Body extends StatelessWidget {
  final BookmarkModel bookmark;
  const _Body({required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageSubtitle(
          subtitle: LocaleKeys.common_bookmark_page_title.tr(
            namedArgs: {'bookTitle': bookmark.book.title},
          ),
        ),
        BookmarkWidget(
          isDeletable: false,
          bookmark: bookmark,
          isLoading: false,
          backgroundColor: CustomColors.primaryYellowColor,
          onListen: (int? timestamp, bool isPlaying) {
            onListen(
              timestamp: timestamp,
              isPlaying: isPlaying,
              context: context,
              slug: bookmark.book.slug,
              book: bookmark.book,
            );
          },
        ),
      ],
    );
  }
}
