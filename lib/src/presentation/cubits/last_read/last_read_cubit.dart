import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';

part 'last_read_cubit.freezed.dart';
part 'last_read_state.dart';

class LastReadCubit extends Cubit<LastReadState> {
  final BooksRepository _booksRepository;
  LastReadCubit(this._booksRepository) : super(const LastReadState());

  Future<void> loadBookData({
    required String slug,
  }) async {
    emit(state.copyWith(isLoading: true));
    final book = await _booksRepository.getBookBySlug(slug: slug);
    book.when(
      success: (book, _) {
        emit(
          state.copyWith(
            book: book,
            isLoading: false,
          ),
        );
      },
      failed: (failure) {
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
      },
    );
  }
}
