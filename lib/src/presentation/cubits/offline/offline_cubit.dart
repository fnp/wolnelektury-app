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
        books: response..where((e) => e.audiobook != null),
        isLoading: false,
      ),
    );
  }

  Future<void> removeOfflineBook(OfflineBookModel book) async {
    try {
      await _deleteOfflineFiles(
        files: book.audiobook?.parts.map((e) => e.url).toList() ?? [],
      );
    } catch (e) {
      //TODO handle error
    }
    final initBooks = List<OfflineBookModel>.from(state.books);
    final newBooks = initBooks
      ..removeWhere((e) => e.book.slug == book.book.slug);
    emit(state.copyWith(books: newBooks));
    final result = await _appStorageService.removeOfflineBook(book.book.slug);
    if (!result) {
      //TODO handle error
      emit(state.copyWith(books: initBooks));
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
