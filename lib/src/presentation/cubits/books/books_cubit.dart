import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/presentation/enums/sort_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'books_cubit.freezed.dart';
part 'books_state.dart';

class BooksCubit extends SafeCubit<BooksState> {
  final BooksRepository _booksRepository;
  BooksCubit(this._booksRepository) : super(const BooksState());

  void changeSort(SortEnum sort) {
    if (state.sort == sort) return;
    emit(state.copyWith(sort: sort));
    getBooks();
  }

  void _changeTags(List<TagModel> tags) {
    emit(state.copyWith(filterTags: tags));
  }

  Future<void> getBooks({
    List<TagModel>? tags,
  }) async {
    emit(state.copyWith(isLoading: true, isSuccess: null));
    if (tags != null) _changeTags(tags);

    final books = await _booksRepository.getBooks(
      sort: state.sort,
      tags: state.filterTags,
    );
    books.when(
      success: (books, pagination) {
        emit(
          state.copyWith(
            books: books,
            pagination: pagination ?? state.pagination,
            isLoading: false,
            isSuccess: true,
          ),
        );
      },
      failed: (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.pagination.next == null || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    final books = await _booksRepository.getBooks(
      sort: state.sort,
      tags: state.filterTags,
      url: state.pagination.next!.removeApiUrl,
    );

    books.when(
      success: (books, pagination) {
        emit(
          state.copyWith(
            books: [...state.books, ...books],
            pagination: pagination ?? state.pagination,
            isLoadingMore: false,
          ),
        );
      },
      failed: (failure) {
        emit(
          state.copyWith(
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
