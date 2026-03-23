import 'package:collection/collection.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

import 'list_creator_cubit.dart';

mixin ListCreatorHelpersMixin on SafeCubit<ListCreatorState> {
  ListsRepository get listsRepository;

  // --------------------------
  // ---- Helper Methods ------
  // --------------------------

  // Resets the state to its initial values, clearing all lists and any ongoing operations
  void resetState() {
    emit(const ListCreatorState());
  }

  // Restores the edited list to its previous state, discarding any unsaved changes
  void restoreListToItsPreviousState() {
    emit(state.copyWith(editedListToSave: state.editedList));
  }

  /// Generates a timestamp-based UUID for list items
  String generateItemUuid() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Updates a list locally in the state
  List<ListModel> updateListLocally(ListModel updatedList) {
    final currentLists = List<ListModel>.from(state.allLists);
    final index = currentLists.indexWhere(
      (list) =>
          list.slug == updatedList.slug ||
          (updatedList.slug.isEmpty && list.name == updatedList.name),
    );
    if (index != -1) {
      currentLists[index] = updatedList;
    }
    return currentLists;
  }

  /// Finds a list by name or slug
  ListModel? findList({String? name, String? slug}) {
    return state.allLists.firstWhereOrNull(
      (list) =>
          (name != null && list.name == name) ||
          (slug != null && list.slug == slug),
    );
  }

  /// Checks if an item exists in remove queue for specific list
  bool isItemInRemoveQueue(String itemSlug, String listSlug) {
    return state.itemsToRemove.any(
      (item) => item.$2 == itemSlug && item.$1 == listSlug,
    );
  }

  /// Checks if an item exists in add queue for specific list
  bool isItemInAddQueue(String itemSlug, String listSlug) {
    return state.itemsToAdd.any(
      (list) =>
          list.items.any((item) => item.bookSlug == itemSlug) &&
          list.slug == listSlug,
    );
  }

  /// Removes item from remove queue
  void removeFromRemoveQueue(String itemSlug, String listSlug) {
    final updatedRemoveQueue = List<ItemToRemove>.from(state.itemsToRemove);
    updatedRemoveQueue.removeWhere(
      (item) => item.$2 == itemSlug && item.$1 == listSlug,
    );
    emit(state.copyWith(itemsToRemove: updatedRemoveQueue));
  }

  /// Removes item from add queue for specific list
  void removeFromAddQueue(String itemSlug, String listSlug) {
    final updatedAddQueue = List<ListModel>.from(state.itemsToAdd);
    final index = updatedAddQueue.indexWhere((list) => list.slug == listSlug);
    if (index > -1) {
      final items = List<ListItemModel>.from(updatedAddQueue[index].items);
      items.removeWhere((item) => item.bookSlug == itemSlug);
      if (items.isEmpty) {
        updatedAddQueue.removeAt(index);
      } else {
        updatedAddQueue[index] = updatedAddQueue[index].copyWith(items: items);
      }
    }
    emit(state.copyWith(itemsToAdd: updatedAddQueue));
  }

  /// Updates items in local list state - supports books via bookSlug parameter
  List<ListModel> updateItemsInList(
    String listSlug,
    String itemSlug, {
    required bool add,
  }) {
    return updateItemsInListHelper(
      listSlug,
      ListItemModel(
        uuid: generateItemUuid(),
        listSlug: listSlug,
        bookSlug: itemSlug,
      ),
      add: add,
      checkBy: (item) => item.bookSlug == itemSlug,
    );
  }

  /// Generic method to update items in local list state
  void updateItemsInListWithEmit(
    String listSlug,
    ListItemModel item, {
    required bool add,
  }) {
    final updatedLists = updateItemsInListHelper(
      listSlug,
      item,
      add: add,
      checkBy: (i) => i.uuid == item.uuid,
    );
    emit(state.copyWith(allLists: updatedLists));
  }

  List<ListModel> updateItemsInListHelper(
    String listSlug,
    ListItemModel item, {
    required bool add,
    required bool Function(ListItemModel) checkBy,
  }) {
    final currentLists = List<ListModel>.from(state.allLists);
    final index = currentLists.indexWhere((list) => list.slug == listSlug);
    if (index != -1) {
      final list = currentLists[index];
      final items = List<ListItemModel>.from(list.items);

      if (add && !items.any(checkBy)) {
        items.add(item);
        currentLists[index] = list.copyWith(items: items);
      } else if (!add) {
        items.removeWhere(checkBy);
        currentLists[index] = list.copyWith(items: items);
      }
    }
    return currentLists;
  }

  /// Updates edited list by adding or removing an item
  void updateEditedList(String itemSlug, {required bool add}) {
    updateEditedListItem(
      ListItemModel(
        uuid: generateItemUuid(),
        listSlug: state.editedListToSave?.slug ?? '',
        bookSlug: itemSlug,
      ),
      add: add,
      checkBy: (item) => item.bookSlug == itemSlug,
    );
  }

  /// Generic method to update edited list with any item type (fragments, quotes, bookmarks)
  void updateEditedListItem(
    ListItemModel item, {
    required bool add,
    bool Function(ListItemModel)? checkBy,
  }) {
    if (state.editedListToSave == null) return;

    final updatedItems = List<ListItemModel>.from(
      state.editedListToSave!.items,
    );
    final checkFunction = checkBy ?? (i) => i.uuid == item.uuid;

    if (add && !updatedItems.any(checkFunction)) {
      updatedItems.add(item);
    } else if (!add) {
      updatedItems.removeWhere(checkFunction);
    } else {
      return; // No changes needed
    }

    emit(
      state.copyWith(
        editedListToSave: state.editedListToSave!.copyWith(items: updatedItems),
      ),
    );
  }

  /// Checks if all DataState results are successful
  bool allResultsSuccessful(List<DataState?> results) {
    return results.every((result) => result?.isSuccess ?? true);
  }

  /// Checks for duplicate list name and emits failure if found
  bool checkAndEmitDuplicateName(String name) {
    if (state.listNameIsDuplicate(name)) {
      emit(state.copyWith(isDuplicateFailure: true));
      return true;
    }
    return false;
  }

  /// Processes items to add queue
  Future<List<DataState>> processItemsToAdd() async {
    final responses = <DataState>[];

    for (final element in state.itemsToAdd) {
      final result = element.slug.isNotEmpty
          ? await listsRepository.addItemsToList(
              listSlug: element.slug,
              items: element.items,
            )
          : await listsRepository.createList(
              listName: element.name,
              items: element.items,
            );
      responses.add(result);
    }

    return responses;
  }

  /// Processes items to remove queue
  Future<List<DataState>> processItemsToRemove() async {
    final responses = <DataState>[];

    for (final element in state.itemsToRemove) {
      // Find the item with matching book slug and get its UUID
      final list = findList(slug: element.$1);
      if (list != null) {
        final item = list.items.firstWhere(
          (item) => item.bookSlug == element.$2,
          orElse: () => const ListItemModel(uuid: '', listSlug: ''),
        );
        if (item.uuid != null) {
          final result = await listsRepository.deleteListItem(
            itemUuid: item.uuid!,
          );
          responses.add(result);
        }
      }
    }

    return responses;
  }

  /// Deletes items by book slug from a list
  Future<List<DataState>> deleteItemsByBookSlug(
    List<String> itemSlugs,
    List<ListItemModel> listItems,
  ) async {
    final results = <DataState>[];
    for (final itemSlug in itemSlugs) {
      // Find the item to delete
      final item = listItems.firstWhereOrNull(
        (item) => item.bookSlug == itemSlug,
      );

      if (item?.uuid != null) {
        final result = await listsRepository.deleteListItem(
          itemUuid: item!.uuid!,
        );
        results.add(result);
      }
    }
    return results;
  }

  /// Helper to extract book slugs from list items
  List<String> extractBookSlugs(ListModel? list) {
    return list?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toList() ??
        [];
  }

  /// Calculates only new items that need to be added
  List<String> getNewItemsToAdd() {
    final originalBookSlugs = extractBookSlugs(state.editedList);
    final currentBookSlugs = extractBookSlugs(state.editedListToSave);
    return currentBookSlugs
        .where((book) => !originalBookSlugs.contains(book))
        .toList();
  }

  /// Calculates items that need to be removed
  List<String> getItemsToRemove() {
    final originalBookSlugs = extractBookSlugs(state.editedList);
    final currentBookSlugs = extractBookSlugs(state.editedListToSave);
    return originalBookSlugs
        .where((book) => !currentBookSlugs.contains(book))
        .toList();
  }

  void addItemToAddQueue({
    required String listName,
    required String listSlug,
    required String itemSlug,
  }) {
    // Check if the item isn't in local removeQueue
    if (isItemInRemoveQueue(itemSlug, listSlug)) {
      removeFromRemoveQueue(itemSlug, listSlug);
      return;
    }

    addItemToList(
      listName: listName,
      listSlug: listSlug,
      item: ListItemModel(
        uuid: generateItemUuid(),
        listSlug: listSlug,
        bookSlug: itemSlug,
      ),
      checkBy: (item) => item.bookSlug == itemSlug,
    );
  }

  /// Generic method to add any item to add queue
  void addItemToList({
    required String listName,
    required String listSlug,
    required ListItemModel item,
    bool Function(ListItemModel)? checkBy,
  }) {
    final newState = List<ListModel>.from(state.itemsToAdd);
    final index = newState.indexWhere((element) => element.slug == listSlug);
    final checkFunction = checkBy ?? (i) => i.uuid == item.uuid;

    if (index > -1) {
      final items = List<ListItemModel>.from(newState[index].items);
      if (!items.any(checkFunction)) {
        items.add(item);
        newState[index] = newState[index].copyWith(items: items);
        emit(state.copyWith(itemsToAdd: newState));
      }
    } else {
      final newList = ListModel(name: listName, items: [item], slug: listSlug);
      newState.add(newList);
      emit(state.copyWith(itemsToAdd: newState));
    }
  }

  void addItemToRemoveQueue({
    required String listSlug,
    required String listName,
    required String itemSlug,
  }) {
    // Check if the item isn't in local addQueue
    if (isItemInAddQueue(itemSlug, listSlug)) {
      removeFromAddQueue(itemSlug, listSlug);
      return;
    }

    // Check if the item is not already in the remove queue to avoid duplicates
    if (!isItemInRemoveQueue(itemSlug, listSlug)) {
      final toRemove = List<ItemToRemove>.from(state.itemsToRemove);
      toRemove.add((listSlug, itemSlug));
      emit(state.copyWith(itemsToRemove: toRemove));
    }
  }

  Future<void> deleteItemFromList({
    required ListItemModel item,
    bool shouldHandle = false,
  }) async {
    final ListModel? singleList = state.fetchedSingleList;
    final isWorkingOnFetchedSingleList = singleList?.slug == item.listSlug;
    if (isWorkingOnFetchedSingleList) {
      emit(
        state.copyWith(
          fetchedSingleList: state.fetchedSingleList?.copyWith(
            items: state.fetchedSingleList!.items
                .where((listItem) => listItem.uuid != item.uuid)
                .toList(),
          ),
        ),
      );
    }

    // Make the API call to delete the item
    final response = await listsRepository.deleteListItem(itemUuid: item.uuid!);
    if (!shouldHandle) return;

    response.handle(
      success: (_, __) {
        // Item removed successfully, no further action needed
        emit(state.copyWith(itemToRemoveFromList: null));
      },
      failure: (_) {
        // Revert state on failure
        if (singleList != null && isWorkingOnFetchedSingleList) {
          emit(
            state.copyWith(
              fetchedSingleList: singleList,
              itemToRemoveFromList: null,
            ),
          );
          return;
        }
        emit(state.copyWith(itemToRemoveFromList: null));
      },
    );
  }
}
