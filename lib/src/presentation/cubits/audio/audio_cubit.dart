import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/data/audiobook_repository.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/audiobook_model.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/domain/book_text_audio_sync_model.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/presentation/enums/audio_player_speed_enum.dart';
import 'package:wolnelektury/src/utils/audio/custom_audio_session.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'audio_cubit.freezed.dart';
part 'audio_state.dart';

/// Cubit managing audiobook playback state and controls
/// Handles audio session management, playlist preparation, progress tracking,
/// and user interactions like play/pause, seeking, and speed adjustment
class AudioCubit extends SafeCubit<AudioState> {
  final AudiobookRepository _audiobookRepository;
  final ProgressRepository _progressRepository;
  final BooksRepository _booksRepository;

  AudioCubit(
    this._audiobookRepository,
    this._progressRepository,
    this._booksRepository,
  ) : super(const AudioState());

  /// Timer for sleep functionality (stops playback after specified duration)
  Timer? _sleepTimer;

  /// Timer to detect when playback stops (e.g., when headphones are disconnected)
  Timer? _positionTimeoutTimer;

  /// Counter to track position synchronization failures between UI and player
  /// Used to prevent jarring position jumps during playback
  int _failureCount = 0;

  /// Tracks the last progress timestamp being saved to prevent duplicate saves
  int _currentlySavingProgress = 0;

  /// Just Audio player instance configured for audiobook playback
  /// androidApplyAudioAttributes set to false for custom audio session handling
  final AudioPlayer _player = AudioPlayer(androidApplyAudioAttributes: false);

  /// Custom audio session managing system audio focus and interruptions
  final CustomAudioSession _audioSession = CustomAudioSession();

  /// Subscription listening to player position updates for progress tracking
  StreamSubscription<Duration>? _positionController;

  /// Subscription listening to player state changes (ready, buffering, completed, etc.)
  StreamSubscription<ProcessingState>? _playerStateController;

  /// Toggles the settings panel visibility in the audio player UI
  void toggleSettings(bool value) {
    emit(state.copyWith(isSettingsOpened: value));
  }

  /// Toggles the bookmarks panel visibility in the audio player UI
  void toggleBookmarks(bool value) {
    emit(state.copyWith(isBookmarksOpened: value));
  }

  /// Updates the sleep timer duration and starts/cancels the timer
  /// [timer] duration in minutes, 0 disables the timer
  /// [cancelTimer] if true, cancels the timer without starting a new one
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

  /// Updates the playback speed (0.5x, 1x, 1.25x, 1.5x, 2x)
  void changeSpeed(AudioPlayerSpeedEnum speed) {
    emit(state.copyWith(speed: speed));
    _player.setSpeed(speed.value);
  }

  /// Loads and prepares an audiobook for playback
  /// [book] the book model to load
  /// [tryOffline] if true, attempts to load from offline storage
  /// [targetTimestamp] optional timestamp in seconds to start from
  Future<void> pickBook(
    BookModel book, {
    bool tryOffline = false,
    int? targetTimestamp,
  }) async {
    // Check if we're reloading the same book or switching modes (online/offline)
    final isSameAudiobookInitialized = state.book?.slug == book.slug;
    final wasInitializedOnline = state.parts.any((e) => !e.isOffline);
    final wasInitializedOffline = !wasInitializedOnline;
    if (isSameAudiobookInitialized) {
      // Determine if we need to reload due to online/offline mode change
      final modeChanged =
          (wasInitializedOffline && !tryOffline) ||
          (wasInitializedOnline && tryOffline);

      // Same book, same mode - no reload needed
      // Only skip reload if there's no target timestamp (not jumping to specific position)
      if (!modeChanged && targetTimestamp == null) {
        await _getTextAudioSyncData(book.slug);
        await _getAndSetProgress(targetTimestamp: targetTimestamp);
        return;
      }

      // Mode changed, fetch sync data before reloading
    }
    // New book selected (or mode changed), reset all values
    // Stop current playback and clear player state
    emit(state.copyWith(book: book, isLoadingAudiobook: true, isError: false));
    await stop();

    // Update state to show loading and clear any previous errors

    // Fetch audiobook data (parts/chapters) from repository
    final audiobookResponse = await _audiobookRepository.getAudiobook(
      slug: book.slug,
      tryOffline: tryOffline,
    );

    audiobookResponse.handle(
      success: (data, pagination) async {
        // Successfully loaded audiobook parts
        await _getTextAudioSyncData(book.slug);
        emit(
          state.copyWith(
            audiobook: AudiobookModel.create(parts: data),
            isLoadingAudiobook: false,
          ),
        );

        // Prepare playlist if player is not already playing
        if (!_player.playing) {
          _preparePlaylist(overridenPosition: targetTimestamp);
        }
      },
      failure: (failure) {
        // Failed to load audiobook (network error, not found, etc.)
        emit(state.copyWith(isLoadingAudiobook: false, isError: true));
      },
    );
  }

  /// Resets the "play to part" feature, clearing the sleep timer configuration
  void resetPlayToPart() {
    changeSleepTimer(state.currentMaxSleepTimer, cancelTimer: true);
    emit(state.copyWith(playToPart: 0));
  }

  /// Decreases the target part for "play to end of part" feature
  /// Automatically stops playback after reaching the specified part
  void decreasePlayToPart() {
    final currentlyPlayingPart = _player.currentIndex ?? 0;
    final currentlySetToPart = state.playToPart - 1;

    // Reset if we've gone below valid range or past current position
    if (currentlySetToPart < 0 || currentlySetToPart < currentlyPlayingPart) {
      resetPlayToPart();
      return;
    }

    // Calculate total duration from current part to target part
    final partsBetween = state.parts.getRange(
      currentlyPlayingPart,
      currentlySetToPart,
    );
    final durationOfPartsBetween = partsBetween.fold<int>(
      0,
      (prev, e) => prev + e.duration.floor(),
    );
    final inMinutes = durationOfPartsBetween ~/ 60;

    // Update sleep timer to match calculated duration
    changeSleepTimer(inMinutes);
    emit(state.copyWith(playToPart: currentlySetToPart));
  }

  /// Increases the target part for "play to end of part" feature
  /// Calculates and sets sleep timer based on remaining duration
  void increasePlayToPart() {
    final currentlyPlayingPart = _player.currentIndex ?? 0;
    // Can't go beyond the last part
    if (state.playToPart > state.parts.length - 1) return;

    // Starting from current part: calculate remaining time in this part
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
    // Already past target part, clear timer
    if (currentlySetToPart <= currentlyPlayingPart) {
      changeSleepTimer(0);
      emit(state.copyWith(playToPart: currentlySetToPart));
      return;
    }

    // Calculate total duration from current part to new target part
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

  /// Starts or resumes audiobook playback
  /// [overridenPosition] optional starting position in seconds
  Future<void> play({int? overridenPosition}) async {
    // Require audio session to play
    // Request system audio focus before playback
    emit(state.copyWith(isPreparingSession: true, isError: false));
    final canPlay = await _audioSession.setActive(true);
    emit(state.copyWith(isPreparingSession: false));
    // Couldn't get audio session, return
    if (!canPlay) return;
    // Check if it needs a playlist
    // Ensure playlist is loaded and positioned correctly
    await _preparePlaylist(overridenPosition: overridenPosition);

    // Audio session granted, playlist ready, play audio
    emit(state.copyWith(isPlaying: true));
    // If at the end, restart from beginning
    if (state.statePosition == state.wholeDuration) {
      emit(state.copyWith(statePosition: 0));
      _player.seek(const Duration(seconds: 0), index: 0);
    }
    await _player.setVolume(1);
    await _player.play();
  }

  /// Pauses audiobook playback and releases audio session
  Future<void> pause() async {
    emit(state.copyWith(isPlaying: false));
    // Pause playback and release system audio focus
    await Future.wait([_player.pause(), _audioSession.setActive(false)]);
  }

  /// Stops playback completely and resets the player to initial state
  /// Preserves book and audiobook data but clears playback state
  Future<void> stop() async {
    // Reset to clean state while keeping book data
    emit(
      AudioState(
        book: state.book,
        audiobook: state.audiobook,
        isLoadingAudiobook: state.isLoadingAudiobook,
      ),
    );
    await _player.setVolume(0);
    await _cancelSubscriptions();
    await Future.wait([
      _player.stop(),
      _player.seek(Duration.zero, index: 0),
      _player.clearAudioSources(),
      _audioSession.setActive(false),
    ]);
  }

  /// Seeks forward 15 seconds, handling part boundaries
  Future<void> forward15s() async {
    final currentIndex = _player.currentIndex ?? 0;
    final positionInCurrentPart = _player.position.inSeconds;
    final lengthOfPart = state.parts[currentIndex].duration.floor();

    int newPosition = positionInCurrentPart + 15;
    int newIndex = currentIndex;

    // Don't seek past the end of the audiobook
    if (state.statePosition + 15 > state.wholeDuration) return;

    // Check if we need to move to the next part
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

  /// Seeks backward 15 seconds, handling part boundaries
  Future<void> backward15s() async {
    final currentIndex = _player.currentIndex ?? 0;
    final positionInCurrentPart = _player.position.inSeconds;

    // Update state position, ensuring it doesn't go negative
    emit(state.copyWith(statePosition: max(0, state.statePosition - 15)));

    // Can rewind within current part
    if (positionInCurrentPart >= 15) {
      await _player.seek(
        Duration(seconds: positionInCurrentPart - 15),
        index: currentIndex,
      );
    } else if (currentIndex > 0) {
      // Need to go to previous part
      final previousPartDuration = state.parts[currentIndex - 1].duration
          .floor();
      await _player.seek(
        Duration(seconds: previousPartDuration - (15 - positionInCurrentPart)),
        index: currentIndex - 1,
      );
    } else {
      // At the beginning, can't rewind further
      await _player.seek(const Duration(seconds: 0), index: 0);
    }
  }

  /// Commits the locally selected position (from UI slider) to the player
  /// [optionalSeconds] position in seconds, uses localPosition if null
  Future<void> seekToLocallySelectedPosition({int? optionalSeconds}) async {
    if (optionalSeconds == null && state.localPosition == null) {
      return;
    }

    // Seeked seconds
    final seconds = optionalSeconds ?? state.localPosition!;
    // Convert absolute position to (position in part, part index)
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

  /// Updates the local position while user is dragging the progress slider
  /// Does not affect actual playback until seekToLocallySelectedPosition is called
  void updateLocalPosition(int seconds) {
    emit(state.copyWith(localPosition: seconds));
  }

  /// Jumps to a specific audiobook part/chapter
  /// [part] index of the part to jump to
  void selectPart(int? part) {
    if (part == null || part < 0 || part >= state.parts.length) return;
    // If the player is playing, listener will take care of updating the state
    _player.seek(Duration.zero, index: part);
    // If the player is not playing, we need to update the state manually
    if (!_player.playing) {
      emit(
        state.copyWith(
          currentlyPlayingPart: part,
          statePosition: state.partPositionInWholeDuration(part),
        ),
      );
    }
  }

  /// Fetches text-to-audio synchronization data for the book.
  Future<void> _getTextAudioSyncData(String slug) async {
    emit(state.copyWith(textSyncPairs: []));
    final audioSyncData = await _booksRepository.getBookTextAudioSync(
      slug: slug,
    );
    audioSyncData.handle(
      success: (data, _) {
        emit(state.copyWith(textSyncPairs: data));
      },
      failure: (_) {
        emit(state.copyWith(textSyncPairs: []));
      },
    );
  }

  /// Prepares the audio playlist for playback
  /// Creates AudioSource items for each part and initializes the player
  /// [overridenPosition] optional starting position in seconds
  Future<void> _preparePlaylist({int? overridenPosition}) async {
    // No audiobook loaded yet
    if (state.audiobook == null) {
      return;
    }
    // Playlist already prepared
    if ((_player.audioSource?.sequence ?? []).isNotEmpty) {
      return;
    }
    emit(
      state.copyWith(
        isPreparingPlaylist: true,
        sleepTimer: state.maxSleepTimer,
      ),
    );
    // Create audio sources for each part (file or network stream)
    final playlist = state.audiobook!.parts.map((part) {
      // Media item for system notification and lock screen controls
      final mediaItem = MediaItem(
        id: part.name,
        album: state.book?.title,
        title: part.name,
        artUri: Uri.parse(state.book?.coverUrl ?? ''),
        duration: Duration(seconds: part.duration.floor()),
      );

      // Use file source for offline, URI for online
      if (part.isOffline) {
        return AudioSource.file(part.url, tag: mediaItem);
      }
      return AudioSource.uri(Uri.parse(part.url), tag: mediaItem);
    }).toList();

    // This gets the progress of the audiobook from the repository
    // and sets the position in UI as well as in the player
    // Retrieve saved progress or use override position
    (int, int) foundPosition = await _getAndSetProgress(
      targetTimestamp: overridenPosition,
    );
    AppLogger.instance.d(
      'AudioCubit',
      'Prepared playlist for book ${state.book?.title}',
    );
    try {
      // Wait for audio session to be ready
      await _audioSession.initializationFuture;
      // Configure player with playlist and starting position
      await _player.setAudioSources(
        playlist,
        // Position in the part
        initialPosition: Duration(seconds: foundPosition.$1),
        // Part index
        initialIndex: foundPosition.$2,
      );
      await _player.setLoopMode(LoopMode.off);
      await _player.setSpeed(AudioPlayerSpeedEnum.x1.value);
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
    // Start listening to position and state changes
    _attachPositionListener();
    emit(state.copyWith(isPreparingPlaylist: false));
  }

  /// Sets up listeners for player position and processing state changes
  void _attachPositionListener() {
    _positionController?.cancel();
    // Listen to position updates to track progress and save state
    _positionController = _player.positionStream.listen((event) {
      _resetPositionTimeout();
      _calculatePosition(
        index: _player.currentIndex ?? 0,
        position: event.inSeconds,
      );
    });

    // Listen to player state changes (buffering, ready, completed, etc.)
    _playerStateController = _player.processingStateStream.listen((event) {
      // Reached end of audiobook
      if (event == ProcessingState.completed) {
        emit(state.copyWith(isPlaying: false));
        return;
      }
      // This covers the case when the user is using headphones and resumed the playback
      // using buttons on the headphones
      if (event == ProcessingState.ready && _player.playing) {
        emit(state.copyWith(isPlaying: true));
      }
      // Player stopped externally
      if (event == ProcessingState.idle) {
        stop();
      }
    });
  }

  /// Resets the timeout timer that detects when playback stops unexpectedly
  /// Called on each position update to keep the timer alive during active playback
  void _resetPositionTimeout() {
    _positionTimeoutTimer?.cancel();
    _positionTimeoutTimer = Timer(const Duration(seconds: 1), () {
      // No events for 1 second, we can assume that the user has stopped the playback
      // using headphones, pause it in UI as well.
      pause();
    });
  }

  /// Calculates the absolute position in the audiobook from part index and position
  /// Updates state with new position and handles progress saving
  /// [index] current part index
  /// [position] position within the current part in seconds
  void _calculatePosition({required int index, required int position}) {
    final parts = state.parts;
    // Sum up durations of all previous parts
    final previousParts = parts.sublist(0, index);
    final previousDuration = previousParts.fold<int>(
      0,
      (previousValue, element) => previousValue + element.duration.floor(),
    );

    // Calculate absolute position in the entire audiobook
    final newPosition = previousDuration + position;

    // Saving progress happens here, we save it every 10 seconds
    _saveProgress(newPosition);

    // 1. If we are too far from the current position, we ignore the change, gives
    // really smooth experience for the user
    // 2. If there are a lot of tries, something went wrong, allow the change
    // Prevent jarring UI jumps by tolerating small discrepancies
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
    // Sync playing state if needed
    if (!state.isPlaying && _player.playing) {
      emit(state.copyWith(isPlaying: true));
    }
  }

  /// Converts an absolute position (seconds) to (position in part, part index)
  /// Returns a tuple of (seconds within part, part index)
  (int positionInIndex, int index) _findPositionAndIndex(int position) {
    int index = 0;
    int remainingSeconds = position;

    // Iterate through parts, subtracting durations until we find the right part
    for (int i = 0; i < state.parts.length; i++) {
      if (remainingSeconds < state.parts[i].duration) {
        index = i;
        break;
      }
      remainingSeconds -= state.parts[i].duration.floor();
    }

    return (remainingSeconds, index);
  }

  /// Saves playback progress to the repository every 10 seconds
  /// [position] absolute position in seconds
  Future<void> _saveProgress(int position) async {
    // Only save at 10-second intervals to reduce repository writes
    if (position % 10 != 0 || position == 0) return;
    if (state.book == null) return;
    // Prevent duplicate saves for the same position
    if (_currentlySavingProgress == position) {
      return;
    }
    _currentlySavingProgress = position;
    AppLogger.instance.d(
      'AudioCubit',
      'Saving progress at position: $position',
    );
    // Update existing progress or create new progress model
    ProgressModel progress;
    if (state.progress != null) {
      progress = state.progress!.copyWith(audioTimestamp: position);
    } else {
      progress = ProgressModel.fromAudio(
        slug: state.book!.slug,
        audioTimestamp: position,
      );
    }
    // Persist to repository
    _progressRepository.setProgress(
      slug: state.book!.slug,
      progress: progress,
      type: ProgressType.audio,
    );
  }

  /// Retrieves saved progress from repository and updates state
  /// [targetTimestamp] if provided, uses this instead of saved progress
  /// Returns (position in part, part index) tuple
  Future<(int, int)> _getAndSetProgress({int? targetTimestamp}) async {
    // Use override position if provided (e.g., from deep link or bookmark)
    if (targetTimestamp != null) {
      final overridenPosition = _findPositionAndIndex(targetTimestamp);
      emit(
        state.copyWith(
          statePosition: targetTimestamp,
          currentlyPlayingPart: overridenPosition.$2,
        ),
      );
      return overridenPosition;
    }
    // Fetch saved progress from repository
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
        // Update state with saved progress
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

  /// Cancels all active stream subscriptions
  Future<void> _cancelSubscriptions() async {
    await _positionController?.cancel();
    await _playerStateController?.cancel();
  }

  /// Cleanup: stops playback, cancels timers, and disposes resources
  @override
  Future<void> close() async {
    // Stop playback immediately
    emit(state.copyWith(isPlaying: false));
    // Cancel all timers
    _sleepTimer?.cancel();
    _positionTimeoutTimer?.cancel();
    // Cancel stream subscriptions
    // Dispose player and release audio session
    await Future.wait([
      _player.dispose(),
      _audioSession.setActive(false),
      _cancelSubscriptions(),
    ]);
    return super.close();
  }
}
