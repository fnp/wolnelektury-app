part of 'favourites_cubit.dart';

@freezed
sealed class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    // List of slugs
    @Default([]) List<String> favourites,
    @Default(5) int itemsPerPage,
  }) = _FavouritesState;
}

extension FavouritesStateX on FavouritesState {
  int get effectiveLength => min(itemsPerPage, favourites.length);
  bool isLiked(String slug) {
    return favourites.contains(slug);
  }
}
