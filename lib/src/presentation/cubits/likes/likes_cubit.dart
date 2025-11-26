import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/likes_repository.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'likes_cubit.freezed.dart';
part 'likes_state.dart';

class LikesCubit extends SafeCubit<LikesState> {
  final LikesRepository _favouritesRepository;
  LikesCubit(this._favouritesRepository) : super(const LikesState()) {
    init();
  }

  Future<void> resetState() async {
    emit(const LikesState());
  }

  Future<void> init() async {
    emit(state.copyWith(itemsPerPage: 10, isLoading: true));
    final response = await _favouritesRepository.getFavourites();
    response.handle(
      success: (favourites, _) {
        emit(state.copyWith(favourites: favourites, isLoading: false));
      },
      failure: (failure) {
        emit(state.copyWith(favourites: [], isLoading: false));
      },
    );
  }

  void increaseItemsPerPage() {
    emit(state.copyWith(itemsPerPage: state.itemsPerPage + 10));
  }

  Future<void> addToFavourites(String slug) async {
    final previousFavourites = state.favourites;
    final newFavourites = List<String>.from(state.favourites);
    newFavourites.add(slug);
    emit(state.copyWith(favourites: newFavourites, isFailure: false));
    final response = await _favouritesRepository.toggleFavourite(
      slug: slug,
      targetValue: true,
    );
    response.handle(
      success: (_, __) {},
      failure: (failure) {
        emit(state.copyWith(favourites: previousFavourites, isFailure: true));
      },
    );
  }

  Future<void> removeFromFavourites(String slug) async {
    final previousFavourites = state.favourites;
    final newFavourites = List<String>.from(state.favourites);
    newFavourites.remove(slug);
    emit(state.copyWith(favourites: newFavourites));
    final response = await _favouritesRepository.toggleFavourite(
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
