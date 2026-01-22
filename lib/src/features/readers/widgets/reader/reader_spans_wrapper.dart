import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/features/bookmarks/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/features/readers/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/features/readers/widgets/paragraph_sheet/reading_page_paragraph_sheet.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_indent.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';

class ReaderSpansWrapper extends StatelessWidget {
  final ReaderBookModelContent element;
  final String fontFamily;
  final double fontSize;
  final double fontHeight;
  const ReaderSpansWrapper({
    required this.element,
    required this.fontFamily,
    required this.fontSize,
    required this.fontHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: element.visibleNumber != null
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${element.visibleNumber}',
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
                    fontHeight: fontHeight,
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
        SizedBox(width: 40, child: _Bookmark(paragraphId: element.id)),
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
  final String? paragraphId;
  const _Bookmark({this.paragraphId});

  @override
  Widget build(BuildContext context) {
    if (paragraphId == null) return const SizedBox.shrink();
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (p, c) => p.bookmarks != c.bookmarks,
      builder: (context, state) {
        final bookmark = state.bookmarks.firstWhereOrNull(
          (element) => element.anchor == paragraphId,
        );
        if (bookmark == null) {
          return const SizedBox.shrink();
        }
        final readingPageCubit = BlocProvider.of<ReadingPageCubit>(context);
        final bookmarkCubit = BlocProvider.of<BookmarksCubit>(context);
        return GestureDetector(
          onTap: () {
            bookmarkCubit.setEditingBookmark(bookmark);
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
