import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/bookmark_model.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/presentation/enums/success_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'reading_page_cubit.freezed.dart';
part 'reading_page_state.dart';

class ReadingPageCubit extends SafeCubit<ReadingPageState> {
  DateTime? _lastProgressSent;
  static const double _fontSizeMultiplier = 9;
  final AppStorageService _storageService;
  final BooksRepository _booksRepository;
  final ProgressRepository _progressRepository;
  ReadingPageCubit(
    this._storageService,
    this._booksRepository,
    this._progressRepository,
  ) : super(const ReadingPageState());

  Future<void> init({
    required BookModel book,
    required ItemScrollController itemScrollController,
  }) async {
    final settings = await _storageService.readReadingSettings();
    emit(state.copyWith(isJsonLoading: true));
    final bookJson = await _booksRepository.getBookJson(
      slug: book.slug,
    );

    bookJson.when(
      success: (data, _) async {
        await _getAndSetBookmarks(
          slug: book.slug,
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
        await _getAndSetProgress(
          slug: book.slug,
          itemScrollController: itemScrollController,
        );
      },
      failed: (failure) {
        //TODO handle error
        emit(state.copyWith(isJsonLoading: false));
      },
    );
  }

  Future<void> _getAndSetBookmarks({
    required String slug,
  }) async {
    final bookmarks = await _booksRepository.getBookBookmarks(
      slug: slug,
    );
    bookmarks.when(
      success: (data, _) {
        emit(state.copyWith(bookmarks: data));
      },
      failed: (_) {},
    );
  }

  Future<void> _getAndSetProgress({
    required String slug,
    required ItemScrollController itemScrollController,
  }) async {
    final progress = await _progressRepository.getTextProgressByBook(
      slug: state.currentSlug!,
    );
    progress.when(
      success: (data, _) async {
        AppLogger.instance.d(
          'ReadingPageCubit',
          'Retrievied progress of the book ${state.currentSlug} with anchor ${data.textAnchor}',
        );
        emit(state.copyWith(progress: data));
        final int? anchor = int.tryParse(data.textAnchor ?? '');
        if (anchor == null) return;
        final foundIndex = state.findElementIndexByParagraphIndex(anchor);
        if (foundIndex != null) {
          await Future.delayed(const Duration(milliseconds: 1));
          itemScrollController.scrollTo(
            index: foundIndex + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
      failed: (_) {},
    );
  }

  Future<void> setProgress({
    required int? anchor,
  }) async {
    if (state.currentSlug == null || anchor == null) return;
    if (state.progress?.textAnchor == anchor.toString()) return;

    final now = DateTime.now();
    if (_lastProgressSent != null &&
        now.difference(_lastProgressSent!) < const Duration(seconds: 4)) {
      // Debounce is active, ignore rest
      return;
    }

    _lastProgressSent = now;
    AppLogger.instance.d(
      'ReadingPageCubit',
      'Setting progress of the book ${state.currentSlug} to $anchor',
    );
    final newProgress = await _progressRepository.setTextProgress(
      slug: state.currentSlug!,
      textAnchor: anchor,
    );

    newProgress.when(
      success: (data, _) {
        emit(state.copyWith(progress: data));
      },
      failed: (_) {},
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
