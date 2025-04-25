import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'favourites_cubit.freezed.dart';
part 'favourites_state.dart';

class FavouritesCubit extends SafeCubit<FavouritesState> {
  final BooksRepository _booksRepository;
  FavouritesCubit(this._booksRepository) : super(const FavouritesState()) {
    _init();
  }

  Future<void> _init() async {
    final response = await _booksRepository.getFavourites();
    response.when(
      success: (favourites, _) {
        emit(state.copyWith(favourites: favourites));
      },
      failed: (failure) {
        emit(state.copyWith(favourites: const {}));
      },
    );
  }

  Future<void> addToFavourites(String slug) async {
    final previousFavourites = state.favourites;
    final newFavourites = Map<String, List<String>>.from(state.favourites);
    newFavourites.addAll({slug: []});
    emit(state.copyWith(favourites: newFavourites));
    final response = await _booksRepository.toggleFavourite(
      slug: slug,
      targetValue: true,
    );

    print('Add to favourites: $response');

    response.when(
      success: (_, __) {},
      failed: (failure) {
        emit(state.copyWith(favourites: previousFavourites));
      },
    );
  }

  Future<void> removeFromFavourites(String slug) async {
    final previousFavourites = state.favourites;
    final newFavourites = Map<String, List<String>>.from(state.favourites);
    newFavourites.remove(slug);
    emit(state.copyWith(favourites: newFavourites));
    final response = await _booksRepository.toggleFavourite(
      slug: slug,
      targetValue: false,
    );

    print('Remove from favourites: $response');
    response.when(
      success: (_, __) {},
      failed: (failure) {
        emit(state.copyWith(favourites: previousFavourites));
      },
    );
  }
}
