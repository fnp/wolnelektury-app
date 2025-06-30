import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

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
    int? overrideProgressAnchor,
    bool tryOffline = false,
  }) async {
    final settings = await _storageService.readReadingSettings();
    emit(state.copyWith(isJsonLoading: true));
    final bookJson = await _booksRepository.getBookJson(
      slug: book.slug,
      tryOffline: tryOffline,
    );

    bookJson.handle(
      success: (data, _) async {
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
          overrideProgressAnchor: overrideProgressAnchor,
        );
      },
      failure: (failure) {
        //TODO handle error
        emit(state.copyWith(isJsonLoading: false));
      },
    );
  }

  Future<void> _getAndSetProgress({
    required String slug,
    required ItemScrollController itemScrollController,
    int? overrideProgressAnchor,
  }) async {
    if (overrideProgressAnchor != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      itemScrollController.scrollTo(
        index: overrideProgressAnchor,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      return;
    }
    final progress = await _progressRepository.getTextProgressByBook(
      slug: state.currentSlug!,
    );
    progress.handle(
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
      failure: (_) {},
    );
  }

  Future<void> setProgress({required int? anchor}) async {
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

    newProgress.handle(
      success: (data, _) {
        emit(state.copyWith(progress: data));
      },
      failure: (_) {},
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
      emit(state.copyWith(isAddingBookmark: false));
    }
    emit(state.copyWith(selectedIndex: index, selectedParagraph: element));
  }

  // ------------------------------------------
  // Bookmarks
  // ------------------------------------------
  void toggleIsAddingBookmark() {
    emit(state.copyWith(isAddingBookmark: !state.isAddingBookmark));
  }

  // ------------------------------------------
}
