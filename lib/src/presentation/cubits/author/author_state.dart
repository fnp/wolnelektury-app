part of 'author_cubit.dart';

@freezed
class AuthorState with _$AuthorState {
  const factory AuthorState({
    @Default(false) bool isLoading,
    DetailedAuthorModel? author,

    // Lists of books by the author
    @Default(false) bool isLoadingAuthorsBooks,
    @Default([]) List<BookModel> authorsBooks,
    @Default(ApiResponsePagination())
    ApiResponsePagination authorsBooksPagination,
    // Lists of books translated by the author
    @Default(false) bool isLoadingAuthorsTranslations,
    @Default([]) List<BookModel> authorsTranslations,
    @Default(ApiResponsePagination())
    ApiResponsePagination authorsTranslationsPagination,
  }) = _AuthorState;
}
