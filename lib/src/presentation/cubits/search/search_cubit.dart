import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/search_repository.dart';
import 'package:wolnelektury/src/domain/hint_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

class SearchCubit extends SafeCubit<SearchState> {
  final SearchRepository _searchRepository;
  Timer? _debounce;
  SearchCubit(this._searchRepository) : super(const SearchState());

  void changeQuery(String query) {
    final effQuery = query.trim().isEmpty ? null : query.trim();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      emit(state.copyWith(query: effQuery));
      getHints();
    });
  }

  Future<void> getHints() async {
    emit(state.copyWith(isLoadingHints: true));
    if (state.query == null || state.query!.isEmpty) {
      emit(state.copyWith(isLoadingHints: false, hints: []));
      return;
    }
    final result = await _searchRepository.getSearchHints(state.query ?? '');
    result.handle(
      success: (data, _) {
        emit(state.copyWith(isLoadingHints: false, hints: data));
      },
      failure: (_) {
        emit(state.copyWith(isLoadingHints: false, hints: []));
      },
    );
  }
}
