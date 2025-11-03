import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/author_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/detailed_author_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'author_cubit.freezed.dart';
part 'author_state.dart';

class AuthorCubit extends SafeCubit<AuthorState> {
  final AuthorRepository _authorRepository;
  AuthorCubit(this._authorRepository) : super(const AuthorState());

  Future<void> getAuthor(String slug) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _authorRepository.getAuthor(slug: slug);

    result.handle(
      success: (author, _) {
        emit(state.copyWith(author: author));
        getBooks(authorId: author.id);
      },
      failure: (failure) => emit(state.copyWith(isLoading: false)),
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> getBooks({required int authorId}) async {
    emit(state.copyWith(isLoadingAuthorsBooks: true));

    final result = await _authorRepository.getAuthorsBooks(authorId: authorId);

    result.handle(
      success: (books, pagination) {
        emit(
          state.copyWith(
            authorsBooks: books,
            authorsBooksPagination: pagination ?? state.authorsBooksPagination,
            isLoadingAuthorsBooks: false,
          ),
        );
      },
      failure: (failure) => emit(state.copyWith(isLoadingAuthorsBooks: false)),
    );
  }

  Future<void> loadMoreBooks() async {
    if (state.authorsBooksPagination.next == null) return;

    emit(state.copyWith(isLoadingAuthorsBooks: true));
    final books = await _authorRepository.getAuthorsBooks(
      authorId: state.author!.id,
      url: state.authorsBooksPagination.next!.removeApiUrl,
    );

    books.handle(
      success: (books, pagination) {
        emit(
          state.copyWith(
            authorsBooks: [...state.authorsBooks, ...books],
            authorsBooksPagination: pagination ?? state.authorsBooksPagination,
            isLoadingAuthorsBooks: false,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingAuthorsBooks: false));
      },
    );
  }

  Future<void> getTranslations({required int authorId}) async {
    emit(state.copyWith(isLoadingAuthorsTranslations: true));

    final result = await _authorRepository.getAuthorTranslations(
      authorId: authorId,
    );

    result.handle(
      success: (books, pagination) {
        emit(
          state.copyWith(
            authorsTranslations: books,
            authorsTranslationsPagination:
                pagination ?? state.authorsTranslationsPagination,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingAuthorsTranslations: false));
      },
    );

    emit(state.copyWith(isLoadingAuthorsTranslations: false));
  }

  Future<void> loadMoreTranslations() async {
    if (state.authorsTranslationsPagination.next == null) return;

    emit(state.copyWith(isLoadingAuthorsTranslations: true));
    final books = await _authorRepository.getAuthorTranslations(
      authorId: state.author!.id,
      url: state.authorsTranslationsPagination.next!.removeApiUrl,
    );

    books.handle(
      success: (books, pagination) {
        emit(
          state.copyWith(
            authorsTranslations: [...state.authorsTranslations, ...books],
            authorsTranslationsPagination:
                pagination ?? state.authorsTranslationsPagination,
            isLoadingAuthorsTranslations: false,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingAuthorsTranslations: false));
      },
    );
  }
}
