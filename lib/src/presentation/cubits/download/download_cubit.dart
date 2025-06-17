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
  DownloadCubit(this._audiobookRepository, this._appStorageService)
    : super(const DownloadState());

  void updateProgress(double progress) async {
    emit(state.copyWith(progress: progress));
  }

  Future<void> downloadAudiobook({required BookModel book}) async {
    if (state.isDownloading) {
      // If we are already downloading, we do not start a new download
      return;
    }
    emit(state.copyWith(progress: 0.01));
    // Fetch book's audiobook
    final parts = await _audiobookRepository.getAudiobook(slug: book.slug);
    parts.handle(
      success: (data, _) async {
        // Save audiobook's parts in phone memory / app directory
        final localPaths = await _saveAudiobookParts(data);
        // Override URLs with paths to local files with offlineFlag set to true
        final effectiveParts = data.map((part) {
          return part.copyWith(
            url: localPaths[data.indexOf(part)],
            isOffline: true,
          );
        }).toList();
        // Read the book from local storage
        final existingBook = await _getLocalBook(book.slug);
        if (existingBook == null) {
          // Book is not saved yet, so we save it as a new book
          await saveNewBook(book: book, parts: effectiveParts);
        } else {
          // Book is already saved, so we update it with the new audiobook parts
          await saveExistingBook(book: existingBook, parts: effectiveParts);
        }
        emit(state.copyWith(progress: 1));
      },
      failure: (_) {},
    );
  }

  // This returts a list of local paths where the audiobook parts were saved
  Future<List<String>> _saveAudiobookParts(List<AudioBookPart> parts) async {
    List<String> localPaths = [];
    for (final part in parts) {
      final result = await FileSaver.instance.saveFile(
        name: part.name,
        ext: part.type,
        link: LinkDetails(link: part.url),
      );
      localPaths.add(result);
      emit(state.copyWith(progress: (localPaths.length / parts.length) * 0.9));
    }

    return localPaths;
  }

  Future<void> saveExistingBook({
    required OfflineBookModel book,
    required List<AudioBookPart> parts,
  }) async {
    final effectiveBook = book.copyWith(
      audiobook: AudiobookModel.create(parts: parts),
    );
    await _saveOfflineBook(effectiveBook);
  }

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

  Future<OfflineBookModel?> _getLocalBook(String slug) async =>
      _appStorageService.readOfflineBook(slug);

  Future<void> _saveOfflineBook(OfflineBookModel book) async =>
      _appStorageService.saveOfflineBook(book.book.slug, book);
}
