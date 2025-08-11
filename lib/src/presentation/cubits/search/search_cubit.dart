import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_search_service.dart';
import 'package:wolnelektury/src/data/search_repository.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/generic_search_result_model.dart';
import 'package:wolnelektury/src/domain/hint_model.dart';
import 'package:wolnelektury/src/domain/text_search_result_model.dart';
import 'package:wolnelektury/src/presentation/enums/hint_type_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

class SearchCubit extends SafeCubit<SearchState> {
  final SearchRepository _searchRepository;
  final AppStorageSearchService _appStorageSearchService;
  Timer? _debounce;
  SearchCubit(this._searchRepository, this._appStorageSearchService)
    : super(const SearchState()) {
    _loadLastSearchedHints();
  }

  Future<void> _loadLastSearchedHints() async {
    final hints = await _appStorageSearchService.readLastSearched();
    emit(state.copyWith(lastSearched: hints));
  }

  Future<void> saveLastSearchedHint(HintModel hint) async {
    final result = await _appStorageSearchService.insertLastSearched(hint);
    if (result) {
      final updatedHints = await _appStorageSearchService.readLastSearched();
      emit(state.copyWith(lastSearched: updatedHints));
    }
  }

  Future<void> deleteLastSearchedHint(String label) async {
    await _appStorageSearchService.deleteLastSearched(label);
    final updatedHints = await _appStorageSearchService.readLastSearched();
    emit(state.copyWith(lastSearched: updatedHints));
  }

  void changeQuery(String query) {
    clearSearch();
    final effQuery = query.trim().isEmpty ? null : query.trim();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (state.showResults) {
        return;
      }
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
        emit(
          state.copyWith(
            isLoadingHints: false,
            hints: data.where((e) => e.type != HintTypeEnum.unknown).toList(),
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(isLoadingHints: false, hints: []));
      },
    );
  }

  Future<void> loadSearchResults() async {
    if (state.query == null || state.query!.isEmpty) {
      emit(state.copyWith(books: [], texts: [], generic: null, hints: []));
      return;
    }
    emit(state.copyWith(isLoadingResults: true, hints: [], lastSearched: []));
    await Future.wait([
      _searchRepository.searchBooks(query: state.query!).then((result) {
        return result.handle(
          success: (data, p) {
            emit(
              state.copyWith(
                books: data,
                booksPagination: p ?? state.booksPagination,
              ),
            );
          },
          failure: (_) => [],
        );
      }),
      _searchRepository.searchText(query: state.query!).then((result) {
        return result.handle(
          success: (data, p) {
            emit(
              state.copyWith(
                texts: data,
                textsPagination: p ?? state.textsPagination,
              ),
            );
          },
          failure: (_) => [],
        );
      }),
      _searchRepository.searchGeneric(query: state.query!).then((result) {
        return result.handle(
          success: (data, p) {
            emit(state.copyWith(generic: data));
          },
          failure: (_) => [],
        );
      }),
    ]);
    emit(state.copyWith(isLoadingResults: false));
  }

  void toggleShowResults(bool value) {
    emit(state.copyWith(showResults: value));
    if (value) {
      loadSearchResults();
    }
  }

  void clearSearch() {
    _loadLastSearchedHints();
    toggleShowResults(false);
    emit(state.copyWith(books: [], texts: [], generic: null));
  }
}
