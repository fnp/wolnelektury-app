import 'dart:io';
import 'dart:ui';

import 'package:file_saver/file_saver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage_extensions/app_storage_offline_service.dart';
import 'package:wolnelektury/src/data/audiobook_repository.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'download_cubit.freezed.dart';
part 'download_state.dart';

class DownloadCubit extends SafeCubit<DownloadState> {
  final AppStorageOfflineService _offlineStorage;
  final AudiobookRepository _audiobookRepository;
  final BooksRepository _booksRepository;

  bool _isCancelled = false;

  DownloadCubit(
    this._audiobookRepository,
    this._offlineStorage,
    this._booksRepository,
  ) : super(const DownloadState());

  // Resets the audiobook error states in the DownloadState
  void resetAudiobookErrors() {
    emit(
      state.copyWith(
        isAlreadyDownloadingAudiobookError: false,
        isGenericAudiobookError: false,
      ),
    );
  }

  // Resets the reader error states in the DownloadState
  void resetReaderErrors() {
    emit(
      state.copyWith(
        isAlreadyDownloadingReaderError: false,
        isGenericReaderError: false,
      ),
    );
  }

  // Updates the progress of the download
  void updateProgress(double progress) {
    emit(state.copyWith(progress: progress));
  }

  // Saves the book reader data to the app storage
  Future<void> saveReader({
    required BookModel book,
    VoidCallback? onFinish,
  }) async {
    resetReaderErrors();
    if (state.isDownloadingReader) {
      emit(state.copyWith(isAlreadyDownloadingReaderError: true));
      return;
    }
    emit(state.copyWith(downloadingBookReaderSlug: book.slug));
    // Fetch the book reader JSON from the repository
    final response = await _booksRepository.getBookJson(
      slug: book.slug,
      tryOffline: false,
    );
    response.handle(
      success: (data, _) async {
        try {
          final existingBook = await _getLocalBook(book.slug);
          // If the book already exists, we update the reader data
          // Otherwise, we create a new OfflineBookModel with the book and reader data
          final bookToSave = existingBook != null
              ? existingBook.copyWith(reader: data)
              : OfflineBookModel(book: book, reader: data);

          // Save the book with the reader data to the app storage
          await _offlineStorage.saveOfflineBook(book.slug, bookToSave);
        } catch (_) {
          // If something goes wrong during saving, emit an error state
          emit(state.copyWith(isGenericReaderError: true));
        } finally {
          onFinish?.call();
          emit(state.copyWith(downloadingBookReaderSlug: null));
        }
      },
      failure: (e) {
        emit(
          state.copyWith(
            downloadingBookReaderSlug: null,
            isGenericReaderError: true,
          ),
        );
      },
    );
  }

  // Initiates the download of an audiobook
  Future<void> downloadAudiobook({
    required BookModel book,
    VoidCallback? onFinish,
  }) async {
    // Reset any previous error states
    resetAudiobookErrors();
    // Check if any book is already being downloaded
    if (state.isDownloadingAudiobook) {
      emit(state.copyWith(isAlreadyDownloadingAudiobookError: true));
      // Return if any book is currently being downloaded
      return;
    }

    _isCancelled = false;
    // Starting point of the download process
    emit(
      state.copyWith(progress: 0.01, downloadingBookAudiobookSlug: book.slug),
    );

    // Fetch the audiobook parts from the repository/db
    final parts = await _audiobookRepository.getAudiobook(
      slug: book.slug,
      tryOffline: false,
    );
    parts.handle(
      success: (data, _) async {
        try {
          // We've got the parts, now we can save them locally
          await _saveAudiobookParts(book: book, parts: data);
        } catch (e) {
          // Something went wrong, abort, display error
          await cancelDownload();
          emit(state.copyWith(isGenericAudiobookError: true));
          return;
        }
        if (!_isCancelled) {
          // If download is not cancelled, update progress to 100%
          updateProgress(1);
          // Call the onFinish callback if provided
          onFinish?.call();
        }
        // Clear the downloading state after completion
        emit(state.copyWith(downloadingBookAudiobookSlug: null));
        // Delay to ensure the UI updates before resetting the state
        await Future.delayed(const Duration(milliseconds: 200));
        emit(const DownloadState());
      },
      failure: (e) {
        // If there was an error fetching the audiobook parts, display an error
        emit(state.copyWith(isGenericAudiobookError: true));
      },
    );
  }

  Future<void> _saveAudiobookParts({
    required BookModel book,
    required List<AudioBookPart> parts,
  }) async {
    // Total number of parts to save
    final total = parts.length;
    // Currently saved offline info about the book
    OfflineBookModel? existingBook = await _getLocalBook(book.slug);
    // List of the parts that are currently saved
    final currentParts = (existingBook?.audiobook?.parts ?? []).toList();

    // Book is downloaded, but not all parts are saved correctly,
    // clear the old files and proceed with the new ones
    if (existingBook != null &&
        existingBook.audiobook != null &&
        existingBook.isAudiobookCorrectlyDownloaded == false) {
      await _deleteOfflineFiles(
        files:
            existingBook.audiobook?.parts
                .map((part) => part.url)
                .where((url) => url.isNotEmpty)
                .toList() ??
            [],
      );
      await _removeAudiobook(existingBook.book.slug);
    }

    // Saving the parts one by one
    for (int i = 0; i < total; i++) {
      // Check if the download was cancelled
      if (_isCancelled) {
        // Get the local book to clean up any files
        final createdBook = await _getLocalBook(book.slug);
        // If the book was created, delete the offline files and remove the book
        if (createdBook != null) {
          await _deleteOfflineFiles(
            files:
                createdBook.audiobook?.parts
                    .map((part) => part.url)
                    .where((url) => url.isNotEmpty)
                    .toList() ??
                [],
          );
          await _removeAudiobook(createdBook.book.slug);
        }
        // Reset the state to initial progress
        emit(state.copyWith(progress: 0));
        return;
      }
      // Proceed with saving the part
      final part = parts[i];
      // Save the file using FileSaver
      final result = await FileSaver.instance.saveFile(
        name: part.name,
        ext: part.type,
        link: LinkDetails(link: part.url),
      );
      // Rewrite the part with the new URL and mark it as offline file
      final effectivePart = part.copyWith(url: result, isOffline: true);
      final isLastPart = i == total - 1;

      currentParts.add(effectivePart);

      existingBook = await saveAudiobook(
        book: book,
        parts: currentParts,
        isLastPart: isLastPart,
      );

      // Update the progress based on the current part index
      updateProgress((i + 1) / total * 0.95);
    }
  }

  Future<OfflineBookModel> saveAudiobook({
    required BookModel book,
    required List<AudioBookPart> parts,
    required bool isLastPart,
  }) async {
    final existingBook = await _getLocalBook(book.slug);
    if (existingBook == null) {
      // This means there's no existing book, we create a new one
      final offlineBook = OfflineBookModel(
        book: book,
        audiobook: AudiobookModel.create(parts: parts),
        isAudiobookCorrectlyDownloaded: isLastPart,
      );
      await _offlineStorage.saveOfflineBook(book.slug, offlineBook);
      return offlineBook;
    }
    // If the book already exists, we update the audiobook parts
    final updatedBook = existingBook.copyWith(
      audiobook: parts.isEmpty ? null : AudiobookModel.create(parts: parts),
      isAudiobookCorrectlyDownloaded: isLastPart,
    );
    await _offlineStorage.saveOfflineBook(book.slug, updatedBook);
    return updatedBook;
  }

  // Retrieves a local book by its slug
  Future<OfflineBookModel?> _getLocalBook(String slug) =>
      _offlineStorage.readOfflineBook(slug);

  // Deletes offline files based on the provided list of file URLs
  Future<void> _deleteOfflineFiles({required List<String> files}) async {
    try {
      await Future.wait(
        files.map((file) async {
          final fileToDelete = File(file);
          if (await fileToDelete.exists()) {
            await fileToDelete.delete();
          }
        }),
      );
    } catch (_) {
      // If we could delete, it's deleted, if not, we just ignore the error
    }
  }

  Future<void> _removeAudiobook(String slug) async {
    final existingBook = await _getLocalBook(slug);
    if (existingBook == null) return;
    if (existingBook.reader == null) {
      await _offlineStorage.removeOfflineBook(existingBook.book.slug);
      return;
    }
    // If the book has a reader, we just update the audiobook to null
    await saveAudiobook(book: existingBook.book, parts: [], isLastPart: false);
  }

  // Cancels the ongoing download process
  Future<void> cancelDownload() async {
    _isCancelled = true;
    emit(state.copyWith(progress: 0, downloadingBookAudiobookSlug: null));
  }
}
