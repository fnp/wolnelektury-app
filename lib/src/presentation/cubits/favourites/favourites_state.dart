part of 'favourites_cubit.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    // List of slugs
    @Default({}) Map<String, List> favourites,
  }) = _FavouritesState;
}
