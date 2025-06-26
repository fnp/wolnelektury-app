import 'dart:io';
import 'dart:ui';

import 'package:file_saver/file_saver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/data/audiobook_repository.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'download_cubit.freezed.dart';
part 'download_state.dart';

class DownloadCubit extends SafeCubit<DownloadState> {
  final AppStorageService _appStorageService;
  final AudiobookRepository _audiobookRepository;

  bool _isCancelled = false;

  DownloadCubit(this._audiobookRepository, this._appStorageService)
    : super(const DownloadState());

  // Resets the error states in the DownloadState
  void _resetErrors() {
    emit(
      state.copyWith(isAlreadyDownloadingError: false, isGenericError: false),
    );
  }

  // Updates the progress of the download
  void updateProgress(double progress) {
    emit(state.copyWith(progress: progress));
  }

  // Initiates the download of an audiobook
  Future<void> downloadAudiobook({
    required BookModel book,
    VoidCallback? onFinish,
  }) async {
    // Reset any previous error states
    _resetErrors();
    // Check if any book is already being downloaded
    if (state.isDownloading) {
      emit(state.copyWith(isAlreadyDownloadingError: true));
      // Return if any book is currently being downloaded
      return;
    }

    _isCancelled = false;
    // Starting point of the download process
    emit(state.copyWith(progress: 0.01, downloadingBookSlug: book.slug));

    // Fetch the audiobook parts from the repository/db
    final parts = await _audiobookRepository.getAudiobook(slug: book.slug);
    parts.handle(
      success: (data, _) async {
        try {
          // We've got the parts, now we can save them locally
          await _saveAudiobookParts(book: book, parts: data);
        } catch (e) {
          // Something went wrong, abort, display error
          await cancelDownload();
          emit(state.copyWith(isGenericError: true));
          return;
        }
        // If download is not cancelled, update progress to 100%
        if (!_isCancelled) updateProgress(1);
        // Clear the downloading state after completion
        emit(state.copyWith(downloadingBookSlug: null));
        // Call the onFinish callback if provided
        onFinish?.call();
        // Delay to ensure the UI updates before resetting the state
        await Future.delayed(const Duration(milliseconds: 200));
        emit(const DownloadState());
      },
      failure: (_) {},
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
    List<AudioBookPart> currentParts = List<AudioBookPart>.from(
      existingBook?.audiobook?.parts ?? [],
    );

    // Book is downloaded, but not all parts are saved correctly,
    // clear the old files and proceed with the new ones
    if (existingBook != null &&
        existingBook.isAudiobookCorrectlyDownloaded == false) {
      await _deleteOfflineFiles(
        files:
            existingBook.audiobook?.parts
                .map((part) => part.url)
                .where((url) => url.isNotEmpty)
                .toList() ??
            [],
      );
      await _appStorageService.removeOfflineBook(book.slug);
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
          await _appStorageService.removeOfflineBook(book.slug);
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

      // If it's the first part, we create a new book entry
      if (i == 0) {
        // Save the new book with the first part
        await saveNewBook(book: book, parts: [effectivePart]);
        // Get the newly created book to update the current parts
        existingBook = await _getLocalBook(book.slug);
        // Initialize current parts with the first part
        currentParts = existingBook?.audiobook?.parts ?? [effectivePart];
      }
      // If it's not the first part, we update the existing book
      else {
        // Add the new part to the current parts
        final newCurrentParts = List<AudioBookPart>.from(currentParts)
          ..add(effectivePart);
        currentParts = newCurrentParts;
        // Save the existing book with the updated parts
        await saveExistingBook(
          book: existingBook!,
          parts: currentParts,
          isLastPart: isLastPart,
        );
      }

      // Update the progress based on the current part index
      updateProgress((i + 1) / total * 0.95);
    }
  }

  // Saves an existing book with updated audiobook parts
  Future<void> saveExistingBook({
    required OfflineBookModel book,
    required List<AudioBookPart> parts,
    required bool isLastPart,
  }) async {
    final effectiveBook = book.copyWith(
      audiobook: AudiobookModel.create(parts: parts),
      isAudiobookCorrectlyDownloaded: isLastPart,
    );
    await _saveOfflineBook(effectiveBook);
  }

  // Saves a new book with its audiobook parts
  Future<void> saveNewBook({
    required BookModel book,
    required List<AudioBookPart> parts,
  }) async {
    final offlineBook = OfflineBookModel(
      book: book,
      audiobook: AudiobookModel.create(parts: parts),
    );
    await _saveOfflineBook(offlineBook);
  }

  // Retrieves a local book by its slug
  Future<OfflineBookModel?> _getLocalBook(String slug) =>
      _appStorageService.readOfflineBook(slug);

  // Saves an offline book to the app storage
  Future<void> _saveOfflineBook(OfflineBookModel book) =>
      _appStorageService.saveOfflineBook(book.book.slug, book);

  // Deletes offline files based on the provided list of file URLs
  Future<void> _deleteOfflineFiles({required List<String> files}) {
    return Future.wait(
      files.map((file) async {
        final fileToDelete = File(file);
        if (await fileToDelete.exists()) {
          await fileToDelete.delete();
        }
      }),
    );
  }

  // Cancels the ongoing download process
  Future<void> cancelDownload() async {
    _isCancelled = true;
    emit(state.copyWith(progress: 0, downloadingBookSlug: null));
  }
}
