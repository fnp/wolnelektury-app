part of 'favourites_cubit.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    // List of slugs
    @Default({}) Map<String, List<String>> favourites,
  }) = _FavouritesState;
}
