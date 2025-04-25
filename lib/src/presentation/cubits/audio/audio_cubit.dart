import 'dart:async';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:wolnelektury/src/data/audiobook_repository.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/enums/audio_player_speed_enum.dart';
import 'package:wolnelektury/src/utils/audio/custom_audio_session.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'audio_cubit.freezed.dart';
part 'audio_state.dart';

class AudioCubit extends SafeCubit<AudioState> {
  final AudiobookRepository _audiobookRepository;
  AudioCubit(this._audiobookRepository) : super(const AudioState());
  Timer? _sleepTimer;

  // This restores player progress if needed
  int _failureCount = 0;

  // Audioplayer instance
  final AudioPlayer _player = AudioPlayer();

  // Audio session instance
  final CustomAudioSession _audioSession = CustomAudioSession();

  // Current audio stream position controller
  StreamSubscription<Duration>? _positionController;
  StreamSubscription<ProcessingState>? _playerStateController;

  void toggleSettings(bool value) {
    emit(state.copyWith(isSettingsOpened: value));
  }

  void changeSleepTimer(int timer, {bool cancelTimer = false}) {
    emit(state.copyWith(sleepTimer: timer, playToPart: 0));
    _sleepTimer?.cancel();
    if (!cancelTimer && timer > 0) {
      _sleepTimer = Timer(
        Duration(minutes: timer),
        () async {
          await stop();
          emit(state.copyWith(sleepTimer: 0));
        },
      );
    }
  }

  void changeSpeed(AudioPlayerSpeedEnum speed) {
    emit(state.copyWith(speed: speed));
    _player.setSpeed(speed.value);
  }

  // Select book for AudioPlayer
  Future<void> pickBook(BookModel book) async {
    emit(
      state.copyWith(
        book: book,
      ),
    );

    emit(state.copyWith(isLoadingAudiobook: true));
    final audiobookResponse = await _audiobookRepository.getAudiobook(
      slug: book.slug,
    );
    await Future.delayed(const Duration(milliseconds: 2000));

    audiobookResponse.when(
      success: (data, _) {
        emit(
          state.copyWith(
            audiobook: AudiobookModel.create(parts: data),
            isLoadingAudiobook: false,
          ),
        );

        // Prepare playlist if player is not already playing
        if (!_player.playing) {
          _preparePlaylist();
        }
      },
      failed: (_) {
        emit(state.copyWith(isLoadingAudiobook: false));
        //todo handle failure
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

  Future<void> play() async {
    // Require audio session to play
    emit(state.copyWith(isPreparingSession: true));
    final canPlay = await _audioSession.setActive(true);
    emit(state.copyWith(isPreparingSession: false));
    // Couldn't get audio session, return
    if (!canPlay) return;
    // Check if it needs a playlist
    await _preparePlaylist();

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
    await Future.wait([
      _player.pause(),
      _audioSession.setActive(false),
    ]);
  }

  Future<void> stop() async {
    _cancelSubscriptions();
    emit(
      AudioState(
        book: state.book,
        audiobook: state.audiobook,
      ),
    );
    Future.wait([
      _player.stop(),
      _player.seek(Duration.zero, index: 0),
      _player.setAudioSource(
        ConcatenatingAudioSource(
          children: [],
        ),
      ),
      _audioSession.setActive(false),
    ]);
  }

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

  Future<void> backward15s() async {
    final currentIndex = _player.currentIndex ?? 0;
    final positionInCurrentPart = _player.position.inSeconds;

    emit(
      state.copyWith(
        statePosition: max(0, state.statePosition - 15),
      ),
    );

    if (positionInCurrentPart >= 15) {
      await _player.seek(
        Duration(seconds: positionInCurrentPart - 15),
        index: currentIndex,
      );
    } else if (currentIndex > 0) {
      final previousPartDuration =
          state.parts[currentIndex - 1].duration.floor();
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
  Future<void> seekToLocallySelectedPosition({
    int? optionalSeconds,
  }) async {
    if (optionalSeconds == null && state.localPosition == null) {
      return;
    }
    // Seeked seconds
    final seconds = optionalSeconds ?? state.localPosition!;
    int remainingSeconds = seconds;
    int index = state.parts.length - 1;
    // Finding correct seconds of correct audiobooks part
    for (int i = 0; i < state.parts.length; i++) {
      if (remainingSeconds < state.parts[i].duration) {
        index = i;
        break;
      }
      remainingSeconds -= state.parts[i].duration.floor();
    }

    emit(
      state.copyWith(
        localPosition: null,
        statePosition: seconds,
      ),
    );

    // If we are at the end of the audiobook, pause it
    if (seconds == state.wholeDuration) {
      emit(state.copyWith(isPlaying: false));
      _player.pause();
    }

    // Seek to the found position
    await _player.seek(
      Duration(
        seconds: remainingSeconds,
      ),
      index: index,
    );
  }

  void updateLocalPosition(int seconds) {
    emit(
      state.copyWith(
        localPosition: seconds,
      ),
    );
  }

  void dialogShown(bool value) {
    emit(state.copyWith(isDialogShown: value));
  }

  void selectPart(int? part) {
    if (part == null || part < 0 || part >= state.parts.length) return;
    _player.seek(Duration.zero, index: part);
  }

  Future<void> _preparePlaylist() async {
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

    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: state.audiobook!.parts.map(
        (part) {
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
        },
      ).toList(),
    );

    await Future.wait([
      _audioSession.initializationFuture,
      _player.setAudioSource(
        playlist,
        initialIndex: 0,
        initialPosition: Duration.zero,
      ),
      _player.setLoopMode(LoopMode.off),
      _player.setSpeed(AudioPlayerSpeedEnum.x1.value),
    ]);

    _attachPositionListener();
    emit(state.copyWith(isPreparingPlaylist: false));
  }

  void _attachPositionListener() {
    _positionController = _player.positionStream.listen((event) {
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
      if (event == ProcessingState.idle) {
        stop();
      }
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
      state.copyWith(
        statePosition: newPosition,
        currentlyPlayingPart: index,
      ),
    );
  }

  void _cancelSubscriptions() {
    _positionController?.cancel();
    _playerStateController?.cancel();
  }

  @override
  Future<void> close() async {
    emit(state.copyWith(isPlaying: false));
    _sleepTimer?.cancel();
    _cancelSubscriptions();
    await _player.dispose();
    await _audioSession.setActive(false);
    return super.close();
  }
}
