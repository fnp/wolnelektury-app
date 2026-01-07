part of 'download_cubit.dart';

@freezed
sealed class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(0) double progress,
    String? downloadingBookAudiobookSlug,
    String? downloadingBookReaderSlug,
    @Default(false) bool isAlreadyDownloadingAudiobookError,
    @Default(false) bool isAlreadyDownloadingReaderError,
    @Default(false) bool isGenericAudiobookError,
    @Default(false) bool isGenericReaderError,
  }) = _DownloadState;
}

extension DownloadStateX on DownloadState {
  bool get isDownloadingAudiobook => progress > 0 && progress < 1;
  bool get isDownloadingReader => downloadingBookReaderSlug != null;
}
