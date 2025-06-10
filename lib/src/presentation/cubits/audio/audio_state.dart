part of 'audio_cubit.dart';

@freezed
sealed class AudioState with _$AudioState {
  const factory AudioState({
    BookModel? book,
    AudiobookModel? audiobook,
    @Default(false) isDialogShown,
    @Default(false) isLoadingAudiobook,

    // Player
    @Default(0) int statePosition,
    int? localPosition,
    @Default(0) int currentlyPlayingPart,
    @Default(false) bool isPlaying,
    @Default(false) bool isPreparingSession,
    @Default(false) bool isPreparingPlaylist,

    // Settings
    @Default(false) bool isSettingsOpened,
    @Default(false) bool isBookmarksOpened,
    @Default(0) int sleepTimer,
    @Default(AudioPlayerSpeedEnum.x1) AudioPlayerSpeedEnum speed,
    @Default(0) int playToPart,
  }) = _AudioState;
}

extension AudioStateEx on AudioState {
  int get wholeDuration => parts
      .fold(
        0,
        (previousValue, element) => previousValue + element.duration.floor(),
      )
      .floor();

  List<AudioBookPart> get parts => audiobook?.parts ?? [];
  bool get isPlayingMinimized => isPlaying && !isDialogShown;
  int get maxSleepTimer => (wholeDuration / 60).ceil();
  int get currentMaxSleepTimer => maxSleepTimer - statePosition ~/ 60;
}
