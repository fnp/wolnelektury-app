part of 'search_cubit.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState({
    @Default(false) bool isLoadingHints,
    @Default([]) List<HintModel> hints,
    String? query,
  }) = _SearchState;
}
