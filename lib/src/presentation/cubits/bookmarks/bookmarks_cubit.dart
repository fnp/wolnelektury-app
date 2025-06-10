import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'bookmarks_cubit.freezed.dart';
part 'bookmarks_state.dart';

class BookmarksCubit extends SafeCubit<BookmarksState> {
  final BooksRepository _booksRepository;
  BookmarksCubit(this._booksRepository) : super(const BookmarksState());

  Future<void> getBookmarks({required String slug}) async {
    emit(state.copyWith(isLoading: true));
    final bookmarks = await _booksRepository.getBookBookmarks(slug: slug);
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
      _delete(state.bookmarkToDelete!.href);
    }
    emit(state.copyWith(bookmarkToDelete: bookmark));

    await Future.delayed(const Duration(seconds: 5));
    if (state.bookmarkToDelete?.href == bookmark.href) {
      _delete(bookmark.href, shouldHandle: true);
    }
  }

  Future<void> _delete(String href, {bool shouldHandle = false}) async {
    await _booksRepository.deleteBookmark(href: href);
    final bookmarks = List<BookmarkModel>.from(state.bookmarks);
    bookmarks.removeWhere((e) => e.href == href);
    emit(state.copyWith(bookmarks: bookmarks));
    if (!shouldHandle) return;
    emit(state.copyWith(bookmarkToDelete: null));
  }

  Future<void> updateBookmark({required String note}) async {
    if (state.editingBookmark == null) return;
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _booksRepository.updateBookmark(
      href: state.editingBookmark!.href,
      slug: state.editingBookmark!.slug,
      anchorId: int.tryParse(state.editingBookmark!.anchor) ?? 0,
      note: note,
    );

    response.handle(
      success: (data, _) {
        final bookmarks = List<BookmarkModel>.from(state.bookmarks).map((e) {
          if (e.href == data.href) {
            return data;
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
    final response = await _booksRepository.deleteBookmark(
      href: state.editingBookmark!.href,
    );

    response.handle(
      success: (data, _) {
        final bookmarks = List<BookmarkModel>.from(state.bookmarks);
        bookmarks.removeWhere((e) => e.href == state.editingBookmark!.href);
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
    required int anchorId,
    String? note,
  }) async {
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _booksRepository.createBookmark(
      slug: slug,
      anchorId: anchorId,
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
