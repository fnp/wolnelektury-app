part of 'reading_page_cubit.dart';

@freezed
sealed class ReadingPageState with _$ReadingPageState {
  const factory ReadingPageState({
    String? currentSlug,
    @Default(0.5) double textSizeFactor,
    @Default(ReaderFontType.sans) ReaderFontType fontType,
    @Default(0) double fontHeightMultiplier,

    @Default(false) bool isJsonLoading,
    @Default(false) bool isJsonLoadingError,
    ReaderBookModel? book,

    // Audio sync pairs
    @Default([]) List<BookTextAudioSyncModel> audioSyncPairs,

    // ParagraphSheet
    int? selectedIndex,
    int? highlightedIndex,
    @Default(false) bool isEnabledHighlighting,
    ReaderBookModelContent? selectedParagraph,
    @Default(false) bool isAddingBookmark,

    // Progress
    ProgressModel? progress,

    // Visual progress in %
    @Default(0) int readTimeInSeconds,
    @Default(0) int visualProgress,
    @Default(false) bool isVisualProgressIncreasing,
  }) = _ReadingPageState;
}

extension ReadingPageStateX on ReadingPageState {
  int? findElementIndexByElementId(String elementId) {
    if (book == null) return null;
    final int index = book!.contents.indexWhere(
      (element) => element.containsElementId(elementId),
    );

    return index >= 0 ? index : null;
  }

  double? getTimestampForId(String id) {
    final pair = audioSyncPairs.firstWhereOrNull((pair) => pair.id == id);
    return pair?.timestamp;
  }

  bool shouldRebuild(ReadingPageState state) {
    return textSizeFactor != state.textSizeFactor ||
        book != state.book ||
        fontType != state.fontType ||
        fontHeightMultiplier != state.fontHeightMultiplier ||
        isJsonLoading != state.isJsonLoading;
  }

  double getFontSize(ThemeData theme) =>
      theme.textTheme.bodyMedium!.fontSize! * textSizeFactor +
      ReadingPageCubit._fontSizeMultiplier;

  double getLineHeight() {
    double effectiveFontHeight =
        ReadingPageCubit._baseFontHeight +
        (fontHeightMultiplier - ReadingPageSettingsFontHeight.minThreshold) / 2;
    return effectiveFontHeight;
  }

  int get remainingTimeInMinutes {
    final readTimeInMinutes = (readTimeInSeconds / 60).floor();
    final estimatedRemainingTime =
        ((100 - visualProgress) / 100 * readTimeInMinutes).ceil();
    return estimatedRemainingTime;
  }
}
