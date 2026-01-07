part of 'audio_cubit.dart';

@freezed
sealed class AudioState with _$AudioState {
  const factory AudioState({
    BookModel? book,
    AudiobookModel? audiobook,
    @Default(false) isLoadingAudiobook,

    // Player
    @Default(0) int statePosition,
    int? localPosition,
    @Default(0) int currentlyPlayingPart,
    @Default(false) bool isPlaying,
    @Default(false) bool isPreparingSession,
    @Default(false) bool isPreparingPlaylist,

    // Text sync pairs
    @Default([]) List<BookTextAudioSyncModel> textSyncPairs,

    // Settings
    @Default(false) bool isSettingsOpened,
    @Default(false) bool isBookmarksOpened,
    @Default(0) int sleepTimer,
    @Default(AudioPlayerSpeedEnum.x1) AudioPlayerSpeedEnum speed,
    @Default(0) int playToPart,

    // Error
    @Default(false) bool isError,

    // Progress
    ProgressModel? progress,
  }) = _AudioState;
}

extension AudioStateEx on AudioState {
  String? get getIdForTimestamp {
    final pair = textSyncPairs.lastWhereOrNull(
      (pair) => pair.timestamp <= statePosition,
    );
    return pair?.id;
  }

  int get wholeDuration => parts
      .fold(
        0,
        (previousValue, element) => previousValue + element.duration.floor(),
      )
      .floor();

  List<AudioBookPart> get parts => audiobook?.parts ?? [];
  int get maxSleepTimer => (wholeDuration / 60).ceil();
  int get currentMaxSleepTimer => maxSleepTimer - statePosition ~/ 60;
  int partPositionInWholeDuration(int partIndex) {
    final partsBefore = parts
        .sublist(0, partIndex)
        .fold(
          0,
          (previousValue, element) => previousValue + element.duration.floor(),
        );
    return partsBefore + (localPosition ?? 0);
  }
}
