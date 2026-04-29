part of 'list_editor_cubit.dart';

@freezed
sealed class ListEditorState with _$ListEditorState {
  const factory ListEditorState({
    // This is original list that is being edited. It is used to compare with the edited list to determine if there are any changes.
    ListModel? editedList,
    // This is the list that is being edited and will be saved. It is updated with every change in the editor.
    ListModel? editedListToSave,
    // Elements to add
    @Default([]) List<ListItemModel> itemsToAdd,
    // Elements to remove
    @Default([]) List<ListItemModel> itemsToRemove,

    ListItemModel? softRemovedItem,

    @Default(false) bool isSavingEditedList,
    @Default(false) bool isSavingFailure,
    @Default(false) bool isSavingSuccess,

    // Book membership tracking
    String? currentBookSlug,
    @Default({}) Set<String> bookListMemberships,
    @Default([]) List<ListItemModel> bookListMembershipItems,
    @Default(false) bool isFetchingMemberships,
    @Default(false) bool membershipsFetchFailure,
  }) = _ListEditorState;
}

extension ListEditorStateX on ListEditorState {
  int get numberOfChangesInEditedList {
    return itemsToAdd.length + itemsToRemove.length;
  }

  bool isItemInGivenList(String listSlug, String itemIdentifier) {
    // Check if this is for the current book being worked on
    if (currentBookSlug != null && itemIdentifier == currentBookSlug) {
      // Check base membership state
      bool isInList = bookListMemberships.contains(listSlug);
      // Apply optimistic updates from queues
      final isInAddQueue = itemsToAdd.any((item) {
        return item.itemIdentifier == itemIdentifier &&
            item.listSlug == listSlug;
      });
      final isInRemoveQueue = itemsToRemove.any((item) {
        return item.itemIdentifier == itemIdentifier &&
            item.listSlug == listSlug;
      });

      if (isInAddQueue) {
        return true;
      }
      if (isInRemoveQueue) {
        return false;
      }

      return isInList;
    }

    // Fallback to original logic for other cases (e.g., bookmarks)
    return (editedListToSave?.items.any(
              (item) =>
                  item.itemIdentifier == itemIdentifier &&
                  item.listSlug == listSlug,
            ) ??
            false) &&
        softRemovedItem?.itemIdentifier != itemIdentifier;
  }

  bool isItemInEditedList(String itemIdentifier) {
    return (editedListToSave?.items.any(
              (item) => item.itemIdentifier == itemIdentifier,
            ) ??
            false) &&
        softRemovedItem?.itemIdentifier != itemIdentifier;
  }

  String? getItemUuidByIdentifier(String itemIdentifier) {
    return editedList?.items
        .firstWhereOrNull((item) => item.itemIdentifier == itemIdentifier)
        ?.uuid;
  }
}
