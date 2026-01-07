part of 'search_cubit.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState({
    @Default(false) bool isLoadingHints,
    @Default([]) List<HintModel> hints,
    @Default([]) List<HintModel> lastSearched,
    String? query,

    /// Results
    @Default([]) List<BookModel> books,
    @Default(ApiResponsePagination()) ApiResponsePagination booksPagination,
    @Default([]) List<TextSearchResultModel> texts,
    @Default(ApiResponsePagination()) ApiResponsePagination textsPagination,
    GenericSearchResultModel? generic,
    @Default(false) bool isLoadingResults,
    @Default(false) bool showResults,
  }) = _SearchState;
}
