import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'single_book_cubit.freezed.dart';
part 'single_book_state.dart';

class SingleBookCubit extends SafeCubit<SingleBookState> {
  final BooksRepository _booksRepository;
  SingleBookCubit(this._booksRepository) : super(const SingleBookState());

  Future<void> loadBookData({
    required String slug,
    Function(BookModel data)? onFinished,
  }) async {
    emit(state.copyWith(isLoading: true));
    final book = await _booksRepository.getBookBySlug(slug: slug);
    book.handle(
      success: (book, _) {
        emit(state.copyWith(book: book, isLoading: false));
        onFinished?.call(book);
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
