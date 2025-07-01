import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage_service.dart';
import 'package:wolnelektury/src/domain/offline_book_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'offline_cubit.freezed.dart';
part 'offline_state.dart';

class OfflineCubit extends SafeCubit<OfflineState> {
  final AppStorageService _appStorageService;
  OfflineCubit(this._appStorageService) : super(const OfflineState());

  Future<void> loadOfflineBooks() async {
    emit(state.copyWith(isLoading: true));
    final response = await _appStorageService.readAllOfflineBooks();
    emit(
      state.copyWith(
        audiobooks: response.where((e) => e.audiobook != null).toList(),
        readers: response.where((e) => e.reader != null).toList(),
        isLoading: false,
      ),
    );
  }

  Future<void> removeOfflineReader(OfflineBookModel book) async {
    final initReaders = List<OfflineBookModel>.from(state.readers);
    final newReaders = initReaders
      ..removeWhere((e) => e.book.slug == book.book.slug);
    emit(state.copyWith(readers: newReaders));

    if (book.audiobook == null) {
      await _appStorageService.removeOfflineBook(book.book.slug);
    } else {
      await _appStorageService.saveOfflineBook(
        book.book.slug,
        book.copyWith(reader: null),
      );
    }
  }

  Future<void> removeOfflineAudiobook(OfflineBookModel book) async {
    final offlineBook = await _appStorageService.readOfflineBook(
      book.book.slug,
    );

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
      await _appStorageService.removeOfflineBook(book.book.slug);
    } else {
      await _appStorageService.saveOfflineBook(
        book.book.slug,
        book.copyWith(audiobook: null),
      );
    }
  }

  Future<void> _deleteOfflineFiles({required List<String> files}) {
    return Future.wait(
      files.map((file) async {
        final fileToDelete = File(file);
        await fileToDelete.delete();
      }),
    );
  }
}
