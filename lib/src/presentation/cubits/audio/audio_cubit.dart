import 'dart:async';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/data/audiobook_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/presentation/enums/audio_player_speed_enum.dart';
import 'package:wolnelektury/src/utils/audio/custom_audio_session.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'audio_cubit.freezed.dart';
part 'audio_state.dart';

class AudioCubit extends SafeCubit<AudioState> {
  final AudiobookRepository _audiobookRepository;
  final ProgressRepository _progressRepository;
  AudioCubit(this._audiobookRepository, this._progressRepository)
    : super(const AudioState());
  Timer? _sleepTimer;
  Timer? _positionTimeoutTimer;

  // This restores player progress if needed
  int _failureCount = 0;
  int _currentlySavingProgress = 0;

  // Audioplayer instance
  final AudioPlayer _player = AudioPlayer(androidApplyAudioAttributes: false);

  // Audio session instance
  final CustomAudioSession _audioSession = CustomAudioSession();

  // Current audio stream position controller
  StreamSubscription<Duration>? _positionController;
  StreamSubscription<ProcessingState>? _playerStateController;

  // This is used to toggle opening settings
  void toggleSettings(bool value) {
    emit(state.copyWith(isSettingsOpened: value));
  }

  // This is used to toggle opening bookmarks
  void toggleBookmarks(bool value) {
    emit(state.copyWith(isBookmarksOpened: value));
  }

  // This is setting the sleep timer in the settings
  void changeSleepTimer(int timer, {bool cancelTimer = false}) {
    emit(state.copyWith(sleepTimer: timer, playToPart: 0));
    _sleepTimer?.cancel();
    if (!cancelTimer && timer > 0) {
      _sleepTimer = Timer(Duration(minutes: timer), () async {
        await stop();
        emit(state.copyWith(sleepTimer: 0));
      });
    }
  }

  // This setting changes the speed of the audioplayer
  void changeSpeed(AudioPlayerSpeedEnum speed) {
    emit(state.copyWith(speed: speed));
    _player.setSpeed(speed.value);
  }

  // Select book for AudioPlayer
  Future<void> pickBook(
    BookModel book, {
    bool tryOffline = false,
    int? overrideProgressTimestamp,
  }) async {
    final isSameAudiobookInitialized = state.book?.slug == book.slug;
    final wasInitializedOnline = state.parts.any((e) => !e.isOffline);
    final wasInitializedOffline = state.parts.any((e) => e.isOffline);

    if (isSameAudiobookInitialized) {
      // Book already selected, check if we need to set progress
      await _getAndSetProgress(
        overrideProgressTimestamp: overrideProgressTimestamp,
      );

      final modeChanged =
          (wasInitializedOffline && !tryOffline) ||
          (wasInitializedOnline && tryOffline);

      if (!modeChanged) return;
    }

    // New book selected, reset all values
    await stop();

    emit(state.copyWith(book: book, isLoadingAudiobook: true));

    final audiobookResponse = await _audiobookRepository.getAudiobook(
      slug: book.slug,
      tryOffline: tryOffline,
    );

    audiobookResponse.handle(
      success: (data, pagination) {
        emit(
          state.copyWith(
            audiobook: AudiobookModel.create(parts: data),
            isLoadingAudiobook: false,
          ),
        );

        // Prepare playlist if player is not already playing
        if (!_player.playing) {
          _preparePlaylist(overridenPosition: overrideProgressTimestamp);
        }
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingAudiobook: false));
        //TODO handle failure
      },
    );
  }

  Future<void> changePart(int part) async {
    // Change part of the audiobook
    if (part < 0 || part >= state.parts.length) return;
    await _player.seek(Duration.zero, index: part);
  }

  void resetPlayToPart() {
    changeSleepTimer(state.currentMaxSleepTimer, cancelTimer: true);
    emit(state.copyWith(playToPart: 0));
  }

  // This is ussed to set the playToPart value, which is used to
  // set the sleep timer to the end of the part
  void decreasePlayToPart() {
    final currentlyPlayingPart = _player.currentIndex ?? 0;
    final currentlySetToPart = state.playToPart - 1;

    if (currentlySetToPart < 0 || currentlySetToPart < currentlyPlayingPart) {
      resetPlayToPart();
      return;
    }

    final partsBetween = state.parts.getRange(
      currentlyPlayingPart,
      currentlySetToPart,
    );
    final durationOfPartsBetween = partsBetween.fold<int>(
      0,
      (prev, e) => prev + e.duration.floor(),
    );
    final inMinutes = durationOfPartsBetween ~/ 60;

    changeSleepTimer(inMinutes);
    emit(state.copyWith(playToPart: currentlySetToPart));
  }

  // This is ussed to set the playToPart value, which is used to
  // set the sleep timer to the end of the part
  void increasePlayToPart() {
    final currentlyPlayingPart = _player.currentIndex ?? 0;
    if (state.playToPart > state.parts.length - 1) return;

    if (state.playToPart <= currentlyPlayingPart) {
      final durationLeftOfThisPart =
          state.parts[currentlyPlayingPart].duration.floor() -
          _player.position.inSeconds;
      final inMinutes = durationLeftOfThisPart ~/ 60;
      changeSleepTimer(inMinutes);
      emit(state.copyWith(playToPart: currentlyPlayingPart + 1));
      return;
    }

    final currentlySetToPart = state.playToPart + 1;
    if (currentlySetToPart <= currentlyPlayingPart) {
      changeSleepTimer(0);
      emit(state.copyWith(playToPart: currentlySetToPart));
      return;
    }

    final partsBetween = state.parts.getRange(
      currentlyPlayingPart,
      currentlySetToPart,
    );
    final durationOfPartsBetween = partsBetween.fold<int>(
      0,
      (prev, e) => prev + e.duration.floor(),
    );
    final inMinutes = durationOfPartsBetween ~/ 60;

    changeSleepTimer(inMinutes);
    emit(state.copyWith(playToPart: currentlySetToPart));
  }

  Future<void> play({int? overridenPosition}) async {
    // Require audio session to play
    emit(state.copyWith(isPreparingSession: true, isError: false));
    final canPlay = await _audioSession.setActive(true);
    emit(state.copyWith(isPreparingSession: false));
    // Couldn't get audio session, return
    if (!canPlay) return;
    // Check if it needs a playlist
    await _preparePlaylist(overridenPosition: overridenPosition);

    // Audio session granted, playlist ready, play audio
    emit(state.copyWith(isPlaying: true));
    if (state.statePosition == state.wholeDuration) {
      emit(state.copyWith(statePosition: 0));
      _player.seek(const Duration(seconds: 0), index: 0);
    }
    await _player.play();
  }

  Future<void> pause() async {
    emit(state.copyWith(isPlaying: false));
    await Future.wait([_player.pause(), _audioSession.setActive(false)]);
  }

  // Completely stops the player and resets the playlist
  Future<void> stop() async {
    _cancelSubscriptions();
    emit(AudioState(book: state.book, audiobook: state.audiobook));
    Future.wait([
      _player.stop(),
      _player.seek(Duration.zero, index: 0),
      _player.setAudioSources([]),
      _audioSession.setActive(false),
    ]);
  }

  // This forwards the audiobook by 15 seconds
  Future<void> forward15s() async {
    final currentIndex = _player.currentIndex ?? 0;
    final positionInCurrentPart = _player.position.inSeconds;
    final lengthOfPart = state.parts[currentIndex].duration.floor();

    int newPosition = positionInCurrentPart + 15;
    int newIndex = currentIndex;

    if (state.statePosition + 15 > state.wholeDuration) return;

    if (newPosition >= lengthOfPart) {
      if (currentIndex + 1 < state.parts.length) {
        newIndex = currentIndex + 1;
        newPosition = newPosition - lengthOfPart;
      } else {
        return;
      }
    }

    emit(state.copyWith(statePosition: state.statePosition + 15));
    await _player.seek(Duration(seconds: newPosition), index: newIndex);
  }

  // This rewinds the audiobook by 15 seconds
  Future<void> backward15s() async {
    final currentIndex = _player.currentIndex ?? 0;
    final positionInCurrentPart = _player.position.inSeconds;

    emit(state.copyWith(statePosition: max(0, state.statePosition - 15)));

    if (positionInCurrentPart >= 15) {
      await _player.seek(
        Duration(seconds: positionInCurrentPart - 15),
        index: currentIndex,
      );
    } else if (currentIndex > 0) {
      final previousPartDuration = state.parts[currentIndex - 1].duration
          .floor();
      await _player.seek(
        Duration(seconds: previousPartDuration - (15 - positionInCurrentPart)),
        index: currentIndex - 1,
      );
    } else {
      await _player.seek(const Duration(seconds: 0), index: 0);
    }
  }

  // Local position is used to show the position of the audiobook in UI, that is
  // not synchronized with the player. This function is used to synchronize that.
  Future<void> seekToLocallySelectedPosition({int? optionalSeconds}) async {
    if (optionalSeconds == null && state.localPosition == null) {
      return;
    }
    // Seeked seconds
    final seconds = optionalSeconds ?? state.localPosition!;
    final foundPosition = _findPositionAndIndex(seconds);

    emit(state.copyWith(localPosition: null, statePosition: seconds));

    // If we are at the end of the audiobook, pause it
    if (seconds == state.wholeDuration) {
      emit(state.copyWith(isPlaying: false));
      _player.pause();
    }

    // Seek to the found position
    await _player.seek(
      Duration(seconds: foundPosition.$1),
      index: foundPosition.$2,
    );
  }

  void updateLocalPosition(int seconds) {
    emit(state.copyWith(localPosition: seconds));
  }

  void dialogShown(bool value) {
    emit(state.copyWith(isDialogShown: value));
  }

  void selectPart(int? part) {
    if (part == null || part < 0 || part >= state.parts.length) return;
    _player.seek(Duration.zero, index: part);
  }

  Future<void> _preparePlaylist({int? overridenPosition}) async {
    if (state.audiobook == null) {
      return;
    }
    if ((_player.audioSource?.sequence ?? []).isNotEmpty) {
      return;
    }
    emit(
      state.copyWith(
        isPreparingPlaylist: true,
        sleepTimer: state.maxSleepTimer,
      ),
    );

    final playlist = state.audiobook!.parts.map((part) {
      if (part.isOffline) {
        return AudioSource.file(
          part.url,
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: part.name,
            // Metadata to display in the notification:
            album: state.book?.title,
            title: part.name,
            artUri: Uri.parse(state.book?.coverUrl ?? ''),
            duration: Duration(seconds: part.duration.floor()),
          ),
        );
      }
      return AudioSource.uri(
        Uri.parse(part.url),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: part.name,
          // Metadata to display in the notification:
          album: state.book?.title,
          title: part.name,
          artUri: Uri.parse(state.book?.coverUrl ?? ''),
          duration: Duration(seconds: part.duration.floor()),
        ),
      );
    }).toList();

    // This gets the progress of the audiobook from the repository
    // and sets the position in UI as well as in the player
    (int, int) foundPosition = await _getAndSetProgress(
      overrideProgressTimestamp: overridenPosition,
    );
    AppLogger.instance.d(
      'AudioCubit',
      'Prepared playling for book ${state.book?.title}',
    );

    try {
      await _audioSession.initializationFuture;
      await _player.setAudioSources(
        playlist,
        initialIndex: foundPosition.$2,
        initialPosition: Duration(seconds: foundPosition.$1),
      );
      await _player.setLoopMode(LoopMode.off);
      await _player.setSpeed(AudioPlayerSpeedEnum.x1.value);
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
    _attachPositionListener();
    emit(state.copyWith(isPreparingPlaylist: false));
  }

  void _attachPositionListener() {
    _positionController?.cancel();
    _positionController = _player.positionStream.listen((event) {
      _resetPositionTimeout();
      _calculatePosition(
        index: _player.currentIndex ?? 0,
        position: event.inSeconds,
      );
    });

    _playerStateController = _player.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        emit(state.copyWith(isPlaying: false));
        return;
      }
      // This covers the case when the user is using headphones and resumed the playback
      // using buttons on the headphones
      if (event == ProcessingState.ready && _player.playing) {
        emit(state.copyWith(isPlaying: true));
      }
      if (event == ProcessingState.idle) {
        stop();
      }
    });
  }

  void _resetPositionTimeout() {
    _positionTimeoutTimer?.cancel();
    _positionTimeoutTimer = Timer(const Duration(seconds: 1), () {
      // No events for 1 second, we can assume that the user has stopped the playback
      // using headphones, pause it in UI as well.
      pause();
    });
  }

  void _calculatePosition({required int index, required int position}) {
    final parts = state.parts;
    final previousParts = parts.sublist(0, index);
    final previousDuration = previousParts.fold<int>(
      0,
      (previousValue, element) => previousValue + element.duration.floor(),
    );

    final newPosition = previousDuration + position;

    // Saving progress happens here, we save it every 10 seconds
    _saveProgress(newPosition);

    // 1. If we are too far from the current position, we ignore the change, gives
    // really smooth experience for the user
    // 2. If there are a lot of tries, something went wrong, allow the change
    if (newPosition < state.statePosition - 2 && _failureCount < 10) {
      _failureCount++;
      return;
    }
    if (newPosition > state.statePosition + 2 && _failureCount < 10) {
      _failureCount++;
      return;
    }
    // Reset failure count, local and state progresses are synchronized
    _failureCount = 0;
    emit(
      state.copyWith(statePosition: newPosition, currentlyPlayingPart: index),
    );
  }

  // This function finds the position in the index of the audiobook from
  // given timestamp in seconds
  (int positionInIndex, int index) _findPositionAndIndex(int position) {
    int index = 0;
    int remainingSeconds = position;

    for (int i = 0; i < state.parts.length; i++) {
      if (remainingSeconds < state.parts[i].duration) {
        index = i;
        break;
      }
      remainingSeconds -= state.parts[i].duration.floor();
    }

    return (remainingSeconds, index);
  }

  // This function saves the progress of the audiobook in the repository
  Future<void> _saveProgress(int position) async {
    if (position % 10 != 0 || position == 0) return;
    if (state.book == null) return;
    if (_currentlySavingProgress == position) {
      return;
    }
    _currentlySavingProgress = position;
    AppLogger.instance.d(
      'AudioCubit',
      'Saving progress at position: $position',
    );
    ProgressModel progress;
    if (state.progress != null) {
      progress = state.progress!.copyWith(audioTimestamp: position);
    } else {
      progress = ProgressModel.fromAudio(
        slug: state.book!.slug,
        audioTimestamp: position,
      );
    }
    _progressRepository.setProgress(
      slug: state.book!.slug,
      progress: progress,
      type: ProgressType.audio,
    );
  }

  // This function gets the progress of the audiobook from the repository
  // and sets the position in UI, used in setting player position as well
  Future<(int, int)> _getAndSetProgress({
    int? overrideProgressTimestamp,
  }) async {
    if (overrideProgressTimestamp != null) {
      final overridenPosition = _findPositionAndIndex(
        overrideProgressTimestamp,
      );
      emit(
        state.copyWith(
          statePosition: overrideProgressTimestamp,
          currentlyPlayingPart: overridenPosition.$2,
        ),
      );
      return overridenPosition;
    }
    final existingProgress = await _progressRepository.getProgressByBook(
      slug: state.book!.slug,
    );
    (int, int) foundPosition = (0, 0);

    existingProgress.handle(
      success: (data, _) {
        final timestamp = data.audioTimestamp ?? 0;
        foundPosition = _findPositionAndIndex(timestamp);
        AppLogger.instance.d(
          'AudioCubit',
          'Retrieving progress and setting at: $timestamp',
        );
        emit(
          state.copyWith(
            statePosition: timestamp,
            progress: data,
            currentlyPlayingPart: foundPosition.$2,
          ),
        );
      },
      failure: (f) {
        AppLogger.instance.e(
          'AudioCubit',
          'Failed to retrieve progress for book: ${state.book?.slug}',
        );
      },
    );
    return foundPosition;
  }

  void _cancelSubscriptions() {
    _positionController?.cancel();
    _playerStateController?.cancel();
  }

  @override
  Future<void> close() async {
    emit(state.copyWith(isPlaying: false));
    _sleepTimer?.cancel();
    _positionTimeoutTimer?.cancel();
    _cancelSubscriptions();
    await _player.dispose();
    await _audioSession.setActive(false);
    return super.close();
  }
}
