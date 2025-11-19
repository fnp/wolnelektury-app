import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/domain/book_list_model.dart';
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

  /// Creates a copy of the all lists with the specified list updated
  List<BookListModel> _updateListInAllLists(BookListModel updatedList) {
    final currentLists = List<BookListModel>.from(state.allLists);
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
  BookListModel? _findList({String? name, String? slug}) {
    return state.allLists.firstWhereOrNull(
      (list) =>
          (name != null && list.name == name) ||
          (slug != null && list.slug == slug),
    );
  }

  /// Checks if a book exists in remove queue for specific list
  bool _isBookInRemoveQueue(String bookSlug, String listName) {
    return state.booksToRemove.any(
      (item) => item.$3 == bookSlug && item.$2 == listName,
    );
  }

  /// Checks if a book exists in add queue for specific list
  bool _isBookInAddQueue(String bookSlug, String listName) {
    return state.booksToAdd.any(
      (list) => list.books.contains(bookSlug) && list.name == listName,
    );
  }

  /// Removes book from remove queue
  void _removeFromRemoveQueue(String bookSlug, String listName) {
    final updatedRemoveQueue = List<BookToRemove>.from(state.booksToRemove);
    updatedRemoveQueue.removeWhere(
      (item) => item.$3 == bookSlug && item.$2 == listName,
    );
    emit(state.copyWith(booksToRemove: updatedRemoveQueue));
  }

  /// Removes book from add queue for specific list
  void _removeFromAddQueue(String bookSlug, String listName) {
    final updatedAddQueue = List<BookListModel>.from(state.booksToAdd);
    final index = updatedAddQueue.indexWhere((list) => list.name == listName);
    if (index > -1) {
      final books = List<String>.from(updatedAddQueue[index].books);
      books.remove(bookSlug);
      if (books.isEmpty) {
        updatedAddQueue.removeAt(index);
      } else {
        updatedAddQueue[index] = updatedAddQueue[index].copyWith(books: books);
      }
    }
    emit(state.copyWith(booksToAdd: updatedAddQueue));
  }

  /// Updates books in local list state
  List<BookListModel> _updateBooksInList(
    String listName,
    String bookSlug, {
    required bool add,
  }) {
    final currentLists = List<BookListModel>.from(state.allLists);
    final index = currentLists.indexWhere((list) => list.name == listName);
    if (index != -1) {
      final list = currentLists[index];
      final books = List<String>.from(list.books);
      if (add && !books.contains(bookSlug)) {
        books.add(bookSlug);
        currentLists[index] = list.copyWith(books: books);
      } else if (!add && books.contains(bookSlug)) {
        books.remove(bookSlug);
        currentLists[index] = list.copyWith(books: books);
      }
    }
    return currentLists;
  }

  /// Updates edited list by adding or removing a book
  void _updateEditedList(String bookSlug, {required bool add}) {
    if (state.editedListToSave == null) return;

    final updatedBooks = List<String>.from(state.editedListToSave!.books);
    bool shouldUpdate = false;

    if (add && !updatedBooks.contains(bookSlug)) {
      updatedBooks.add(bookSlug);
      shouldUpdate = true;
    } else if (!add && updatedBooks.contains(bookSlug)) {
      updatedBooks.remove(bookSlug);
      shouldUpdate = true;
    }

    if (shouldUpdate) {
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            books: updatedBooks,
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

  /// Processes books to add queue
  Future<List<DataState>> _processBooksToAdd() async {
    final responses = <DataState>[];

    for (final element in state.booksToAdd) {
      final result = element.slug.isNotEmpty
          ? await _listsRepository.addBooksToList(
              listSlug: element.slug,
              bookSlugs: element.books,
            )
          : await _listsRepository.createList(
              listName: element.name,
              bookSlugs: element.books,
            );
      responses.add(result);
    }

    return responses;
  }

  /// Processes books to remove queue
  Future<List<DataState>> _processBooksToRemove() async {
    final responses = <DataState>[];

    for (final element in state.booksToRemove) {
      final result = await _listsRepository.deleteBookFromList(
        listSlug: element.$1,
        bookSlug: element.$3,
      );
      responses.add(result);
    }

    return responses;
  }

  /// Calculates only new books that need to be added
  List<String> _getNewBooksToAdd() {
    final originalBooks = state.editedList?.books ?? [];
    return state.editedListToSave?.books
            .where((book) => !originalBooks.contains(book))
            .toList() ??
        [];
  } // --------------------------

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
      failure: (failure) {
        emit(state.copyWith(isLoading: false, allLists: const []));
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
    emit(state.copyWith(isLoading: true));
    final response = await _listsRepository.getList(listSlug: listSlug);
    response.handle(
      success: (list, _) {
        emit(state.copyWith(isLoading: false, fetchedSingleList: list));
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // ------ Bottom Sheet ------
  // --------------------------
  void newList(String listName, {List<String> bookSlugs = const []}) {
    if (state.listNameIsDuplicate(listName)) {
      return;
    }

    // Remove duplicates from bookSlugs before creating the list
    final uniqueBookSlugs = bookSlugs.toSet().toList();

    final newList = BookListModel(
      name: listName,
      books: uniqueBookSlugs,
      slug: '',
    );
    final newState = List<BookListModel>.from(state.allLists);
    newState.add(newList);

    for (final bookSlug in uniqueBookSlugs) {
      _addBookToAddQueue(
        listName: newList.name,
        listSlug: newList.slug,
        bookSlug: bookSlug,
      );
    }
    emit(state.copyWith(allLists: newState));
  }

  void addBookToListWithQueue(String listName, String bookSlug) {
    final list = _findList(name: listName);
    if (list != null && !list.books.contains(bookSlug)) {
      final updatedLists = _updateBooksInList(listName, bookSlug, add: true);
      _addBookToAddQueue(
        listName: listName,
        bookSlug: bookSlug,
        listSlug: list.slug,
      );
      emit(state.copyWith(allLists: updatedLists));
    }
  }

  void removeBookFromListWithQueue(String listName, String bookSlug) {
    final list = _findList(name: listName);
    if (list != null && list.books.contains(bookSlug)) {
      final updatedLists = _updateBooksInList(listName, bookSlug, add: false);
      _addBookToRemoveQueue(
        listSlug: list.slug,
        listName: list.name,
        bookSlug: bookSlug,
      );
      emit(state.copyWith(allLists: updatedLists));
    }
  }

  Future<void> save() async {
    if (state.booksToAdd.isEmpty && state.booksToRemove.isEmpty) {
      return;
    }

    emit(state.copyWith(isSuccess: true));

    final addResponses = await _processBooksToAdd();
    final removeResponses = await _processBooksToRemove();
    final allResponses = [...addResponses, ...removeResponses];

    emit(
      state.copyWith(
        booksToAdd: [],
        booksToRemove: [],
        isSuccess: allResponses.every((response) => response.isSuccess),
      ),
    );

    // Reinitialize the state to fetch the latest lists
    getLists(force: true);
  }

  void _addBookToAddQueue({
    required String listName,
    required String listSlug,
    required String bookSlug,
  }) {
    // Check if the book isn't in local removeQueue
    if (_isBookInRemoveQueue(bookSlug, listName)) {
      _removeFromRemoveQueue(bookSlug, listName);
      return;
    }

    final newState = List<BookListModel>.from(state.booksToAdd);
    final index = newState.indexWhere((element) => element.name == listName);
    if (index > -1) {
      final books = List<String>.from(newState[index].books);
      // Check if book is not already in the list to avoid duplicates
      if (!books.contains(bookSlug)) {
        books.add(bookSlug);
        newState[index] = newState[index].copyWith(books: books);
        emit(state.copyWith(booksToAdd: newState));
      }
    } else {
      final newList = BookListModel(
        name: listName,
        books: [bookSlug],
        slug: listSlug,
      );
      newState.add(newList);
      emit(state.copyWith(booksToAdd: newState));
    }
  }

  void _addBookToRemoveQueue({
    required String listSlug,
    required String listName,
    required String bookSlug,
  }) {
    // Check if the books isn't in local addQueue
    if (_isBookInAddQueue(bookSlug, listName)) {
      _removeFromAddQueue(bookSlug, listName);
      return;
    }

    // Check if the book is not already in the remove queue to avoid duplicates
    if (!_isBookInRemoveQueue(bookSlug, listName)) {
      final toRemove = List<BookToRemove>.from(state.booksToRemove);
      toRemove.add((listSlug, listName, bookSlug));
      emit(state.copyWith(booksToRemove: toRemove));
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
    final newState = List<BookListModel>.from(state.allLists);
    final prevState = List<BookListModel>.from(state.allLists);
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

  void undoRemoveBookFromList() {
    emit(state.copyWith(bookToRemoveFromList: null));
  }

  Future<void> removeBookFromList({
    required String listSlug,
    required String bookSlug,
  }) async {
    if (state.bookToRemoveFromList != null) {
      _deleteBookFromList(
        listSlug: state.bookToRemoveFromList!.$1,
        bookSlug: state.bookToRemoveFromList!.$2,
        shouldHandle: false,
      );
    }
    emit(state.copyWith(bookToRemoveFromList: (listSlug, bookSlug)));
    await Future.delayed(const Duration(seconds: 3));
    if (state.bookToRemoveFromList?.$1 != listSlug ||
        state.bookToRemoveFromList?.$2 != bookSlug) {
      return; // Book was reverted from the deletion, do nothing
    }
    _deleteBookFromList(listSlug: listSlug, bookSlug: bookSlug);
  }

  Future<void> _deleteBookFromList({
    required String listSlug,
    required String bookSlug,
    bool shouldHandle = false,
  }) async {
    final previousLists = List<BookListModel>.from(state.allLists);
    final index = previousLists.indexWhere((e) => e.slug == listSlug);
    if (index == -1) return;

    final updatedList = previousLists[index].copyWith(
      books: List<String>.from(previousLists[index].books)..remove(bookSlug),
    );

    final updatedLists = List<BookListModel>.from(previousLists)
      ..[index] = updatedList;

    emit(state.copyWith(allLists: updatedLists));
    final response = await _listsRepository.deleteBookFromList(
      listSlug: listSlug,
      bookSlug: bookSlug,
    );
    if (!shouldHandle) return;

    response.handle(
      success: (_, __) {
        // Book removed successfully, no further action needed
        emit(state.copyWith(bookToRemoveFromList: null));
      },
      failure: (_) {
        // Revert state on failure
        emit(
          state.copyWith(allLists: previousLists, bookToRemoveFromList: null),
        );
      },
    );
  }

  Future<void> addEmptyList({required String name}) async {
    if (state.listNameIsDuplicate(name)) {
      return;
    }
    emit(state.copyWith(isAdding: true, isAddingFailure: false));
    await Future.delayed(const Duration(milliseconds: 1));
    emit(
      state.copyWith(
        pendingList: BookListModel(name: name, slug: '', books: []),
      ),
    );
    final result = await _listsRepository.createList(
      listName: name,
      bookSlugs: [],
    );
    await Future.delayed(const Duration(milliseconds: 300));
    result.handle(
      success: (data, _) {
        final newState = List<BookListModel>.from(state.allLists);
        newState.insert(0, BookListModel(name: name, books: [], slug: data));
        emit(state.copyWith(isAdding: false, allLists: newState));
      },
      failure: (failure) {
        emit(state.copyWith(isAdding: false, isAddingFailure: true));
      },
    );

    emit(state.copyWith(pendingList: null));
  }

  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // -------- App Mode --------
  // --------------------------

  // Using listName because we need to retrieve up2date list from the state
  void setListAsEdited(String listName) {
    final list = _findList(name: listName);
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
    final newBooks = _getNewBooksToAdd();
    final result = await _listsRepository.addBooksToList(
      listSlug: state.editedListToSave!.slug,
      bookSlugs: newBooks,
    );

    result.handle(
      success: (data, _) {
        final updatedLists = _updateListInAllLists(state.editedListToSave!);
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
