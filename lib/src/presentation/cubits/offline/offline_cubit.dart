import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_offline_service.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'offline_cubit.freezed.dart';
part 'offline_state.dart';

class OfflineCubit extends SafeCubit<OfflineState> {
  final AppStorageOfflineService _offlineStorage;
  OfflineCubit(this._offlineStorage) : super(const OfflineState());

  Future<void> loadOfflineBooks() async {
    emit(state.copyWith(isLoading: true));
    final response = await _offlineStorage.readAllOfflineBooks();
    emit(
      state.copyWith(
        audiobooks: response.where((e) => e.audiobook != null).toList(),
        readers: response.where((e) => e.reader != null).toList(),
        isLoading: false,
      ),
    );
  }

  Future<void> removeOfflineReader({required OfflineBookModel book}) async {
    if (state.readerToDelete != null) {
      _removeOfflineReader(state.readerToDelete!);
    }
    emit(state.copyWith(readerToDelete: book));

    await Future.delayed(const Duration(seconds: 5));
    if (state.readerToDelete?.book.slug == book.book.slug) {
      _removeOfflineReader(book, shouldHandle: true);
    }
  }

  Future<void> removeOfflineAudiobook({required OfflineBookModel book}) async {
    if (state.audiobookToDelete != null) {
      _removeOfflineAudiobook(state.audiobookToDelete!);
    }
    emit(state.copyWith(audiobookToDelete: book));

    await Future.delayed(const Duration(seconds: 5));
    if (state.audiobookToDelete?.book.slug == book.book.slug) {
      _removeOfflineAudiobook(book, shouldHandle: true);
    }
  }

  Future<void> removeAudiobookInstantly(OfflineBookModel book) async {
    await _removeOfflineAudiobook(book);
  }

  Future<void> _removeOfflineReader(
    OfflineBookModel book, {
    bool shouldHandle = false,
  }) async {
    final initReaders = List<OfflineBookModel>.from(state.readers);
    final newReaders = initReaders
      ..removeWhere((e) => e.book.slug == book.book.slug);
    emit(state.copyWith(readers: newReaders));

    if (book.audiobook == null) {
      await _offlineStorage.removeOfflineBook(book.book.slug);
    } else {
      await _offlineStorage.saveOfflineBook(
        book.book.slug,
        book.copyWith(reader: null),
      );
    }
    if (!shouldHandle) return;
    emit(state.copyWith(readerToDelete: null));
  }

  void undoRemovingOfflineReader() {
    emit(state.copyWith(readerToDelete: null));
  }

  void undoRemovingOfflineAudiobook() {
    emit(state.copyWith(audiobookToDelete: null));
  }

  Future<void> _removeOfflineAudiobook(
    OfflineBookModel book, {
    bool shouldHandle = false,
  }) async {
    final offlineBook = await _offlineStorage.readOfflineBook(book.book.slug);

    final offlineParts = offlineBook?.audiobook?.parts
        .map((e) => e.url)
        .toList();

    await _deleteOfflineFiles(
      files:
          offlineParts ??
          book.audiobook?.parts.map((e) => e.url).toList() ??
          [],
    );

    final initAudiobooks = List<OfflineBookModel>.from(state.audiobooks);
    final newAudiobooks = initAudiobooks
      ..removeWhere((e) => e.book.slug == book.book.slug);
    emit(state.copyWith(audiobooks: newAudiobooks));

    if (book.reader == null) {
      await _offlineStorage.removeOfflineBook(book.book.slug);
    } else {
      await _offlineStorage.saveOfflineBook(
        book.book.slug,
        book.copyWith(audiobook: null),
      );
    }
    if (!shouldHandle) return;
    emit(state.copyWith(audiobookToDelete: null));
  }

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
}
