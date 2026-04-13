part of 'lists_cubit.dart';

@freezed
sealed class ListsState with _$ListsState {
  const factory ListsState({
    // Existing lists from the db
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<ListModel> allLists,
    ListModel? fetchedSingleList,
    @Default(ApiResponsePagination()) ApiResponsePagination pagination,

    // Pagination for items within a single list
    @Default(ApiResponsePagination()) ApiResponsePagination itemsPagination,
    @Default(false) bool isLoadingMoreItems,

    // Adding list
    @Default(false) bool isAdding,
    @Default(false) bool isAddingFailure,
    ListModel? pendingList,

    // Deleting list
    String? deletingSlug,
    @Default(false) bool isDeleteFailure,

    // Renaming list
    @Default(false) bool isRenaming,
    @Default(false) bool isRenamingFailure,
    @Default(false) bool isDuplicateFailure,

    // Deleting item from list
    // List slug, item slug
    ListItemModel? softDeletedItem,
    @Default(false) bool isRemovingItemFailure,
  }) = _ListsState;
}

extension ListsStateX on ListsState {
  bool doesLocalListExistsAlready(String listSlug) {
    return allLists.any((element) => element.slug == listSlug) ||
        pendingList?.slug == listSlug;
  }

  bool isBookInList(String listSlug, String itemSlug) {
    if (fetchedSingleList != null && fetchedSingleList!.slug == listSlug) {
      return fetchedSingleList!.items.any((item) => item.bookSlug == itemSlug);
    }
    return (allLists
                .firstWhereOrNull((element) => element.slug == listSlug)
                ?.items ??
            [])
        .any((item) => item.bookSlug == itemSlug);
  }
}
