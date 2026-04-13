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
  }) = _ListEditorState;
}

extension ListEditorStateX on ListEditorState {
  int get numberOfChangesInEditedList {
    final editedSlugs = (editedList?.items ?? [])
        .map((item) => item.itemIdentifier)
        .toSet();
    final editedToSaveSlugs = (editedListToSave?.items ?? [])
        .map((item) => item.itemIdentifier)
        .toSet();

    return editedSlugs.difference(editedToSaveSlugs).length +
        editedToSaveSlugs.difference(editedSlugs).length;
  }

  bool isItemInGivenList(String listSlug, String itemIdentifier) {
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
