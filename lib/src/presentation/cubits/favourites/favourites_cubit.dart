import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'favourites_cubit.freezed.dart';
part 'favourites_state.dart';

class FavouritesCubit extends SafeCubit<FavouritesState> {
  final BooksRepository _booksRepository;
  FavouritesCubit(this._booksRepository) : super(const FavouritesState()) {
    init();
  }

  Future<void> init() async {
    final response = await _booksRepository.getFavourites();
    response.handle(
      success: (favourites, _) {
        emit(state.copyWith(favourites: favourites));
      },
      failure: (failure) {
        emit(state.copyWith(favourites: []));
      },
    );
  }

  void increaseItemsPerPage() {
    emit(state.copyWith(itemsPerPage: state.itemsPerPage + 5));
  }

  Future<void> addToFavourites(String slug) async {
    final previousFavourites = state.favourites;
    final newFavourites = List<String>.from(state.favourites);
    newFavourites.add(slug);
    emit(state.copyWith(favourites: newFavourites));
    final response = await _booksRepository.toggleFavourite(
      slug: slug,
      targetValue: true,
    );

    response.handle(
      success: (_, __) {},
      failure: (failure) {
        emit(state.copyWith(favourites: previousFavourites));
      },
    );
  }

  Future<void> removeFromFavourites(String slug) async {
    final previousFavourites = state.favourites;
    final newFavourites = List<String>.from(state.favourites);
    newFavourites.remove(slug);
    emit(state.copyWith(favourites: newFavourites));
    final response = await _booksRepository.toggleFavourite(
      slug: slug,
      targetValue: false,
    );

    response.handle(
      success: (_, __) {},
      failure: (failure) {
        emit(state.copyWith(favourites: previousFavourites));
      },
    );
  }
}
