part of 'offline_cubit.dart';

@freezed
sealed class OfflineState with _$OfflineState {
  const factory OfflineState({
    @Default(false) bool isLoading,
    @Default([]) List<OfflineBookModel> audiobooks,
    @Default([]) List<OfflineBookModel> readers,

    // Deletion
    OfflineBookModel? audiobookToDelete,
    OfflineBookModel? readerToDelete,
  }) = _OfflineState;
}

extension OfflineStateX on OfflineState {
  List<OfflineBookModel> get effectiveAudiobooks {
    if (audiobookToDelete == null) {
      return audiobooks;
    }
    return audiobooks
        .where((e) => e.book.slug != audiobookToDelete!.book.slug)
        .toList();
  }
}
