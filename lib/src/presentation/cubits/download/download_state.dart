part of 'download_cubit.dart';

@freezed
sealed class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(0) double progress,
    String? downloadingBookSlug,
    @Default(false) bool isAlreadyDownloadingError,
    @Default(false) bool isGenericError,
  }) = _DownloadState;
}

extension DownloadStateX on DownloadState {
  bool get isDownloading => progress > 0 && progress < 1;
}
