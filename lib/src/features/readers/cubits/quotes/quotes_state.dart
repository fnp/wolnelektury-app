part of 'quotes_cubit.dart';

@freezed
sealed class QuotesState with _$QuotesState {
  const factory QuotesState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool canLoadMore,
    (Success, bool)? isQuoteSuccess,
    QuoteModel? quoteToDelete,
    @Default([]) List<QuoteModel> quotes,
  }) = _QuotesState;
}

extension QuotesStateX on QuotesState {
  bool quoteExists(String? uuid) {
    return quotes.any((element) => element.uuid == uuid);
  }
}
