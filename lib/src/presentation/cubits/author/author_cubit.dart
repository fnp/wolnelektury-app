import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/author_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'author_cubit.freezed.dart';
part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  final AuthorRepository _authorRepository;
  AuthorCubit(this._authorRepository) : super(const AuthorState());

  Future<void> getAuthor(String slug) async {
    emit(state.copyWith(isLoading: true));

    final result = await _authorRepository.getAuthor(slug: slug);

    result.when(
      success: (author, _) {
        emit(state.copyWith(author: author));
        getBooks(authorId: author.id);
      },
      failed: (failure) => emit(state.copyWith(isLoading: false)),
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> getBooks({
    required int authorId,
  }) async {
    emit(state.copyWith(isLoadingAuthorsBooks: true));

    final result = await _authorRepository.getAuthorsBooks(
      authorId: authorId,
    );

    result.when(
      success: (books, pagination) {
        emit(
          state.copyWith(
            authorsBooks: books,
            authorsBooksPagination: pagination ?? state.authorsBooksPagination,
          ),
        );
      },
      failed: (failure) => emit(state.copyWith(isLoadingAuthorsBooks: false)),
    );

    emit(state.copyWith(isLoadingAuthorsBooks: false));
  }

  Future<void> loadMoreBooks() async {
    if (state.authorsBooksPagination.next == null) return;

    emit(state.copyWith(isLoadingAuthorsBooks: true));
    final books = await _authorRepository.getAuthorsBooks(
      authorId: state.author!.id,
      url: state.authorsBooksPagination.next!.removeApiUrl,
    );

    books.when(
      success: (books, pagination) {
        emit(
          state.copyWith(
            authorsBooks: [...state.authorsBooks, ...books],
            authorsBooksPagination: pagination ?? state.authorsBooksPagination,
            isLoadingAuthorsBooks: false,
          ),
        );
      },
      failed: (failure) {
        emit(
          state.copyWith(
            isLoadingAuthorsBooks: false,
          ),
        );
      },
    );
  }
}
