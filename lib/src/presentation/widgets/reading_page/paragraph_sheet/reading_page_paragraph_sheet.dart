import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/bookmarks/create_bookmark_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/text_button_with_icon.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ReadingPageParagraphSheet extends StatelessWidget {
  const ReadingPageParagraphSheet({super.key});

  static void show({required BuildContext context, VoidCallback? onClosed}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ReadingPageCubit>()),
          BlocProvider.value(value: context.read<BookmarksCubit>()),
        ],
        child: const ReadingPageParagraphSheet(),
      ),
    ).then((_) {
      onClosed?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final readingPageCubit = BlocProvider.of<ReadingPageCubit>(context);
    final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: BlocListener<BookmarksCubit, BookmarksState>(
        listenWhen: (p, c) => p.isBookmarkSuccess != c.isBookmarkSuccess,
        listener: (context, state) {
          if (state.isBookmarkSuccess != null &&
              state.isBookmarkSuccess!.$2 == true) {
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
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.mediumPadding),
                  child: Column(
                    spacing: Dimensions.mediumPadding,
                    children: [
                      TextButtonWithIcon(
                        nonActiveText: 'przetłumacz (todo)',
                        nonActiveIcon: Icons.translate,
                        onPressed: () {},
                        activeColor: CustomColors.white,
                      ),
                      TextButtonWithIcon(
                        nonActiveText: LocaleKeys.reading_sheet_bookmark_add
                            .tr(),
                        nonActiveIcon: Icons.bookmark_add_rounded,
                        onPressed: () {
                          readingPageCubit.toggleIsAddingBookmark();
                          final isBookmarked = bookmarkCubit.state
                              .isSelectedParagraphBookmarked(
                                readingPageCubit
                                    .state
                                    .selectedParagraph
                                    ?.paragraphIndex,
                              );
                          bookmarkCubit.setEditingBookmark(isBookmarked);
                        },
                        activeColor: CustomColors.white,
                      ),
                      TextButtonWithIcon(
                        nonActiveText: 'zapisz cytat',
                        nonActiveIcon: Icons.format_quote_rounded,
                        onPressed: () {},
                        activeColor: CustomColors.white,
                      ),
                      TextButtonWithIcon(
                        nonActiveText: 'słuchaj',
                        nonActiveIcon: Icons.headphones,
                        onPressed: () {},
                        activeColor: CustomColors.white,
                      ),
                      TextButtonWithIcon(
                        nonActiveText: 'udostępnij',
                        nonActiveIcon: Icons.ios_share,
                        onPressed: () {},
                        activeColor: CustomColors.white,
                      ),
                    ],
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

class _BookmarkNote extends StatelessWidget {
  const _BookmarkNote();

  @override
  Widget build(BuildContext context) {
    final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
    final readingPageCubit = BlocProvider.of<ReadingPageCubit>(context);
    final anchorId = readingPageCubit.state.selectedParagraph?.paragraphIndex;
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
          anchor: anchorId.toString(),
          note: note,
        );
      },
      onUpdate: (note) {
        bookmarkCubit.updateBookmark(note: note);
      },
    );
  }
}
