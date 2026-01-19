part of 'bookmarks_cubit.dart';

typedef SuccessState = (Success, bool);

@freezed
sealed class BookmarksState with _$BookmarksState {
  const factory BookmarksState({
    //
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    SuccessState? isBookmarkSuccess,
    //
    BookmarkModel? editingBookmark,
    BookmarkModel? bookmarkToDelete,
    //
    @Default([]) List<BookmarkModel> bookmarks,
  }) = _BookmarksState;
}

extension BookmarksStateX on BookmarksState {
  BookmarkModel? isSelectedParagraphBookmarked(String? paragraphId) {
    return bookmarks.firstWhereOrNull(
      (element) => element.anchor == paragraphId,
    );
  }

  BookmarkModel? getBookmarkByLocation(String location) {
    return bookmarks.firstWhereOrNull(
      (element) => element.location == location,
    );
  }

  bool bookmarkExists(String slug, String location) {
    return bookmarks.any(
      (element) => element.location == location && element.slug == slug,
    );
  }
}
