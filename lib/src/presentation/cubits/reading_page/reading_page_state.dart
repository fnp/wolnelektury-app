part of 'reading_page_cubit.dart';

@freezed
sealed class ReadingPageState with _$ReadingPageState {
  const factory ReadingPageState({
    String? currentSlug,
    @Default(0.5) double textSizeFactor,
    @Default(ReaderFontType.sans) ReaderFontType fontType,
    @Default(false) bool isJsonLoading,
    ReaderBookModel? book,

    // ParagraphSheet
    int? selectedIndex,
    ReaderBookModelContent? selectedParagraph,
    @Default(false) bool isAddingBookmark,

    // Progress
    ProgressModel? progress,

    // Visual progress in %
    @Default(0) int visualProgress,
  }) = _ReadingPageState;
}

extension ReadingPageStateX on ReadingPageState {
  int? findElementIndexByParagraphIndex(int paragraphIndex) {
    if (book == null) return null;
    return book!.contents.indexWhere(
      (element) => element.paragraphIndex == paragraphIndex,
    );
  }

  bool shouldRebuild(ReadingPageState state) {
    return textSizeFactor != state.textSizeFactor ||
        book != state.book ||
        fontType != state.fontType ||
        isJsonLoading != state.isJsonLoading;
  }

  double getFontSize(ThemeData theme) =>
      theme.textTheme.bodyMedium!.fontSize! * textSizeFactor +
      ReadingPageCubit._fontSizeMultiplier;
}
