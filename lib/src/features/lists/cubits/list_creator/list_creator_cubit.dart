import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'list_creator_cubit.freezed.dart';
part 'list_creator_state.dart';

class ListCreatorCubit extends SafeCubit<ListCreatorState> {
  final ListsRepository _listsRepository;
  ListCreatorCubit(this._listsRepository) : super(const ListCreatorState());

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

  /// Updates a list locally in the state
  List<ListModel> _updateListLocally(ListModel updatedList) {
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
  ListModel? _findList({String? name, String? slug}) {
    return state.allLists.firstWhereOrNull(
      (list) =>
          (name != null && list.name == name) ||
          (slug != null && list.slug == slug),
    );
  }

  /// Checks if an item exists in remove queue for specific list
  bool _isItemInRemoveQueue(String itemSlug, String listSlug) {
    return state.itemsToRemove.any(
      (item) => item.$2 == itemSlug && item.$1 == listSlug,
    );
  }

  /// Checks if an item exists in add queue for specific list
  bool _isItemInAddQueue(String itemSlug, String listSlug) {
    return state.itemsToAdd.any(
      (list) =>
          list.items.any((item) => item.bookSlug == itemSlug) &&
          list.slug == listSlug,
    );
  }

  /// Removes item from remove queue
  void _removeFromRemoveQueue(String itemSlug, String listSlug) {
    final updatedRemoveQueue = List<ItemToRemove>.from(state.itemsToRemove);
    updatedRemoveQueue.removeWhere(
      (item) => item.$2 == itemSlug && item.$1 == listSlug,
    );
    emit(state.copyWith(itemsToRemove: updatedRemoveQueue));
  }

  /// Removes item from add queue for specific list
  void _removeFromAddQueue(String itemSlug, String listSlug) {
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
  List<ListModel> _updateItemsInList(
    String listSlug,
    String itemSlug, {
    required bool add,
  }) {
    final currentLists = List<ListModel>.from(state.allLists);
    final index = currentLists.indexWhere((list) => list.slug == listSlug);
    if (index != -1) {
      final list = currentLists[index];
      final items = List<ListItemModel>.from(list.items);
      final itemExists = items.any((item) => item.bookSlug == itemSlug);

      if (add && !itemExists) {
        items.add(
          ListItemModel(
            uuid: DateTime.now().millisecondsSinceEpoch.toString(),
            listSlug: listSlug,
            bookSlug: itemSlug,
          ),
        );
        currentLists[index] = list.copyWith(items: items);
      } else if (!add && itemExists) {
        items.removeWhere((item) => item.bookSlug == itemSlug);
        currentLists[index] = list.copyWith(items: items);
      }
    }
    return currentLists;
  }

  /// Generic method to update items in local list state
  void updateItemsInList(
    String listSlug,
    ListItemModel item, {
    required bool add,
  }) {
    final updatedLists = _updateItemsInListHelper(listSlug, item, add: add);
    emit(state.copyWith(allLists: updatedLists));
  }

  List<ListModel> _updateItemsInListHelper(
    String listSlug,
    ListItemModel item, {
    required bool add,
  }) {
    final currentLists = List<ListModel>.from(state.allLists);
    final index = currentLists.indexWhere((list) => list.slug == listSlug);
    if (index != -1) {
      final list = currentLists[index];
      final items = List<ListItemModel>.from(list.items);

      if (add && !items.any((i) => i.uuid == item.uuid)) {
        items.add(item);
        currentLists[index] = list.copyWith(items: items);
      } else if (!add) {
        items.removeWhere((i) => i.uuid == item.uuid);
        currentLists[index] = list.copyWith(items: items);
      }
    }
    return currentLists;
  }

  /// Updates edited list by adding or removing an item
  void _updateEditedList(String itemSlug, {required bool add}) {
    if (state.editedListToSave == null) return;

    final updatedItems = List<ListItemModel>.from(
      state.editedListToSave!.items,
    );
    final itemExists = updatedItems.any((item) => item.bookSlug == itemSlug);

    if (add && !itemExists) {
      updatedItems.add(
        ListItemModel(
          uuid: DateTime.now().millisecondsSinceEpoch.toString(),
          listSlug: state.editedListToSave!.slug,
          bookSlug: itemSlug,
        ),
      );
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            items: updatedItems,
          ),
        ),
      );
    } else if (!add && itemExists) {
      updatedItems.removeWhere((item) => item.bookSlug == itemSlug);
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            items: updatedItems,
          ),
        ),
      );
    }
  }

  /// Generic method to update edited list with any item type (fragments, quotes, bookmarks)
  void updateEditedListItem(ListItemModel item, {required bool add}) {
    if (state.editedListToSave == null) return;

    final updatedItems = List<ListItemModel>.from(
      state.editedListToSave!.items,
    );

    if (add && !updatedItems.any((i) => i.uuid == item.uuid)) {
      updatedItems.add(item);
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            items: updatedItems,
          ),
        ),
      );
    } else if (!add) {
      updatedItems.removeWhere((i) => i.uuid == item.uuid);
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            items: updatedItems,
          ),
        ),
      );
    }
  }

  /// Removes duplicates from lists based on slug
  List<T> _removeDuplicates<T>(
    List<T> newItems,
    List<T> existingItems,
    String Function(T) getSlug,
  ) {
    final existing = existingItems.map(getSlug).toSet();
    return newItems.where((item) => !existing.contains(getSlug(item))).toList();
  }

  /// Processes items to add queue
  Future<List<DataState>> _processItemsToAdd() async {
    final responses = <DataState>[];

    for (final element in state.itemsToAdd) {
      final result = element.slug.isNotEmpty
          ? await _listsRepository.addItemsToList(
              listSlug: element.slug,
              items: element.items,
            )
          : await _listsRepository.createList(
              listName: element.name,
              items: element.items,
            );
      responses.add(result);
    }

    return responses;
  }

  /// Processes items to remove queue
  Future<List<DataState>> _processItemsToRemove() async {
    final responses = <DataState>[];

    for (final element in state.itemsToRemove) {
      // Find the item with matching book slug and get its UUID
      final list = _findList(slug: element.$1);
      if (list != null) {
        final item = list.items.firstWhere(
          (item) => item.bookSlug == element.$2,
          orElse: () => const ListItemModel(uuid: '', listSlug: ''),
        );
        if (item.uuid != null) {
          final result = await _listsRepository.deleteListItem(
            itemUuid: item.uuid!,
          );
          responses.add(result);
        }
      }
    }

    return responses;
  }

  /// Calculates only new items that need to be added
  List<String> _getNewItemsToAdd() {
    final originalBookSlugs =
        state.editedList?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toList() ??
        [];
    final currentBookSlugs =
        state.editedListToSave?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toList() ??
        [];
    return currentBookSlugs
        .where((book) => !originalBookSlugs.contains(book))
        .toList();
  }

  /// Calculates items that need to be removed
  List<String> _getItemsToRemove() {
    final originalBookSlugs =
        state.editedList?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toList() ??
        [];
    final currentBookSlugs =
        state.editedListToSave?.items
            .where((item) => item.bookSlug != null)
            .map((item) => item.bookSlug!)
            .toList() ??
        [];
    return originalBookSlugs
        .where((book) => !currentBookSlugs.contains(book))
        .toList();
  }

  // --------------------------

  // -------- Fetching --------
  // --------------------------
  Future<void> getLists({bool force = false}) async {
    if (state.allLists.isNotEmpty && !force) {
      return;
    }
    emit(const ListCreatorState());
    emit(state.copyWith(isLoading: true));
    final response = await _listsRepository.getLists();
    response.handle(
      success: (lists, pagination) {
        emit(
          state.copyWith(
            isLoading: false,
            allLists: lists,
            pagination: pagination ?? state.pagination,
          ),
        );
      },
      failure: (error) {
        error.handle(
          notFound: () {
            emit(state.copyWith(allLists: [], isLoading: false));
          },
          orElse: () {
            emit(state.copyWith(isLoading: false));
          },
        );
      },
    );
  }

  Future<void> getMoreLists() async {
    if (state.pagination.next == null) return;

    emit(state.copyWith(isLoadingMore: true));
    final lists = await _listsRepository.getLists(
      url: state.pagination.next!.removeApiUrl,
    );

    lists.handle(
      success: (newLists, pagination) {
        final uniqueNewLists = _removeDuplicates(
          newLists,
          state.allLists,
          (list) => list.slug,
        );

        emit(
          state.copyWith(
            allLists: [...state.allLists, ...uniqueNewLists],
            pagination: pagination ?? state.pagination,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            pagination: const ApiResponsePagination(),
          ),
        );
      },
    );
  }

  Future<void> getListBySlug(String listSlug) async {
    emit(
      state.copyWith(
        isLoading: true,
        fetchedSingleList: null,
        itemsPagination: const ApiResponsePagination(),
      ),
    );
    final response = await _listsRepository.getListBySlug(slug: listSlug);
    response.handle(
      success: (list, _) async {
        final items = await _listsRepository.getListItems(listSlug: list.slug);

        items.handle(
          success: (listItems, pagination) {
            final completeList = list.copyWith(items: listItems);
            emit(
              state.copyWith(
                isLoading: false,
                fetchedSingleList: completeList,
                itemsPagination: pagination ?? state.itemsPagination,
              ),
            );
          },
          failure: (failure) {
            emit(state.copyWith(isLoading: false, fetchedSingleList: list));
          },
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false, fetchedSingleList: null));
      },
    );
  }

  Future<void> getMoreListItems(String listSlug) async {
    if (state.itemsPagination.next == null) return;
    if (state.isLoadingMoreItems) return;

    emit(state.copyWith(isLoadingMoreItems: true));
    final items = await _listsRepository.getListItems(
      listSlug: listSlug,
      url: state.itemsPagination.next!.removeApiUrl,
    );

    items.handle(
      success: (newItems, pagination) {
        if (state.fetchedSingleList == null) {
          emit(state.copyWith(isLoadingMoreItems: false));
          return;
        }

        final currentItems = List<ListItemModel>.from(
          state.fetchedSingleList!.items,
        );
        final uniqueNewItems = _removeDuplicates(
          newItems,
          currentItems,
          (item) => item.uuid ?? '',
        );

        final updatedList = state.fetchedSingleList!.copyWith(
          items: [...currentItems, ...uniqueNewItems],
        );

        emit(
          state.copyWith(
            fetchedSingleList: updatedList,
            itemsPagination: pagination ?? state.itemsPagination,
            isLoadingMoreItems: false,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            isLoadingMoreItems: false,
            itemsPagination: const ApiResponsePagination(),
          ),
        );
      },
    );
  }
  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // ------ Bottom Sheet ------
  // --------------------------
  void newList(String listName, {List<String> itemSlugs = const []}) {
    emit(state.copyWith(isDuplicateFailure: false));
    if (state.listNameIsDuplicate(listName)) {
      emit(state.copyWith(isDuplicateFailure: true));
      return;
    }

    // Remove duplicates from itemSlugs before creating the list
    final uniqueItemSlugs = itemSlugs.toSet().toList();

    // Create items from item slugs
    final items = uniqueItemSlugs
        .map(
          (itemSlug) => ListItemModel(
            uuid: DateTime.now().millisecondsSinceEpoch.toString(),
            listSlug: '',
            bookSlug: itemSlug,
          ),
        )
        .toList();

    final newList = ListModel(name: listName, items: items, slug: '');
    final newState = List<ListModel>.from(state.allLists);
    newState.add(newList);

    for (final itemSlug in uniqueItemSlugs) {
      _addItemToAddQueue(
        listName: newList.name,
        listSlug: newList.slug,
        itemSlug: itemSlug,
      );
    }
    emit(state.copyWith(allLists: newState));
  }

  void addItemToListWithQueue(String listSlug, String itemSlug) {
    final list = _findList(slug: listSlug);
    final hasItem =
        list?.items.any((item) => item.bookSlug == itemSlug) ?? false;
    if (list != null && !hasItem) {
      final updatedLists = _updateItemsInList(listSlug, itemSlug, add: true);
      _addItemToAddQueue(
        listName: list.name,
        itemSlug: itemSlug,
        listSlug: list.slug,
      );
      emit(state.copyWith(allLists: updatedLists));
    }
  }

  void removeItemFromListWithQueue(String listSlug, String itemSlug) {
    final list = _findList(slug: listSlug);
    final hasItem =
        list?.items.any((item) => item.bookSlug == itemSlug) ?? false;
    if (list != null && hasItem) {
      final updatedLists = _updateItemsInList(listSlug, itemSlug, add: false);
      _addItemToRemoveQueue(
        listSlug: list.slug,
        listName: list.name,
        itemSlug: itemSlug,
      );
      emit(state.copyWith(allLists: updatedLists));
    }
  }

  Future<void> save() async {
    if (state.itemsToAdd.isEmpty && state.itemsToRemove.isEmpty) {
      return;
    }

    emit(state.copyWith(isSuccess: true));

    final addResponses = await _processItemsToAdd();
    final removeResponses = await _processItemsToRemove();
    final allResponses = [...addResponses, ...removeResponses];

    emit(
      state.copyWith(
        itemsToAdd: [],
        itemsToRemove: [],
        isSuccess: allResponses.every((response) => response.isSuccess),
      ),
    );

    // Reinitialize the state to fetch the latest lists
    getLists(force: true);
  }

  void _addItemToAddQueue({
    required String listName,
    required String listSlug,
    required String itemSlug,
  }) {
    // Check if the item isn't in local removeQueue
    if (_isItemInRemoveQueue(itemSlug, listSlug)) {
      _removeFromRemoveQueue(itemSlug, listSlug);
      return;
    }

    final newState = List<ListModel>.from(state.itemsToAdd);
    final index = newState.indexWhere((element) => element.slug == listSlug);
    if (index > -1) {
      final items = List<ListItemModel>.from(newState[index].items);
      // Check if item is not already in the list to avoid duplicates
      if (!items.any((item) => item.bookSlug == itemSlug)) {
        items.add(
          ListItemModel(
            uuid: DateTime.now().millisecondsSinceEpoch.toString(),
            listSlug: listSlug,
            bookSlug: itemSlug,
          ),
        );
        newState[index] = newState[index].copyWith(items: items);
        emit(state.copyWith(itemsToAdd: newState));
      }
    } else {
      final newList = ListModel(
        name: listName,
        items: [
          ListItemModel(
            uuid: DateTime.now().millisecondsSinceEpoch.toString(),
            listSlug: listSlug,
            bookSlug: itemSlug,
          ),
        ],
        slug: listSlug,
      );
      newState.add(newList);
      emit(state.copyWith(itemsToAdd: newState));
    }
  }

  /// Generic method to add any item to add queue
  /// Generic method to add any item to add queue
  void addItemToList({
    required String listName,
    required String listSlug,
    required ListItemModel item,
  }) {
    final newState = List<ListModel>.from(state.itemsToAdd);
    final index = newState.indexWhere((element) => element.slug == listSlug);
    if (index > -1) {
      final items = List<ListItemModel>.from(newState[index].items);
      if (!items.any((i) => i.uuid == item.uuid)) {
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

  void _addItemToRemoveQueue({
    required String listSlug,
    required String listName,
    required String itemSlug,
  }) {
    // Check if the item isn't in local addQueue
    if (_isItemInAddQueue(itemSlug, listSlug)) {
      _removeFromAddQueue(itemSlug, listSlug);
      return;
    }

    // Check if the item is not already in the remove queue to avoid duplicates
    if (!_isItemInRemoveQueue(itemSlug, listSlug)) {
      final toRemove = List<ItemToRemove>.from(state.itemsToRemove);
      toRemove.add((listSlug, itemSlug));
      emit(state.copyWith(itemsToRemove: toRemove));
    }
  }

  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // ------- My Library -------
  // --------------------------

  Future<void> deleteList(String slug, {VoidCallback? onSuccess}) async {
    emit(state.copyWith(deletingSlug: slug, isDeleteFailure: false));
    final newState = List<ListModel>.from(state.allLists);
    final prevState = List<ListModel>.from(state.allLists);
    newState.removeWhere((element) => element.slug == slug);
    emit(state.copyWith(allLists: newState));
    final result = await _listsRepository.deleteList(listSlug: slug);
    result.handle(
      success: (data, _) {
        emit(state.copyWith(deletingSlug: null));
        onSuccess?.call();
      },
      failure: (failure) {
        emit(
          state.copyWith(
            isDeleteFailure: true,
            deletingSlug: null,
            allLists: prevState,
          ),
        );
      },
    );
  }

  void undoRemoveItemFromList() {
    emit(state.copyWith(itemToRemoveFromList: null));
  }

  Future<void> removeItemFromList({
    required String listSlug,
    required String itemSlug,
  }) async {
    // If there's already an item pending removal, remove it immediately without waiting for the timeout,
    //to avoid multiple items pending removal at the same time which would be confusing for the user
    if (state.itemToRemoveFromList != null) {
      await _deleteItemFromList(
        listSlug: state.itemToRemoveFromList!.$1,
        itemSlug: state.itemToRemoveFromList!.$2,
        shouldHandle: false,
      );
    }
    // Set the item pending removal in the state
    emit(state.copyWith(itemToRemoveFromList: (listSlug, itemSlug)));
    // Wait for 3 seconds before actually removing the item, giving the user a chance to undo the action
    await Future.delayed(const Duration(seconds: 3));
    // If the item pending removal is not the same as the one we set before, it means the user has undone the action, so we do nothing
    if (state.itemToRemoveFromList?.$1 != listSlug ||
        state.itemToRemoveFromList?.$2 != itemSlug) {
      return;
    }
    // Otherwise, we proceed to remove the item from the list
    _deleteItemFromList(listSlug: listSlug, itemSlug: itemSlug);
  }

  Future<void> _deleteItemFromList({
    required String listSlug,
    required String itemSlug,
    bool shouldHandle = false,
  }) async {
    final previousLists = List<ListModel>.from(state.allLists);
    final index = previousLists.indexWhere((e) => e.slug == listSlug);
    if (index == -1) return;

    // Find the item to delete
    final itemToDelete = previousLists[index].items.firstWhere(
      (item) => item.bookSlug == itemSlug,
      orElse: () => const ListItemModel(uuid: '', listSlug: ''),
    );

    if (itemToDelete.uuid == null) return;

    // Optimistically update the state by removing the item from the list
    final updatedItems = List<ListItemModel>.from(previousLists[index].items)
      ..removeWhere((item) => item.bookSlug == itemSlug);
    final updatedList = previousLists[index].copyWith(items: updatedItems);

    // Update the lists in the state with the optimistically updated list
    final updatedLists = List<ListModel>.from(previousLists)
      ..[index] = updatedList;

    // Emit the updated state with the optimistically updated list
    emit(state.copyWith(allLists: updatedLists));

    // If the currently fetched single list is the one being updated, update it as well
    if (state.fetchedSingleList?.slug == listSlug) {
      emit(state.copyWith(fetchedSingleList: updatedList));
    }

    // Make the API call to delete the item
    final response = await _listsRepository.deleteListItem(
      itemUuid: itemToDelete.uuid!,
    );
    if (!shouldHandle) return;

    response.handle(
      success: (_, __) {
        // Item removed successfully, no further action needed
        emit(state.copyWith(itemToRemoveFromList: null));
      },
      failure: (_) {
        // Revert state on failure
        emit(
          state.copyWith(allLists: previousLists, itemToRemoveFromList: null),
        );
      },
    );
  }

  Future<void> addEmptyList({required String name}) async {
    emit(state.copyWith(isDuplicateFailure: false));
    // Check for duplicate name before making API call
    if (state.listNameIsDuplicate(name)) {
      // Emit duplicate failure state and return early to avoid unnecessary API call
      emit(state.copyWith(isDuplicateFailure: true));
      return;
    }
    // Emit adding state before making API call
    emit(state.copyWith(isAdding: true, isAddingFailure: false));
    await Future.delayed(const Duration(milliseconds: 1));
    // Optimistically add the new list to the state with an empty slug until we get the real slug from the API
    emit(
      state.copyWith(
        pendingList: ListModel(name: name, slug: ''),
      ),
    );
    // Make API call to create the list
    final result = await _listsRepository.createList(listName: name, items: []);
    // Wait for animation
    await Future.delayed(const Duration(milliseconds: 300));
    // Handle API response and update state accordingly
    result.handle(
      success: (data, _) {
        // On success, replace the optimistically added list with the real one from the API (with the correct slug)
        final newState = List<ListModel>.from(state.allLists);
        newState.insert(0, ListModel(name: name, slug: data));
        emit(state.copyWith(isAdding: false, allLists: newState));
      },
      failure: (failure) {
        // On failure, remove the optimistically added list and emit failure state
        emit(
          state.copyWith(
            isAdding: false,
            isAddingFailure: true,
            pendingList: null,
          ),
        );
      },
    );

    emit(state.copyWith(pendingList: null));
  }

  Future<void> renameList({
    required String listSlug,
    required String newName,
  }) async {
    emit(state.copyWith(isDuplicateFailure: false));
    // Check for duplicate name before making API call
    if (state.listNameIsDuplicate(newName)) {
      emit(state.copyWith(isDuplicateFailure: true));
      return;
    }
    emit(state.copyWith(isRenaming: true, isRenamingFailure: false));
    final result = await _listsRepository.renameList(
      listSlug: listSlug,
      newName: newName,
    );
    result.handle(
      success: (_, __) {
        // On success, update the list name in the state
        final updatedLists = _updateListLocally(
          _findList(slug: listSlug)!.copyWith(name: newName),
        );
        emit(state.copyWith(isRenaming: false, allLists: updatedLists));
        if (state.fetchedSingleList?.slug == listSlug) {
          emit(
            state.copyWith(
              fetchedSingleList: state.fetchedSingleList!.copyWith(
                name: newName,
              ),
            ),
          );
        }
      },
      failure: (failure) {
        emit(state.copyWith(isRenaming: false, isRenamingFailure: true));
      },
    );
  }

  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // -------- App Mode --------
  // --------------------------

  Future<void> setListAsEdited(ListModel list) async {
    emit(state.copyWith(editedList: list, editedListToSave: list));
  }

  void addBookToEditedList(String bookSlug) {
    _updateEditedList(bookSlug, add: true);
  }

  void removeBookFromEditedList(String bookSlug) {
    _updateEditedList(bookSlug, add: false);
  }

  void saveEditedList() async {
    if (state.editedListToSave == null) return;
    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));

    final newItems = _getNewItemsToAdd();
    final itemsToRemove = _getItemsToRemove();

    // Handle both adding and removing items
    final addResult = newItems.isNotEmpty
        ? await _listsRepository.addItemsToList(
            listSlug: state.editedListToSave!.slug,
            items: newItems
                .map(
                  (itemSlug) => ListItemModel(
                    listSlug: state.editedListToSave!.slug,
                    bookSlug: itemSlug,
                  ),
                )
                .toList(),
          )
        : null;

    final removeResults = <DataState>[];
    for (final itemSlug in itemsToRemove) {
      // Find the item to delete
      final item = state.editedListToSave!.items
          .where((item) => item.bookSlug == itemSlug)
          .firstOrNull;

      if (item != null) {
        final result = await _listsRepository.deleteListItem(
          itemUuid: item.uuid!,
        );
        removeResults.add(result);
      }
    }

    // Check if all operations were successful
    final allSuccessful =
        (addResult?.isSuccess ?? true) &&
        removeResults.every((result) => result.isSuccess);

    if (allSuccessful) {
      final updatedLists = _updateListLocally(state.editedListToSave!);
      final updatedSingleList = updatedLists.firstWhereOrNull(
        (list) => list.slug == state.fetchedSingleList?.slug,
      );

      emit(
        state.copyWith(
          allLists: updatedLists,
          fetchedSingleList: updatedSingleList,
          editedList: null,
          editedListToSave: null,
          isSavingEditedList: false,
        ),
      );
    } else {
      emit(state.copyWith(isSavingEditedList: false, isSavingFailure: true));
    }
  }

  /// Saves a shared list by creating a local copy with the same items
  Future<void> saveSharedList(ListModel sharedList) async {
    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));

    final result = await _listsRepository.createList(
      listName: sharedList.name,
      items: sharedList.items,
    );

    result.handle(
      success: (newListSlug, _) {
        final newList = ListModel(
          name: sharedList.name,
          items: sharedList.items,
          slug: newListSlug,
        );
        final updatedLists = List<ListModel>.from(state.allLists);
        updatedLists.insert(0, newList);

        emit(state.copyWith(allLists: updatedLists, isSavingEditedList: false));
      },
      failure: (failure) {
        emit(state.copyWith(isSavingEditedList: false, isSavingFailure: true));
      },
    );
  }

  // --------------------------
  // --------------------------
  // --------------------------
}
