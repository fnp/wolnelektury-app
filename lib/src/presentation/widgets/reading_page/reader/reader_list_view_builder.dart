import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/bookmarks/bookmarks_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/paragraph_sheet/reading_page_paragraph_sheet.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_spans_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/reading_page/reader/reader_yellow_background.dart';
import 'package:wolnelektury/src/utils/reader/build_reader_base.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class ReaderListViewBuilder extends StatelessWidget {
  final ReadingPageState state;
  final ItemScrollController itemScrollController;
  const ReaderListViewBuilder({
    super.key,
    required this.state,
    required this.itemScrollController,
  });

  void onLongPress({
    required ReadingPageCubit cubit,
    required BookmarksCubit bookmarksCubit,
    required BuildContext context,
    int? index,
    ReaderBookModelContent? element,
  }) {
    HapticFeedback.selectionClick();
    cubit.selectParagraph(index: index, element: element);
    ReadingPageParagraphSheet.show(
      context: context,
      onClosed: () {
        bookmarksCubit.setEditingBookmark(null);
        cubit.selectParagraph();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    final bookmarksCubit = BlocProvider.of<BookmarksCubit>(context);
    final theme = Theme.of(context);
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1)),
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemCount: state.book!.contents.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _Header(state: state);
          }
          final element = state.book!.contents[index - 1];
          return InkWellWrapper(
            onLongPress: () => onLongPress(
              cubit: cubit,
              bookmarksCubit: bookmarksCubit,
              context: context,
              index: index,
              element: element,
            ),
            child: VisibilityDetector(
              key: ValueKey(element.hashCode),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0) {
                  cubit.setProgress(anchor: element.paragraphIndex);
                }
              },
              child: Stack(
                children: [
                  ReaderYellowBackground(index: index),
                  ReaderSpansWrapper(
                    element: element,
                    fontFamily: state.fontType.familyName,
                    fontSize: state.getFontSize(theme),
                    debugPrint: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ReadingPageState state;
  const _Header({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.veryLargePadding,
        children: [
          if (state.book!.headerLeft != null)
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: buildReaderBase(
                    theme: theme.copyWith(
                      textTheme: theme.textTheme.copyWith(
                        bodyMedium: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    element: state.book!.headerLeft!,
                    fontFamily: state.fontType.familyName,
                    fontSize: state.getFontSize(theme) + 2,
                  ),
                ),
              ),
            ),
          if (state.book!.headerRight != null)
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: buildReaderBase(
                    theme: Theme.of(context),
                    element: state.book!.headerRight!,
                    fontFamily: state.fontType.familyName,
                    fontSize: state.getFontSize(theme) - 2,
                  ),
                ),
                textAlign: TextAlign.end,
              ),
            ),
        ],
      ),
    );
  }
}
