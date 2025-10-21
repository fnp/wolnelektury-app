part of 'likes_cubit.dart';

@freezed
sealed class LikesState with _$LikesState {
  const factory LikesState({
    // List of slugs
    @Default([]) List<String> favourites,
    @Default(10) int itemsPerPage,
    @Default(false) bool isLoading,
    @Default(false) bool isFailure,
  }) = _FavouritesState;
}

extension FavouritesStateX on LikesState {
  int get effectiveLength => min(itemsPerPage, favourites.length);
  bool isLiked(String slug) {
    return favourites.contains(slug);
  }
}
