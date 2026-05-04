import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'lists_cubit.freezed.dart';
part 'lists_state.dart';

class ListsCubit extends SafeCubit<ListsState> {
  final ListsRepository _listsRepository;
  ListsCubit(this._listsRepository) : super(const ListsState());

  Future<void> getLists({bool force = false}) async {
    if (state.allLists.isNotEmpty && !force) {
      return;
    }
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

  Future<void> createList({
    required String name,
    Function(ListModel list)? onSuccess,
  }) async {
    // Emit adding state before making API call
    emit(
      state.copyWith(
        isAdding: true,
        isAddingFailure: false,
        isDuplicateFailure: false,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 1));

    if (state.allLists.any((e) => e.name == name)) {
      emit(state.copyWith(isDuplicateFailure: true));
      return;
    }
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
        emit(
          state.copyWith(
            isAdding: false,
            allLists: newState.toSet().toList(),
            pendingList: null,
          ),
        );
        onSuccess?.call(ListModel(name: name, slug: data));
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

  Future<void> removeItemFromList({required ListItemModel item}) async {
    // If there's already an item pending removal, remove it immediately without waiting for the timeout,
    //to avoid multiple items pending removal at the same time which would be confusing for the user
    if (state.softDeletedItem != null) {
      await deleteItemFromList(
        item: state.softDeletedItem!,
        removeFromUI: true,
        shouldHandle: false,
      );
    }
    // Set the item pending removal in the state
    emit(state.copyWith(softDeletedItem: item));
    // Wait for 3 seconds before actually removing the item, giving the user a chance to undo the action
    await Future.delayed(const Duration(seconds: 3));
    // If the item pending removal is not the same as the one we set before, it means the user has undone the action, so we do nothing
    if (state.softDeletedItem?.uuid != item.uuid ||
        state.softDeletedItem?.listSlug != item.listSlug) {
      return;
    }
    // Otherwise, we proceed to remove the item from the list
    deleteItemFromList(item: item, removeFromUI: true, shouldHandle: true);
  }

  Future<void> deleteItemFromList({
    required ListItemModel item,
    bool removeFromUI = false,
    bool shouldHandle = false,
  }) async {
    final ListModel? singleList = state.fetchedSingleList;

    // Only remove from UI if explicitly requested
    if (removeFromUI) {
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
    final response = await _listsRepository.deleteListItem(
      itemUuid: item.uuid!,
    );
    if (!shouldHandle) return;

    response.handle(
      success: (_, __) {
        // Item removed successfully, no further action needed
        emit(state.copyWith(softDeletedItem: null));
      },
      failure: (_) {
        // Revert state on failure
        emit(
          state.copyWith(fetchedSingleList: singleList, softDeletedItem: null),
        );
        return;
      },
    );
  }

  Future<void> renameList({
    required String listSlug,
    required String newName,
  }) async {
    emit(state.copyWith(isDuplicateFailure: false));
    if (state.allLists.any((e) => e.name == newName)) {
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
        emit(
          state.copyWith(
            fetchedSingleList: state.fetchedSingleList!.copyWith(name: newName),
            isRenaming: false,
          ),
        );
        // getLists(force: true);
      },
      failure: (failure) {
        emit(state.copyWith(isRenaming: false, isRenamingFailure: true));
      },
    );
  }

  void undoSoftRemoval() {
    emit(state.copyWith(softDeletedItem: null));
  }

  void resetState() {
    emit(const ListsState());
  }
}
