import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/paragraph_sheet/reading_page_paragraph_sheet.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_indent.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class ReaderSpansWrapper extends StatelessWidget {
  final ReaderBookModelContent element;
  final String fontFamily;
  final double fontSize;
  final bool debugPrint;
  const ReaderSpansWrapper({
    super.key,
    required this.element,
    required this.fontFamily,
    required this.fontSize,
    required this.debugPrint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: element.paragraphIndex != null
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${element.paragraphIndex}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: CustomColors.darkModeGrey,
                    ),
                  ),
                )
              : null,
        ),
        Expanded(
          child: Padding(
            padding: _getPaddingByTag(element.tag),
            child: RichText(
              text: TextSpan(
                children: [
                  if (element.paragraphIndex != null)
                    const TextSpan(text: BuildReaderIndent.textIndent),
                  ...buildReaderBase(
                    theme: Theme.of(context),
                    element: element,
                    parent: element,
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                  ),
                ],
              ),
              //to dodaje przerwy na początku lub na końcu akapitu
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: false,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: _Bookmark(paragraphIndex: element.paragraphIndex),
        ),
      ],
    );
  }

  EdgeInsets _getPaddingByTag(ReaderBookTag tag) {
    switch (tag) {
      case ReaderBookTag.blockquote:
        return const EdgeInsets.symmetric(vertical: 10, horizontal: 20);
      default:
        return EdgeInsets.zero;
    }
  }
}

class _Bookmark extends StatelessWidget {
  final int? paragraphIndex;
  const _Bookmark({this.paragraphIndex});

  @override
  Widget build(BuildContext context) {
    if (paragraphIndex == null) return const SizedBox.shrink();
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (p, c) => p.bookmarks != c.bookmarks,
      builder: (context, state) {
        final isBookmarked = state.bookmarks.firstWhereOrNull(
          (element) => element.anchor == paragraphIndex.toString(),
        );
        if (isBookmarked == null) {
          return const SizedBox.shrink();
        }
        final readingPageCubit = BlocProvider.of<ReadingPageCubit>(context);
        final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
        return GestureDetector(
          onTap: () {
            bookmarkCubit.setEditingBookmark(isBookmarked);
            readingPageCubit.toggleIsAddingBookmark();
            ReadingPageParagraphSheet.show(
              context: context,
              onClosed: () {
                readingPageCubit.selectParagraph();
              },
            );
          },
          child: const Icon(
            Icons.bookmark,
            size: 20,
            color: CustomColors.primaryYellowColor,
          ),
        );
      },
    );
  }
}
