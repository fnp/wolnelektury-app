part of 'filtering_cubit.dart';

@freezed
sealed class FilteringState with _$FilteringState {
  const factory FilteringState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<TagModel> tags,
    @Default([]) List<TagModel> selectedTags,
    String? query,
    @Default(ApiResponsePagination()) ApiResponsePagination pagination,
  }) = _FilteringState;
}

extension FilteringStateX on FilteringState {
  bool isTagSelected(TagModel tag) {
    return selectedTags.contains(tag);
  }

  bool get isAnyTagSelected {
    return selectedTags.isNotEmpty;
  }
}
