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
  // -------- Fetching --------
  // --------------------------
  Future<void> init({bool force = false}) async {
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

  Future<void> loadMoreLists() async {
    if (state.pagination.next == null) return;

    emit(state.copyWith(isLoadingMore: true));
    final lists = await _listsRepository.getLists(
      url: state.pagination.next!.removeApiUrl,
    );

    lists.handle(
      success: (lists, pagination) {
        emit(
          state.copyWith(
            allLists: [...state.allLists, ...lists],
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
  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // ------ Bottom Sheet ------
  // --------------------------
  void newList(String listName, {List<String> bookSlugs = const []}) {
    final newList = BookListModel(name: listName, books: bookSlugs, slug: '');
    final newState = List<BookListModel>.from(state.allLists);
    if (state.listNameIsDuplicate(listName)) {
      return;
    }
    newState.add(newList);
    for (final bookSlug in bookSlugs) {
      _addBookToAddQueue(
        listName: newList.name,
        listSlug: newList.slug,
        bookSlug: bookSlug,
      );
    }
    emit(state.copyWith(allLists: newState));
  }

  void addBookToListWithQueue(String listName, String bookSlug) {
    final currentLists = List<BookListModel>.from(state.allLists);
    final index = currentLists.indexWhere(
      (element) => element.name == listName,
    );
    if (index != -1) {
      final list = currentLists[index];
      final books = List<String>.from(list.books);
      if (!books.contains(bookSlug)) {
        books.add(bookSlug);
        currentLists[index] = list.copyWith(books: books);
        _addBookToAddQueue(
          listName: listName,
          bookSlug: bookSlug,
          listSlug: list.slug,
        );
        emit(state.copyWith(allLists: currentLists));
      }
    }
  }

  void removeBookFromListWithQueue(String listName, String bookSlug) {
    final currentLists = List<BookListModel>.from(state.allLists);
    final index = currentLists.indexWhere(
      (element) => element.name == listName,
    );
    if (index > -1) {
      final list = currentLists[index];
      final books = List<String>.from(list.books);
      if (books.contains(bookSlug)) {
        books.remove(bookSlug);
        currentLists[index] = list.copyWith(books: books);
        _addBookToRemoveQueue(
          listSlug: list.slug,
          listName: list.name,
          bookSlug: bookSlug,
        );
        emit(state.copyWith(allLists: currentLists));
      }
    }
  }

  Future<void> save() async {
    if (state.booksToAdd.isEmpty && state.booksToRemove.isEmpty) {
      return;
    }
    emit(state.copyWith(isSuccess: true));
    List<DataState> responses = [];

    for (final element in state.booksToAdd) {
      // Slug not empty, it means that the list already exists
      if (element.slug.isNotEmpty) {
        // List exists, we need to add books to it
        final result = await _listsRepository.addBooksToList(
          listSlug: element.slug,
          bookSlugs: element.books,
        );
        responses.add(result);
      } else {
        // List doesn't exist, we need to create it with books
        final result = await _listsRepository.createList(
          listName: element.name,
          bookSlugs: element.books,
        );
        responses.add(result);
      }
    }

    for (final element in state.booksToRemove) {
      // Remove books from lists by queue
      final result = await _listsRepository.deleteBookFromList(
        listSlug: element.$1,
        bookSlug: element.$3,
      );

      responses.add(result);
    }

    emit(
      state.copyWith(
        booksToAdd: [],
        booksToRemove: [],
        isSuccess: responses.every((element) => element.isSuccess),
      ),
    );

    // Reinitialize the state to fetch the latest lists
    init(force: true);
  }

  void _addBookToAddQueue({
    required String listName,
    required String listSlug,
    required String bookSlug,
  }) {
    // Check if the book isn't in local removeQueue
    final alreadyInRemoveQueue = state.booksToRemove.any(
      (element) => element.$3 == bookSlug && element.$2 == listName,
    );
    if (alreadyInRemoveQueue) {
      // Remove it from the remove queue
      final newState = List<BookToRemove>.from(state.booksToRemove);
      newState.removeWhere(
        (element) => element.$3 == bookSlug && element.$2 == listName,
      );
      emit(state.copyWith(booksToRemove: newState));
      return;
    }

    final newState = List<BookListModel>.from(state.booksToAdd);
    final index = newState.indexWhere((element) => element.name == listName);
    if (index > -1) {
      final books = List<String>.from(newState[index].books);
      books.add(bookSlug);
      newState[index] = newState[index].copyWith(books: books);
      emit(state.copyWith(booksToAdd: newState));
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
    final alreadyInAddQueue = state.booksToAdd.any(
      (element) => element.books.contains(bookSlug) && element.name == listName,
    );
    if (alreadyInAddQueue) {
      // Remove it from the local add queue
      final newState = List<BookListModel>.from(state.booksToAdd);
      newState.removeWhere(
        (element) =>
            element.books.contains(bookSlug) && element.name == listName,
      );
      emit(state.copyWith(booksToAdd: newState));
      return;
    }
    // Add it to the remove queue
    final toRemove = List<BookToRemove>.from(state.booksToRemove);
    toRemove.add((listSlug, listName, bookSlug));
    emit(state.copyWith(booksToRemove: toRemove));
  }

  // --------------------------
  // --------------------------
  // --------------------------

  // --------------------------
  // ------- My Library -------
  // --------------------------

  Future<void> deleteList(String slug) async {
    emit(state.copyWith(deletingSlug: slug, isDeleteFailure: false));
    final newState = List<BookListModel>.from(state.allLists);
    newState.removeWhere((element) => element.slug == slug);
    emit(state.copyWith(allLists: newState));
    final result = await _listsRepository.deleteList(listSlug: slug);
    result.handle(
      success: (data, _) {
        emit(state.copyWith(deletingSlug: null));
      },
      failure: (failure) {
        emit(state.copyWith(isDeleteFailure: true, deletingSlug: null));
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
    final list = state.allLists.firstWhereOrNull(
      (element) => element.name == listName,
    );
    emit(state.copyWith(editedList: list, editedListToSave: list));
  }

  void addBookToEditedList(String bookSlug) {
    if (state.editedListToSave == null) return;

    final updatedBooks = List<String>.from(state.editedListToSave!.books);
    if (!updatedBooks.contains(bookSlug)) {
      updatedBooks.add(bookSlug);
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            books: updatedBooks,
          ),
        ),
      );
    }
  }

  void removeBookFromEditedList(String bookSlug) {
    if (state.editedListToSave == null) return;

    final updatedBooks = List<String>.from(state.editedListToSave!.books);
    if (updatedBooks.contains(bookSlug)) {
      updatedBooks.remove(bookSlug);
      emit(
        state.copyWith(
          editedListToSave: state.editedListToSave!.copyWith(
            books: updatedBooks,
          ),
        ),
      );
    }
  }

  void saveEditedList() async {
    if (state.editedListToSave == null) return;

    emit(state.copyWith(isSavingEditedList: true, isSavingFailure: false));
    final result = await _listsRepository.updateList(
      listSlug: state.editedListToSave!.slug,
      bookSlugs: state.editedListToSave!.books,
      listName: state.editedListToSave!.name,
    );

    result.handle(
      success: (data, _) {
        final updatedLists = List<BookListModel>.from(state.allLists);
        final index = updatedLists.indexWhere(
          (element) => element.slug == state.editedList!.slug,
        );
        if (index != -1) {
          updatedLists[index] = state.editedList!;
        }
        emit(
          state.copyWith(
            allLists: updatedLists,
            editedList: null,
            editedListToSave: null,
            isSavingEditedList: false,
          ),
        );
        // Reinitialize the state to fetch the latest lists
        init(force: true);
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
