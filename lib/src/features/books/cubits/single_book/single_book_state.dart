part of 'single_book_cubit.dart';

@freezed
sealed class SingleBookState with _$SingleBookState {
  const factory SingleBookState({
    @Default(false) bool isLoading,
    @Default(false) bool isAudiobookDownloaded,
    @Default(false) bool isReaderDownloaded,
    BookModel? book,

    // Book recommendations
    @Default(false) bool isLoadingRecommendations,
    @Default([]) List<BookModel> recommendedBooks,
  }) = _SingleBookState;
}
