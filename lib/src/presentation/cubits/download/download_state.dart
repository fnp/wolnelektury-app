part of 'download_cubit.dart';

@freezed
sealed class DownloadState with _$DownloadState {
  const factory DownloadState({@Default(0) double progress}) = _DownloadState;
}

extension DownloadStateX on DownloadState {
  bool get isDownloading => progress > 0 && progress < 1;
  bool get isReadyToDownload => progress == 1 || progress == 0;
}
