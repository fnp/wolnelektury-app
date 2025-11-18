import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_settings_service.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/book_text_audio_sync_model.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/domain/reader_book_model.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'reading_page_cubit.freezed.dart';
part 'reading_page_state.dart';

class ReadingPageCubit extends SafeCubit<ReadingPageState> {
  // ------------------------------------------
  // Private fields
  // ------------------------------------------
  static double _fontSizeMultiplier = 9;

  DateTime? _lastProgressSent;
  bool _readyToSetProgress = false;

  final AppStorageSettingsService _settingsStorage;
  final BooksRepository _booksRepository;
  final ProgressRepository _progressRepository;

  // ------------------------------------------
  // Constructor
  // ------------------------------------------
  ReadingPageCubit(
    this._settingsStorage,
    this._booksRepository,
    this._progressRepository,
  ) : super(const ReadingPageState());

  // ------------------------------------------
  // Initialization
  // ------------------------------------------
  Future<void> init({
    required BookModel book,
    required ItemScrollController itemScrollController,
    String? overrideProgressAnchor,
    bool tryOffline = false,
    double scaleFactor = 1,
  }) async {
    _fontSizeMultiplier = 9 * scaleFactor;
    emit(state.copyWith(isJsonLoading: true, isJsonLoadingError: false));
    final settings = await _settingsStorage.readReadingSettings();
    final bookJson = await _booksRepository.getBookJson(
      slug: book.slug,
      tryOffline: tryOffline,
    );

    bookJson.handle(
      success: (data, _) async {
        await _getTextAudioSyncData(book.slug);
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
        emit(state.copyWith(isJsonLoading: false, isJsonLoadingError: true));
      },
    );
  }

  Future<void> _getTextAudioSyncData(String slug) async {
    final audioSyncData = await _booksRepository.getBookTextAudioSync(
      slug: slug,
    );
    audioSyncData.handle(
      success: (data, _) {
        emit(state.copyWith(audioSyncPairs: data));
      },
      failure: (_) {
        emit(state.copyWith(audioSyncPairs: []));
      },
    );
  }

  Future<void> _getAndSetProgress({
    required String slug,
    required ItemScrollController itemScrollController,
    String? overrideProgressAnchor,
  }) async {
    if (overrideProgressAnchor != null) {
      await _scrollToAnchor(
        anchor: overrideProgressAnchor,
        itemScrollController: itemScrollController,
      );
      return;
    }
    final progress = await _progressRepository.getProgressByBook(
      slug: state.currentSlug!,
    );
    progress.handle(
      success: (data, _) async {
        AppLogger.instance.d(
          'ReadingPageCubit',
          'Retrieved progress of the book ${state.currentSlug} with anchor ${data.textAnchor}',
        );
        emit(state.copyWith(progress: data));

        if (data.textAnchor == null) return;
        await _scrollToAnchor(
          anchor: data.textAnchor!,
          itemScrollController: itemScrollController,
        );
      },
      failure: (_) {
        _readyToSetProgress = true;
      },
    );
  }

  Future<void> _scrollToAnchor({
    required String anchor,
    required ItemScrollController itemScrollController,
  }) async {
    final foundIndex = state.findElementIndexByElementId(anchor);
    if (foundIndex != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      itemScrollController
          .scrollTo(
            index: foundIndex,
            duration: const Duration(milliseconds: 500),
            curve: defaultCurve,
          )
          .then((_) {
            _readyToSetProgress = true;
          });
    }
  }

  // ------------------------------------------
  // Progress management
  // ------------------------------------------
  Future<void> setProgress({required String? anchor}) async {
    // Didn't end up scrolling to the position yet
    if (!_readyToSetProgress) return;
    if (state.currentSlug == null || anchor == null) return;
    if (state.progress?.textAnchor == anchor) return;

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
    ProgressModel progress;
    if (state.progress == null) {
      progress = ProgressModel.fromText(
        slug: state.currentSlug!,
        textAnchor: anchor.toString(),
      );
    } else {
      progress = state.progress!.copyWith(textAnchor: anchor.toString());
    }

    final newProgress = await _progressRepository.setProgress(
      slug: state.currentSlug!,
      progress: progress,
      type: ProgressType.text,
    );

    newProgress.handle(
      success: (data, _) {
        emit(state.copyWith(progress: progress));
      },
      failure: (_) {},
    );
  }

  // ------------------------------------------
  // Settings management
  // ------------------------------------------
  void changeTextSize(double textSizeFactor) {
    emit(state.copyWith(textSizeFactor: textSizeFactor));
  }

  void changeFontType(ReaderFontType fontType) {
    emit(state.copyWith(fontType: fontType));
  }

  Future<void> saveSettings() async {
    await _settingsStorage.setReadingSettings(
      textSizeFactor: state.textSizeFactor,
      fontType: state.fontType,
    );
  }

  // ------------------------------------------
  // UI State management
  // ------------------------------------------
  void selectParagraph({int? index, ReaderBookModelContent? element}) {
    if (index == null && element == null) {
      emit(state.copyWith(isAddingBookmark: false));
    }
    emit(state.copyWith(selectedIndex: index, selectedParagraph: element));
  }

  void setVisualProgress(int index) {
    final maxLength = state.book?.contents.length ?? 1;
    final progress = (index / maxLength * 100).clamp(0, 100).floor();
    if (progress == state.visualProgress) return;
    emit(state.copyWith(visualProgress: progress));
  }

  // ------------------------------------------
  // Bookmarks
  // ------------------------------------------
  void toggleIsAddingBookmark() {
    emit(state.copyWith(isAddingBookmark: !state.isAddingBookmark));
  }

  // ------------------------------------------
}
