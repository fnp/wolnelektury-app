import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/tags_repository.dart';
import 'package:wolnelektury/src/domain/tag_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'filtering_cubit.freezed.dart';
part 'filtering_state.dart';

class FilteringCubit extends SafeCubit<FilteringState> {
  Timer? _debounce;
  final TagsRepository _tagsRepository;
  FilteringCubit(this._tagsRepository) : super(const FilteringState());

  void changeQuery(String query) {
    final effQuery = query.trim().isEmpty ? null : query.trim();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      emit(state.copyWith(query: effQuery));
      getTags();
    });
  }

  void toggleTag(TagModel tag) {
    final List<TagModel> selectedTags = List.from(state.selectedTags);
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    emit(state.copyWith(selectedTags: selectedTags));
    getTags();
  }

  Future<void> getTags() async {
    emit(state.copyWith(isLoading: true));
    final result = await _tagsRepository.getTags(
      tags: state.selectedTags,
      search: state.query,
    );
    result.handle(
      success: (tags, pagination) {
        emit(
          state.copyWith(
            tags: tags,
            pagination: pagination ?? state.pagination,
          ),
        );
      },
      failure: (failure) {
        failure.handle(
          notFound: () {
            emit(
              state.copyWith(
                pagination: state.pagination.copyWith(next: null),
                tags: [],
                isLoadingMore: false,
              ),
            );
          },
          orElse: () {
            emit(state.copyWith(isLoadingMore: false));
          },
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.pagination.next == null) return;

    emit(state.copyWith(isLoadingMore: true));
    final books = await _tagsRepository.getTags(
      url: state.pagination.next!.removeApiUrl,
      tags: state.selectedTags,
      search: state.query,
    );

    books.handle(
      success: (books, pagination) {
        emit(
          state.copyWith(
            tags: [...state.tags, ...books],
            pagination: pagination ?? state.pagination,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        failure.handle(
          notFound: () {
            emit(
              state.copyWith(
                pagination: state.pagination.copyWith(next: null),
                tags: [],
                isLoadingMore: false,
              ),
            );
          },
          orElse: () {
            emit(state.copyWith(isLoadingMore: false));
          },
        );
      },
    );
  }
}
