part of 'books_cubit.dart';

@freezed
class BooksState with _$BooksState {
  const factory BooksState({
    @Default([]) List<BookModel> books,
    @Default([]) List<TagModel> filterTags,
    @Default(SortEnum.alphabeticallyAsc) SortEnum sort,
    @Default(ApiResponsePagination()) ApiResponsePagination pagination,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    bool? isSuccess,
  }) = _BooksState;
}

extension BooksStateX on BooksState {
  bool get isAnySortSelected => sort != SortEnum.alphabeticallyAsc;
}
