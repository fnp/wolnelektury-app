import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'reading_page_cubit.freezed.dart';
part 'reading_page_state.dart';

class ReadingPageCubit extends SafeCubit<ReadingPageState> {
  static const double _fontSizeMultiplier = 9;
  final AppStorageService _storageService;
  final BooksRepository _booksRepository;
  ReadingPageCubit(this._storageService, this._booksRepository)
      : super(const ReadingPageState());

  Future<void> init({
    required BookModel book,
  }) async {
    final settings = await _storageService.readReadingSettings();
    emit(state.copyWith(isJsonLoading: true));
    final bookJson = await _booksRepository.getBookJson(
      slug: book.slug,
    );

    bookJson.when(
      success: (data, _) async {
        final bookmarks = await _booksRepository.getBookBookmarks(
          slug: book.slug,
        );
        bookmarks.when(
          success: (bookmarks, _) {
            emit(state.copyWith(bookmarks: bookmarks));
          },
          failed: (_) {},
        );
        emit(
          state.copyWith(
            currentSlug: book.slug,
            textSizeFactor: settings.readingFontSize,
            fontType: readerFontTypeFromString(settings.readingFontType),
            isJsonLoading: false,
            book: data,
          ),
        );
      },
      failed: (failure) {
        //TODO handle error
        emit(state.copyWith(isJsonLoading: false));
      },
    );
  }

  void changeTextSize(double textSizeFactor) {
    emit(state.copyWith(textSizeFactor: textSizeFactor));
  }

  void changeFontType(ReaderFontType fontType) {
    emit(state.copyWith(fontType: fontType));
  }

  Future<void> saveSettings() async {
    await _storageService.setReadingSettings(
      textSizeFactor: state.textSizeFactor,
      fontType: state.fontType,
    );
  }

  void selectParagraph({int? index, ReaderBookModelContent? element}) {
    if (index == null && element == null) {
      emit(state.copyWith(isAddingBookmark: false, editingBookmark: null));
    }
    emit(state.copyWith(selectedIndex: index, selectedParagraph: element));
  }

  // ------------------------------------------
  // Bookmarks
  // ------------------------------------------
  void toggleIsAddingBookmark() {
    emit(state.copyWith(isAddingBookmark: !state.isAddingBookmark));
  }

  void setEditingBookmark(BookmarkModel? bookmark) {
    emit(state.copyWith(editingBookmark: bookmark));
  }

  Future<void> createBookmark({
    required int anchorId,
    String? note,
  }) async {
    if (state.currentSlug == null) return;
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _booksRepository.createBookmark(
      slug: state.currentSlug!,
      anchorId: anchorId,
      note: note,
    );

    response.when(
      success: (data, _) {
        emit(
          state.copyWith(
            isBookmarkSuccess: (Success.create, true),
            bookmarks: [...state.bookmarks, data],
          ),
        );
      },
      failed: (_) {
        emit(state.copyWith(isBookmarkSuccess: (Success.create, false)));
      },
    );
  }

  Future<void> updateBookmark({
    required String note,
  }) async {
    if (state.editingBookmark == null) return;
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _booksRepository.updateBookmark(
      href: state.editingBookmark!.href,
      slug: state.editingBookmark!.slug,
      anchorId: int.tryParse(state.editingBookmark!.anchor) ?? 0,
      note: note,
    );

    response.when(
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
      failed: (_) {
        emit(state.copyWith(isBookmarkSuccess: (Success.update, false)));
      },
    );
  }

  Future<void> deleteBookmark() async {
    if (state.editingBookmark == null) return;
    emit(state.copyWith(isBookmarkSuccess: null));
    final response = await _booksRepository.deleteBookmark(
      href: state.editingBookmark!.href,
    );

    response.when(
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
      failed: (_) {
        emit(state.copyWith(isBookmarkSuccess: (Success.delete, false)));
      },
    );
  }
  // ------------------------------------------
}
