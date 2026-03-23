import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

import 'list_creator_helpers_mixin.dart';

part 'list_creator_cubit.freezed.dart';
part 'list_creator_state.dart';

class ListCreatorCubit extends SafeCubit<ListCreatorState>
    with ListCreatorHelpersMixin {
  final ListsRepository _listsRepository;
  ListCreatorCubit(this._listsRepository) : super(const ListCreatorState());

  @override
  ListsRepository get listsRepository => _listsRepository;

  // --------------------------

  // -------- Fetching --------
  // --------------------------
  Future<void> getLists({bool force = false}) async {
    if (state.allLists.isNotEmpty && !force) {
      return;
    }
    emit(const ListCreatorState().copyWith(isLoading: true));
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
        emit(
          state.copyWith(
            allLists: [...state.allLists, ...newLists],
            pagination: pagination ?? state.pagination,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingMore: false));
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

        final updatedList = state.fetchedSingleList!.copyWith(
          items: [...currentItems, ...newItems],
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
        emit(state.copyWith(isLoadingMoreItems: false));
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
    if (checkAndEmitDuplicateName(listName)) return;

    // Remove duplicates from itemSlugs before creating the list
    final uniqueItemSlugs = itemSlugs.toSet().toList();

    // Create items from item slugs
    final items = uniqueItemSlugs
        .map(
          (itemSlug) => ListItemModel(
            uuid: generateItemUuid(),
            listSlug: '',
            bookSlug: itemSlug,
          ),
        )
        .toList();

    final newList = ListModel(name: listName, items: items, slug: '');
    final newState = List<ListModel>.from(state.allLists);
    newState.add(newList);

    for (final itemSlug in uniqueItemSlugs) {
      addItemToAddQueue(
        listName: newList.name,
        listSlug: newList.slug,
        itemSlug: itemSlug,
      );
    }
    emit(state.copyWith(allLists: newState));
  }

  void addItemToListWithQueue(String listSlug, String itemSlug) {
    final list = findList(slug: listSlug);
    final hasItem =
        list?.items.any((item) => item.bookSlug == itemSlug) ?? false;
    if (list != null && !hasItem) {
      final updatedLists = updateItemsInList(listSlug, itemSlug, add: true);
      addItemToAddQueue(
        listName: list.name,
        itemSlug: itemSlug,
        listSlug: list.slug,
      );
      emit(state.copyWith(allLists: updatedLists));
    }
  }

  void removeItemFromListWithQueue(String listSlug, String itemSlug) {
    final list = findList(slug: listSlug);
    final hasItem =
        list?.items.any((item) => item.bookSlug == itemSlug) ?? false;
    if (list != null && hasItem) {
      final updatedLists = updateItemsInList(listSlug, itemSlug, add: false);
      addItemToRemoveQueue(
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

    final addResponses = await processItemsToAdd();
    final removeResponses = await processItemsToRemove();
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

  Future<void> removeItemFromList({required ListItemModel item}) async {
    // If there's already an item pending removal, remove it immediately without waiting for the timeout,
    //to avoid multiple items pending removal at the same time which would be confusing for the user
    if (state.itemToRemoveFromList != null) {
      await deleteItemFromList(
        item: state.itemToRemoveFromList!,
        shouldHandle: false,
      );
    }
    // Set the item pending removal in the state
    emit(state.copyWith(itemToRemoveFromList: item));
    // Wait for 3 seconds before actually removing the item, giving the user a chance to undo the action
    await Future.delayed(const Duration(seconds: 3));
    // If the item pending removal is not the same as the one we set before, it means the user has undone the action, so we do nothing
    if (state.itemToRemoveFromList?.uuid != item.uuid ||
        state.itemToRemoveFromList?.listSlug != item.listSlug) {
      return;
    }
    // Otherwise, we proceed to remove the item from the list
    deleteItemFromList(item: item);
  }

  Future<void> addEmptyList({required String name}) async {
    emit(state.copyWith(isDuplicateFailure: false));
    // Check for duplicate name before making API call
    if (checkAndEmitDuplicateName(name)) {
      // Emit duplicate failure state and return early to avoid unnecessary API call
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
    if (checkAndEmitDuplicateName(newName)) return;
    emit(state.copyWith(isRenaming: true, isRenamingFailure: false));
    final result = await _listsRepository.renameList(
      listSlug: listSlug,
      newName: newName,
    );
    result.handle(
      success: (_, __) {
        // On success, update the list name in the state
        final updatedLists = updateListLocally(
          findList(slug: listSlug)!.copyWith(name: newName),
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
    updateEditedList(bookSlug, add: true);
  }

  void removeBookFromEditedList(String bookSlug) {
    updateEditedList(bookSlug, add: false);
  }

  void saveEditedList() async {
    if (state.editedListToSave == null) return;
    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));

    final newItems = getNewItemsToAdd();
    final itemsToRemove = getItemsToRemove();

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

    final removeResults = await deleteItemsByBookSlug(
      itemsToRemove,
      state.editedListToSave!.items,
    );

    // Check if all operations were successful
    final allSuccessful = allResultsSuccessful([addResult, ...removeResults]);

    if (allSuccessful) {
      final updatedLists = updateListLocally(state.editedListToSave!);
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
