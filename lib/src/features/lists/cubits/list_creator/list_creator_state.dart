part of 'list_creator_cubit.dart';

typedef ItemToRemove = (String listSlug, String itemSlug);

@freezed
sealed class ListCreatorState with _$ListCreatorState {
  const factory ListCreatorState({
    @Default([]) List<ListModel> itemsToAdd,
    // (List slug, item slug)
    @Default([]) List<ItemToRemove> itemsToRemove,
    bool? isSuccess,

    // Existing lists from the db
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<ListModel> allLists,
    ListModel? fetchedSingleList,
    @Default(ApiResponsePagination()) ApiResponsePagination pagination,

    // Pagination for items within a single list
    @Default(ApiResponsePagination()) ApiResponsePagination itemsPagination,
    @Default(false) bool isLoadingMoreItems,

    // Editing list
    ListModel? editedList,
    ListModel? editedListToSave,
    @Default(false) bool isSavingEditedList,
    @Default(false) bool isSavingFailure,

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
    ListItemModel? itemToRemoveFromList,
    @Default(false) bool isRemovingItemFailure,
  }) = _ListCreatorState;
}

extension ListCreatorStateX on ListCreatorState {
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

  bool listNameIsDuplicate(String listName) {
    return itemsToAdd.any((element) => element.name == listName) ||
        allLists.any((element) => element.name == listName);
  }

  String? slugByName(String listName) {
    return allLists
        .firstWhereOrNull((element) => element.name == listName)
        ?.slug;
  }

  int get numberOfChangesInEditedList {
    final editedBookSlugs =
        editedList?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toSet() ??
        {};
    final editedToSaveBookSlugs =
        editedListToSave?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toSet() ??
        {};

    return editedBookSlugs.difference(editedToSaveBookSlugs).length +
        editedToSaveBookSlugs.difference(editedBookSlugs).length;
  }

  bool isBookInEditedList(String itemSlug) {
    return (editedListToSave?.items.any((item) => item.bookSlug == itemSlug) ??
            false) &&
        deletingSlug != itemSlug;
  }
}
