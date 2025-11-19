part of 'list_creator_cubit.dart';

typedef BookToRemove = (String listSlug, String listName, String bookSlug);

@freezed
sealed class ListCreatorState with _$ListCreatorState {
  const factory ListCreatorState({
    @Default([]) List<BookListModel> booksToAdd,
    // (List slug, book slug)
    @Default([]) List<BookToRemove> booksToRemove,
    bool? isSuccess,

    // Existing lists from the db
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<BookListModel> allLists,
    BookListModel? fetchedSingleList,
    @Default(ApiResponsePagination()) ApiResponsePagination pagination,

    // Editing list
    BookListModel? editedList,
    BookListModel? editedListToSave,
    @Default(false) bool isSavingEditedList,
    @Default(false) bool isSavingFailure,

    // Adding list
    @Default(false) bool isAdding,
    @Default(false) bool isAddingFailure,
    BookListModel? pendingList,

    // Deleting list
    String? deletingSlug,
    @Default(false) bool isDeleteFailure,

    // Deleting book from list
    // List slug, book slug
    (String, String)? bookToRemoveFromList,
    @Default(false) bool isRemovingBookFailure,
  }) = _ListCreatorState;
}

extension ListCreatorStateX on ListCreatorState {
  bool doesLocalListExistsAlready(String listName) {
    return allLists.any((element) => element.name == listName) ||
        pendingList?.name == listName;
  }

  bool isBookInList(String listName, String bookSlug) {
    return (allLists
                .firstWhereOrNull((element) => element.name == listName)
                ?.books ??
            [])
        .contains(bookSlug);
  }

  bool listNameIsDuplicate(String listName) {
    return booksToAdd.any((element) => element.name == listName) ||
        allLists.any((element) => element.name == listName);
  }

  String? slugByName(String listName) {
    return allLists
        .firstWhereOrNull((element) => element.name == listName)
        ?.slug;
  }

  bool get anyChangesInEditesList => !(const ListEquality().equals(
    editedList?.books,
    editedListToSave?.books,
  ));

  bool isBookInEditedList(String bookSlug) {
    return (editedListToSave?.books.contains(bookSlug) ?? false) &&
        deletingSlug != bookSlug;
  }
}
