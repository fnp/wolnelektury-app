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
import 'package:wolnelektury/src/enums/reader_font_type.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'reading_page_cubit.freezed.dart';
part 'reading_page_state.dart';

/// Cubit managing the state of the book reading page.
/// Handles content loading, reading progress management,
/// audio-text synchronization, and appearance customization.
class ReadingPageCubit extends SafeCubit<ReadingPageState> {
  // ------------------------------------------
  // Private fields
  // ------------------------------------------

  /// Font size multiplier based on device scale
  static double _fontSizeMultiplier = 9;

  /// Timestamp of last progress sent (for debouncing)
  DateTime? _lastProgressSent;

  /// Flag indicating whether reading progress can be saved
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

  /// Initializes the book reading page.
  ///
  /// [book] - book model to display
  /// [itemScrollController] - scroll controller for the list of elements
  /// [targetAnchor] - optional anchor to override progress
  /// [tryOffline] - whether to try loading content offline
  /// [scaleFactor] - font scale relative to system settings
  Future<void> init({
    required BookModel book,
    required ItemScrollController itemScrollController,
    String? targetAnchor,
    bool tryOffline = false,
    bool isCurrentlyPlayingAudioOfThisBook = false,
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
          targetAnchor: targetAnchor,
          isCurrentlyPlayingAudioOfThisBook: isCurrentlyPlayingAudioOfThisBook,
        );
      },
      failure: (failure) {
        emit(state.copyWith(isJsonLoading: false, isJsonLoadingError: true));
      },
    );
  }

  /// Fetches text-to-audio synchronization data for the book.
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

  /// Retrieves and sets the reading progress for the book.
  ///
  /// If [targetAnchor] is provided, scrolls to that anchor
  /// instead of the saved progress.
  Future<void> _getAndSetProgress({
    required String slug,
    required ItemScrollController itemScrollController,
    String? targetAnchor,
    bool isCurrentlyPlayingAudioOfThisBook = false,
  }) async {
    // Override progress with provided anchor
    if (targetAnchor != null) {
      // First reset any highlighting
      stopHighlighting();
      await _scrollToAnchor(
        anchor: targetAnchor,
        itemScrollController: itemScrollController,
        // Highlight to point out the overridden anchor
        markHighlighted: true,
      ).then((_) {
        enableHighlighting(true);
        // If audio is playing, do not disable highlighting
        if (isCurrentlyPlayingAudioOfThisBook) return;
        Future.delayed(const Duration(seconds: 3), () {
          enableHighlighting(false);
        });
      });
      return;
    }
    // Fetch saved progress
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

  /// Scrolls to a specific anchor in the book.
  ///
  /// Optionally highlights the paragraph if [markHighlighted] is true.
  Future<void> _scrollToAnchor({
    required String anchor,
    required ItemScrollController itemScrollController,
    bool markHighlighted = false,
  }) async {
    final foundIndex = state.findElementIndexByElementId(anchor);
    if (foundIndex != null) {
      if (markHighlighted) {
        if (state.highlightedIndex == foundIndex) return;
        emit(state.copyWith(highlightedIndex: foundIndex));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      itemScrollController
          .scrollTo(
            // + 1 because of the header element at the beggining
            index: foundIndex + 1,
            // This makes a little space above the element
            alignment: 0.1,
            duration: const Duration(milliseconds: 500),
            curve: defaultCurve,
          )
          .then((_) {
            _readyToSetProgress = true;
          });
    } else {
      // Mark as ready to set progress if no scrolling was needed
      _readyToSetProgress = true;
    }
  }

  // ------------------------------------------
  // Progress management
  // ------------------------------------------

  /// Saves reading progress to the server.
  ///
  /// Implements debouncing (4 seconds) to limit the number of requests.
  Future<void> setProgress({required String? anchor}) async {
    // Haven't scrolled to the proper position yet
    if (!_readyToSetProgress) return;
    if (state.currentSlug == null || anchor == null) return;
    if (state.progress?.textAnchor == anchor) return;

    final now = DateTime.now();
    if (_lastProgressSent != null &&
        now.difference(_lastProgressSent!) < const Duration(seconds: 4)) {
      // Debounce is active, ignore the rest
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

  /// Changes the text size in the reader.
  void changeTextSize(double textSizeFactor) {
    emit(state.copyWith(textSizeFactor: textSizeFactor));
  }

  /// Changes the font type in the reader.
  void changeFontType(ReaderFontType fontType) {
    emit(state.copyWith(fontType: fontType));
  }

  /// Saves reader settings to storage.
  Future<void> saveSettings() async {
    await _settingsStorage.setReadingSettings(
      textSizeFactor: state.textSizeFactor,
      fontType: state.fontType,
    );
  }

  // ------------------------------------------
  // UI State management
  // ------------------------------------------

  /// Selects a paragraph for further actions (e.g., adding a bookmark).
  void selectParagraph({int? index, ReaderBookModelContent? element}) {
    if (index == null && element == null) {
      emit(state.copyWith(isAddingBookmark: false));
    }
    emit(state.copyWith(selectedIndex: index, selectedParagraph: element));
  }

  /// Highlights a paragraph based on audio timestamp.
  ///
  /// Used for audiobook-to-text synchronization.
  void highlightParagraph({
    required ItemScrollController itemScrollController,
    int audioTimestamp = 0,
  }) {
    if (!state.isEnabledHighlighting) return;
    final pair = state.audioSyncPairs.lastWhereOrNull(
      (pair) => pair.timestamp <= audioTimestamp,
    );
    if (pair == null) {
      stopHighlighting();
      return;
    }
    _scrollToAnchor(
      anchor: pair.id,
      itemScrollController: itemScrollController,
      markHighlighted: true,
    );
  }

  /// Stops paragraph highlighting.
  void stopHighlighting() {
    emit(state.copyWith(highlightedIndex: null, isEnabledHighlighting: false));
  }

  /// Enables or disables the highlighting mechanism.
  void enableHighlighting(bool value) {
    emit(state.copyWith(isEnabledHighlighting: value));
  }

  /// Updates the visual reading progress (progress bar in UI).
  void setVisualProgress(int index) {
    final maxLength = state.book?.contents.length ?? 1;
    final progress = (index / maxLength * 100).clamp(0, 100).floor();
    if (progress == state.visualProgress) return;
    emit(state.copyWith(visualProgress: progress));
  }

  // ------------------------------------------
  // Bookmarks
  // ------------------------------------------

  /// Toggles bookmark adding mode.
  void toggleIsAddingBookmark() {
    emit(state.copyWith(isAddingBookmark: !state.isAddingBookmark));
  }
}
