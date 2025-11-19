import 'dart:async';

import 'package:audio_session/audio_session.dart';

export 'package:audio_session/audio_session.dart'
    show AudioInterruptionEvent, AudioInterruptionType;

// Holds information about audio session initialization
bool _isAudioSessionInitialized = false;
// Completer holded outside class since CustomAudioSession can be accessed by multiple sources at the same time
Completer? _completer;

class CustomAudioSession {
  static CustomAudioSession? _instance;

  late AudioSession _session;

  factory CustomAudioSession() {
    _instance ??= CustomAudioSession._();
    return _instance!;
  }

  CustomAudioSession._() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (_isAudioSessionInitialized) return;
    _isAudioSessionInitialized = true;
    _completer = Completer();
    _session = await AudioSession.instance;
    await _session.configure(
      AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetoothA2dp |
            AVAudioSessionCategoryOptions.defaultToSpeaker,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy:
            AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidWillPauseWhenDucked: true,
      ),
    );

    _completer?.complete();
  }

  /// Initialization future after which we can use [CustomAudioSession] widely
  Future<void> get initializationFuture {
    if (_completer == null) return Future.delayed(Duration.zero);
    if (_completer!.isCompleted) return Future.delayed(Duration.zero);
    return _completer!.future;
  }

  /// Will inform other sources of audio that our source is gonna play if value is true
  /// If value is false it means, that we will inform other sources that we stopped playing
  /// If returns false, it means that we are not allowed to play audio
  Future<bool> setActive(bool value) async {
    await initializationFuture;
    return _session.setActive(value);
  }

  Future<Stream<void>> becomeNoisyStream() async {
    await initializationFuture;
    return _session.becomingNoisyEventStream;
  }

  Future<Stream<AudioInterruptionEvent>> interruptionEventStream() async {
    await initializationFuture;
    return _session.interruptionEventStream;
  }
}
