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

  void addElement({String? bookSlug, String? bookmarkUuid, String? listSlug}) {
    final list = state.editedListToSave;
    if (list == null) return;

    final newItem = ListItemModel.create(
      listSlug: listSlug ?? list.slug,
      bookSlug: bookSlug,
      bookmarkUuid: bookmarkUuid,
    );

    final updatedItems = [...list.items, newItem];
    final updatedEditedList = list.copyWith(items: updatedItems);
    emit(state.copyWith(editedListToSave: updatedEditedList));
    if (state.itemsToRemove.any((item) {
      return item.itemIdentifier == bookSlug ||
          item.itemIdentifier == bookmarkUuid;
    })) {
      _addOrRemoveElementFromRemovingQueue(newItem);
    } else {
      _addOrRemoveElementFromAddingQueue(newItem);
    }
  }

  void removeElement({
    String? bookSlug,
    String? bookmarkUuid,
    String? listSlug,
  }) {
    final list = state.editedListToSave;
    if (list == null) return;

    final updatedItems = List<ListItemModel>.from(list.items).where((i) {
      return i.itemIdentifier != bookSlug && i.itemIdentifier != bookmarkUuid;
    }).toList();
    final updatedEditedList = list.copyWith(items: updatedItems);
    final elementModel = ListItemModel.create(
      listSlug: listSlug ?? list.slug,
      bookSlug: bookSlug,
      bookmarkUuid: bookmarkUuid,
    );
    emit(state.copyWith(editedListToSave: updatedEditedList));
    if (state.itemsToAdd.any((item) {
      return item.itemIdentifier == bookSlug ||
          item.itemIdentifier == bookmarkUuid;
    })) {
      _addOrRemoveElementFromAddingQueue(elementModel);
    } else {
      _addOrRemoveElementFromRemovingQueue(elementModel);
    }
  }

  void _addOrRemoveElementFromAddingQueue(ListItemModel item) {
    final currentQueue = List<ListItemModel>.from(state.itemsToAdd);
    if (currentQueue.any((i) => i.itemIdentifier == item.itemIdentifier)) {
      currentQueue.removeWhere((i) => i.itemIdentifier == item.itemIdentifier);
      emit(state.copyWith(itemsToAdd: currentQueue));
      return;
    }
    currentQueue.add(item);
    emit(state.copyWith(itemsToAdd: currentQueue));
  }

  void _addOrRemoveElementFromRemovingQueue(ListItemModel item) {
    final currentQueue = List<ListItemModel>.from(state.itemsToRemove);
    if (currentQueue.any((i) => i.itemIdentifier == item.itemIdentifier)) {
      currentQueue.removeWhere((i) => i.itemIdentifier == item.itemIdentifier);
      emit(state.copyWith(itemsToRemove: currentQueue));
      return;
    }
    currentQueue.add(item);
    emit(state.copyWith(itemsToRemove: currentQueue));
  }

  Future<void> saveList() async {
    if (state.editedListToSave == null) return;
    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));
    final itemsToAdd = state.itemsToAdd;
    final itemsToRemove = state.itemsToRemove;

    if (itemsToRemove.isNotEmpty) {
      final removeResults = await Future.wait(
        itemsToRemove.map((item) {
          return _listsRepository.deleteListItem(
            itemUuid: state.getItemUuidByIdentifier(item.itemIdentifier!)!,
          );
        }),
      );

      if (removeResults.any((result) => !result.isSuccess)) {
        emit(state.copyWith(isSavingEditedList: false, isSavingFailure: true));
        return;
      }
    }

    if (itemsToAdd.isNotEmpty) {
      final addResult = await _listsRepository.addItemsToList(
        listSlug: state.editedListToSave!.slug,
        items: itemsToAdd,
      );

      if (!addResult.isSuccess) {
        emit(state.copyWith(isSavingEditedList: false, isSavingFailure: true));
        return;
      }
    }

    emit(state.copyWith(isSavingEditedList: false, isSavingSuccess: true));
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
