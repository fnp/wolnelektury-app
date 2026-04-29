import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/list_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'list_editor_cubit.freezed.dart';
part 'list_editor_state.dart';

class ListEditorCubit extends SafeCubit<ListEditorState> {
  final ListsRepository _listsRepository;
  ListEditorCubit(this._listsRepository) : super(const ListEditorState());

  Future<void> setListToEdit(ListModel? list) async {
    emit(
      state.copyWith(
        editedList: list,
        editedListToSave: list,
        isSavingFailure: false,
        isSavingSuccess: false,
        itemsToAdd: [],
        itemsToRemove: [],
      ),
    );
  }

  Future<void> fetchBookListMemberships(String bookSlug) async {
    emit(
      state.copyWith(
        isFetchingMemberships: true,
        membershipsFetchFailure: false,
        currentBookSlug: bookSlug,
      ),
    );

    final result = await _listsRepository.getBookListMemberships(
      bookSlug: bookSlug,
    );

    result.handle(
      success: (items, _) {
        emit(
          state.copyWith(
            bookListMemberships: items.map((i) => i.listSlug).toSet(),
            bookListMembershipItems: items,
            isFetchingMemberships: false,
          ),
        );
      },
      failure: (_) {
        emit(
          state.copyWith(
            isFetchingMemberships: false,
            membershipsFetchFailure: true,
            bookListMemberships: {},
            bookListMembershipItems: [],
          ),
        );
      },
    );
  }

  void clearBookContext() {
    emit(
      state.copyWith(
        currentBookSlug: null,
        bookListMemberships: {},
        bookListMembershipItems: [],
        itemsToAdd: [],
        itemsToRemove: [],
        isFetchingMemberships: false,
        membershipsFetchFailure: false,
      ),
    );
  }

  void addElement({String? bookSlug, String? bookmarkUuid, String? listSlug}) {
    // Determine effective listSlug: use parameter if provided, or fall back to editedListToSave
    final effectiveListSlug = listSlug ?? state.editedListToSave?.slug;
    if (effectiveListSlug == null) return;

    final newItem = ListItemModel.create(
      listSlug: effectiveListSlug,
      bookSlug: bookSlug,
      bookmarkUuid: bookmarkUuid,
    );

    // Update editedListToSave only in Mode 1 (when editing a specific list)
    if (state.editedListToSave != null) {
      final updatedItems = [...state.editedListToSave!.items, newItem];
      final updatedEditedList = state.editedListToSave!.copyWith(
        items: updatedItems,
      );
      emit(state.copyWith(editedListToSave: updatedEditedList));
    }

    // Queue the item for adding (works in both Mode 1 and Mode 2)
    // Check if this specific item (identifier + listSlug) is in remove queue
    if (state.itemsToRemove.any((item) {
      return (item.itemIdentifier == bookSlug ||
              item.itemIdentifier == bookmarkUuid) &&
          item.listSlug == effectiveListSlug;
    })) {
      _addOrRemoveElementFromRemovingQueue(newItem);
    } else {
      _addOrRemoveElementFromAddingQueue(newItem);
    }
  }

  void removeElement({
    String? uuid,
    String? bookSlug,
    String? bookmarkUuid,
    String? listSlug,
  }) {
    // Determine effective listSlug: use parameter if provided, or fall back to editedListToSave
    final effectiveListSlug = listSlug ?? state.editedListToSave?.slug;
    if (effectiveListSlug == null) return;

    // Update editedListToSave only in Mode 1 (when editing a specific list)
    if (state.editedListToSave != null) {
      final updatedItems =
          List<ListItemModel>.from(state.editedListToSave!.items).where((i) {
            return i.itemIdentifier != bookSlug &&
                i.itemIdentifier != bookmarkUuid;
          }).toList();
      final updatedEditedList = state.editedListToSave!.copyWith(
        items: updatedItems,
      );
      emit(state.copyWith(editedListToSave: updatedEditedList));
    }

    // Get existing item UUID if available
    // In Mode 2, try to find UUID from bookListMembershipItems
    String? existingItemUuid;
    if (state.currentBookSlug != null) {
      // Mode 2: Find UUID from membership items
      existingItemUuid = state.bookListMembershipItems
          .firstWhereOrNull(
            (item) =>
                item.listSlug == effectiveListSlug &&
                item.itemIdentifier == (bookSlug ?? bookmarkUuid),
          )
          ?.uuid;
    } else {
      // Mode 1: Use existing method
      existingItemUuid = state.getItemUuidByIdentifier(
        bookSlug ?? bookmarkUuid ?? '',
      );
    }

    final elementModel = ListItemModel.create(
      uuid: existingItemUuid,
      listSlug: effectiveListSlug,
      bookSlug: bookSlug,
      bookmarkUuid: bookmarkUuid,
    );

    // Queue the item for removal (works in both Mode 1 and Mode 2)
    // Check if this specific item (identifier + listSlug) is in add queue
    if (state.itemsToAdd.any((item) {
      return (item.itemIdentifier == bookSlug ||
              item.itemIdentifier == bookmarkUuid) &&
          item.listSlug == effectiveListSlug;
    })) {
      _addOrRemoveElementFromAddingQueue(elementModel);
    } else {
      _addOrRemoveElementFromRemovingQueue(elementModel);
    }
  }

  void _addOrRemoveElementFromAddingQueue(ListItemModel item) {
    final currentQueue = List<ListItemModel>.from(state.itemsToAdd);
    // In Mode 2, same book can be on multiple lists - compare both identifier and listSlug
    if (currentQueue.any(
      (i) =>
          i.itemIdentifier == item.itemIdentifier &&
          i.listSlug == item.listSlug,
    )) {
      currentQueue.removeWhere(
        (i) =>
            i.itemIdentifier == item.itemIdentifier &&
            i.listSlug == item.listSlug,
      );
      emit(state.copyWith(itemsToAdd: currentQueue));
      return;
    }
    currentQueue.add(item);
    emit(state.copyWith(itemsToAdd: currentQueue));
  }

  void _addOrRemoveElementFromRemovingQueue(ListItemModel item) {
    final currentQueue = List<ListItemModel>.from(state.itemsToRemove);
    // In Mode 2, same book can be on multiple lists - compare both identifier and listSlug
    if (currentQueue.any(
      (i) =>
          i.itemIdentifier == item.itemIdentifier &&
          i.listSlug == item.listSlug,
    )) {
      currentQueue.removeWhere(
        (i) =>
            i.itemIdentifier == item.itemIdentifier &&
            i.listSlug == item.listSlug,
      );
      emit(state.copyWith(itemsToRemove: currentQueue));
      return;
    }
    currentQueue.add(item);
    emit(state.copyWith(itemsToRemove: currentQueue));
  }

  Future<void> saveList() async {
    final itemsToAdd = state.itemsToAdd;
    final itemsToRemove = state.itemsToRemove;

    // Nothing to save if queues are empty
    if (itemsToAdd.isEmpty && itemsToRemove.isEmpty) return;

    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));

    // Handle removals (works for both Mode 1 and Mode 2)
    if (itemsToRemove.isNotEmpty) {
      final removeResults = await _listsRepository.deleteListItems(
        itemUuids: itemsToRemove
            .where((item) => item.uuid != null)
            .map((item) => item.uuid!)
            .toList(),
      );

      if (!removeResults.isSuccess) {
        emit(state.copyWith(isSavingEditedList: false, isSavingFailure: true));
        return;
      }
    }

    // Handle additions - different logic for Mode 1 vs Mode 2
    if (itemsToAdd.isNotEmpty) {
      // Detect mode: Mode 2 = book editing (currentBookSlug is set)
      final isMode2 = state.currentBookSlug != null;

      if (isMode2) {
        // Mode 2: Group items by listSlug and add to each list separately
        final itemsByList = itemsToAdd.groupListsBy((item) => item.listSlug);

        for (final entry in itemsByList.entries) {
          final addResult = await _listsRepository.addItemsToList(
            listSlug: entry.key,
            items: entry.value,
          );

          if (!addResult.isSuccess) {
            emit(
              state.copyWith(isSavingEditedList: false, isSavingFailure: true),
            );
            return;
          }
        }
      } else {
        // Mode 1: All items go to the same list
        if (state.editedListToSave == null) {
          emit(
            state.copyWith(isSavingEditedList: false, isSavingFailure: true),
          );
          return;
        }

        final addResult = await _listsRepository.addItemsToList(
          listSlug: state.editedListToSave!.slug,
          items: itemsToAdd,
        );

        if (!addResult.isSuccess) {
          emit(
            state.copyWith(isSavingEditedList: false, isSavingFailure: true),
          );
          return;
        }
      }
    }

    emit(
      state.copyWith(
        isSavingEditedList: false,
        isSavingSuccess: true,
        itemsToAdd: [],
        itemsToRemove: [],
      ),
    );
  }

  Future<void> saveSharedList(ListModel sharedList) async {
    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));

    final result = await _listsRepository.createList(
      listName: sharedList.name,
      items: sharedList.items,
    );

    result.handle(
      success: (newListSlug, _) {
        emit(state.copyWith(isSavingEditedList: false, isSavingSuccess: true));
      },
      failure: (failure) {
        emit(state.copyWith(isSavingEditedList: false, isSavingFailure: true));
      },
    );
  }

  void restoreListToItsPreviousState() {
    emit(state.copyWith(editedListToSave: state.editedList));
  }

  void resetState() {
    emit(const ListEditorState());
  }
}
