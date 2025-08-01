import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/bookmarks_repository.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'bookmarks_cubit.freezed.dart';
part 'bookmarks_state.dart';

class BookmarksCubit extends SafeCubit<BookmarksState> {
  final BookmarksRepository _bookmarksRepository;
  BookmarksCubit(this._bookmarksRepository) : super(const BookmarksState());

  // --------------------------
  // ------- My Library -------
  // --------------------------

  Future<void> getMyLibraryBookmarks() async {
    emit(state.copyWith(isLoading: true));
    final bookmarks = await _bookmarksRepository.getBookmarks();
    bookmarks.handle(
      success: (data, p) {
        emit(state.copyWith(bookmarks: data, isLoading: false));
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> loadMoreMyLibraryBookmarks() async {
    if (state.bookmarks.length % 10 != 0 || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final books = await _bookmarksRepository.getBookmarks(
      offset: state.bookmarks.length,
    );

    books.handle(
      success: (data, _) {
        emit(
          state.copyWith(
            bookmarks: [...state.bookmarks, ...data],
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingMore: false));
      },
    );
  }

  // --------------------------
  // --------------------------
  // --------------------------

  Future<void> getBookBookmarks({required String slug}) async {
    emit(state.copyWith(isLoading: true));
    final bookmarks = await _bookmarksRepository.getBookBookmarks(slug: slug);
    bookmarks.handle(
      success: (data, _) {
        emit(state.copyWith(isLoading: false, bookmarks: data));
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  void undoDeletion() {
    emit(state.copyWith(bookmarkToDelete: null));
  }

  Future<void> deleteBookmark({required BookmarkModel bookmark}) async {
    if (state.bookmarkToDelete != null) {
      _delete(
        location: state.bookmarkToDelete!.location,
        href: state.bookmarkToDelete!.href,
      );
    }
    emit(state.copyWith(bookmarkToDelete: bookmark));

    await Future.delayed(const Duration(seconds: 5));
    if (state.bookmarkToDelete?.location == bookmark.location) {
      _delete(
        location: bookmark.location,
        href: bookmark.href,
        shouldHandle: true,
      );
    }
  }

  Future<void> _delete({
    required String location,
    required String href,
    bool shouldHandle = false,
  }) async {
    _bookmarksRepository.deleteBookmark(id: location, href: href);
    final bookmarks = List<BookmarkModel>.from(state.bookmarks);
    bookmarks.removeWhere((e) => e.location == location);
    emit(state.copyWith(bookmarks: bookmarks));
    if (!shouldHandle) return;
    emit(state.copyWith(bookmarkToDelete: null));
  }

  Future<void> updateBookmark({required String note}) async {
    if (state.editingBookmark == null) return;
    emit(state.copyWith(isBookmarkSuccess: null));
    final newBookmark = state.editingBookmark!.copyWith(note: note);
    final response = await _bookmarksRepository.updateBookmark(
      updatedBookmark: newBookmark,
    );

    response.handle(
      success: (_, _) {
        final bookmarks = List<BookmarkModel>.from(state.bookmarks).map((e) {
          if (e.href == newBookmark.href) {
            return newBookmark;
          }
          return e;
        }).toList();
        emit(
          state.copyWith(
            isBookmarkSuccess: (Success.update, true),
            bookmarks: bookmarks,
            editingBookmark: null,
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(isBookmarkSuccess: (Success.update, false)));
      },
    );
  }

  Future<void> deleteBookmarkInstantly() async {
    if (state.editingBookmark == null) return;
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _bookmarksRepository.deleteBookmark(
      id: state.editingBookmark!.location,
      href: state.editingBookmark!.href,
    );

    response.handle(
      success: (data, _) {
        final bookmarks = List<BookmarkModel>.from(state.bookmarks);
        bookmarks.removeWhere(
          (e) => e.location == state.editingBookmark!.location,
        );
        emit(
          state.copyWith(
            isBookmarkSuccess: (Success.delete, true),
            bookmarks: bookmarks,
            editingBookmark: null,
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(isBookmarkSuccess: (Success.delete, false)));
      },
    );
  }

  void setEditingBookmark(BookmarkModel? bookmark) {
    emit(state.copyWith(editingBookmark: bookmark));
  }

  Future<void> createBookmark({
    required String slug,
    required String anchor,
    String? note,
  }) async {
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _bookmarksRepository.createBookmark(
      slug: slug,
      anchor: anchor,
      note: note,
    );

    response.handle(
      success: (data, _) {
        emit(
          state.copyWith(
            isBookmarkSuccess: (Success.create, true),
            bookmarks: [...state.bookmarks, data],
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(isBookmarkSuccess: (Success.create, false)));
      },
    );
  }
}
