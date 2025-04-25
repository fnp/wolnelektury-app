// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioState {
  BookModel? get book => throw _privateConstructorUsedError;
  AudiobookModel? get audiobook => throw _privateConstructorUsedError;
  dynamic get isDialogShown => throw _privateConstructorUsedError;
  dynamic get isLoadingAudiobook =>
      throw _privateConstructorUsedError; // Player
  int get statePosition => throw _privateConstructorUsedError;
  int? get localPosition => throw _privateConstructorUsedError;
  int get currentlyPlayingPart => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isPreparingSession => throw _privateConstructorUsedError;
  bool get isPreparingPlaylist =>
      throw _privateConstructorUsedError; // Settings
  bool get isSettingsOpened => throw _privateConstructorUsedError;
  int get sleepTimer => throw _privateConstructorUsedError;
  AudioPlayerSpeedEnum get speed => throw _privateConstructorUsedError;
  int get playToPart => throw _privateConstructorUsedError;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioStateCopyWith<AudioState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(
          AudioState value, $Res Function(AudioState) then) =
      _$AudioStateCopyWithImpl<$Res, AudioState>;
  @useResult
  $Res call(
      {BookModel? book,
      AudiobookModel? audiobook,
      dynamic isDialogShown,
      dynamic isLoadingAudiobook,
      int statePosition,
      int? localPosition,
      int currentlyPlayingPart,
      bool isPlaying,
      bool isPreparingSession,
      bool isPreparingPlaylist,
      bool isSettingsOpened,
      int sleepTimer,
      AudioPlayerSpeedEnum speed,
      int playToPart});

  $BookModelCopyWith<$Res>? get book;
  $AudiobookModelCopyWith<$Res>? get audiobook;
}

/// @nodoc
class _$AudioStateCopyWithImpl<$Res, $Val extends AudioState>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? book = freezed,
    Object? audiobook = freezed,
    Object? isDialogShown = freezed,
    Object? isLoadingAudiobook = freezed,
    Object? statePosition = null,
    Object? localPosition = freezed,
    Object? currentlyPlayingPart = null,
    Object? isPlaying = null,
    Object? isPreparingSession = null,
    Object? isPreparingPlaylist = null,
    Object? isSettingsOpened = null,
    Object? sleepTimer = null,
    Object? speed = null,
    Object? playToPart = null,
  }) {
    return _then(_value.copyWith(
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookModel?,
      audiobook: freezed == audiobook
          ? _value.audiobook
          : audiobook // ignore: cast_nullable_to_non_nullable
              as AudiobookModel?,
      isDialogShown: freezed == isDialogShown
          ? _value.isDialogShown
          : isDialogShown // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isLoadingAudiobook: freezed == isLoadingAudiobook
          ? _value.isLoadingAudiobook
          : isLoadingAudiobook // ignore: cast_nullable_to_non_nullable
              as dynamic,
      statePosition: null == statePosition
          ? _value.statePosition
          : statePosition // ignore: cast_nullable_to_non_nullable
              as int,
      localPosition: freezed == localPosition
          ? _value.localPosition
          : localPosition // ignore: cast_nullable_to_non_nullable
              as int?,
      currentlyPlayingPart: null == currentlyPlayingPart
          ? _value.currentlyPlayingPart
          : currentlyPlayingPart // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreparingSession: null == isPreparingSession
          ? _value.isPreparingSession
          : isPreparingSession // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreparingPlaylist: null == isPreparingPlaylist
          ? _value.isPreparingPlaylist
          : isPreparingPlaylist // ignore: cast_nullable_to_non_nullable
              as bool,
      isSettingsOpened: null == isSettingsOpened
          ? _value.isSettingsOpened
          : isSettingsOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      sleepTimer: null == sleepTimer
          ? _value.sleepTimer
          : sleepTimer // ignore: cast_nullable_to_non_nullable
              as int,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as AudioPlayerSpeedEnum,
      playToPart: null == playToPart
          ? _value.playToPart
          : playToPart // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookModelCopyWith<$Res>? get book {
    if (_value.book == null) {
      return null;
    }

    return $BookModelCopyWith<$Res>(_value.book!, (value) {
      return _then(_value.copyWith(book: value) as $Val);
    });
  }

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudiobookModelCopyWith<$Res>? get audiobook {
    if (_value.audiobook == null) {
      return null;
    }

    return $AudiobookModelCopyWith<$Res>(_value.audiobook!, (value) {
      return _then(_value.copyWith(audiobook: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AudioStateImplCopyWith<$Res>
    implements $AudioStateCopyWith<$Res> {
  factory _$$AudioStateImplCopyWith(
          _$AudioStateImpl value, $Res Function(_$AudioStateImpl) then) =
      __$$AudioStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BookModel? book,
      AudiobookModel? audiobook,
      dynamic isDialogShown,
      dynamic isLoadingAudiobook,
      int statePosition,
      int? localPosition,
      int currentlyPlayingPart,
      bool isPlaying,
      bool isPreparingSession,
      bool isPreparingPlaylist,
      bool isSettingsOpened,
      int sleepTimer,
      AudioPlayerSpeedEnum speed,
      int playToPart});

  @override
  $BookModelCopyWith<$Res>? get book;
  @override
  $AudiobookModelCopyWith<$Res>? get audiobook;
}

/// @nodoc
class __$$AudioStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioStateImpl>
    implements _$$AudioStateImplCopyWith<$Res> {
  __$$AudioStateImplCopyWithImpl(
      _$AudioStateImpl _value, $Res Function(_$AudioStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? book = freezed,
    Object? audiobook = freezed,
    Object? isDialogShown = freezed,
    Object? isLoadingAudiobook = freezed,
    Object? statePosition = null,
    Object? localPosition = freezed,
    Object? currentlyPlayingPart = null,
    Object? isPlaying = null,
    Object? isPreparingSession = null,
    Object? isPreparingPlaylist = null,
    Object? isSettingsOpened = null,
    Object? sleepTimer = null,
    Object? speed = null,
    Object? playToPart = null,
  }) {
    return _then(_$AudioStateImpl(
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookModel?,
      audiobook: freezed == audiobook
          ? _value.audiobook
          : audiobook // ignore: cast_nullable_to_non_nullable
              as AudiobookModel?,
      isDialogShown:
          freezed == isDialogShown ? _value.isDialogShown! : isDialogShown,
      isLoadingAudiobook: freezed == isLoadingAudiobook
          ? _value.isLoadingAudiobook!
          : isLoadingAudiobook,
      statePosition: null == statePosition
          ? _value.statePosition
          : statePosition // ignore: cast_nullable_to_non_nullable
              as int,
      localPosition: freezed == localPosition
          ? _value.localPosition
          : localPosition // ignore: cast_nullable_to_non_nullable
              as int?,
      currentlyPlayingPart: null == currentlyPlayingPart
          ? _value.currentlyPlayingPart
          : currentlyPlayingPart // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreparingSession: null == isPreparingSession
          ? _value.isPreparingSession
          : isPreparingSession // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreparingPlaylist: null == isPreparingPlaylist
          ? _value.isPreparingPlaylist
          : isPreparingPlaylist // ignore: cast_nullable_to_non_nullable
              as bool,
      isSettingsOpened: null == isSettingsOpened
          ? _value.isSettingsOpened
          : isSettingsOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      sleepTimer: null == sleepTimer
          ? _value.sleepTimer
          : sleepTimer // ignore: cast_nullable_to_non_nullable
              as int,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as AudioPlayerSpeedEnum,
      playToPart: null == playToPart
          ? _value.playToPart
          : playToPart // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AudioStateImpl implements _AudioState {
  const _$AudioStateImpl(
      {this.book,
      this.audiobook,
      this.isDialogShown = false,
      this.isLoadingAudiobook = false,
      this.statePosition = 0,
      this.localPosition,
      this.currentlyPlayingPart = 0,
      this.isPlaying = false,
      this.isPreparingSession = false,
      this.isPreparingPlaylist = false,
      this.isSettingsOpened = false,
      this.sleepTimer = 0,
      this.speed = AudioPlayerSpeedEnum.x1,
      this.playToPart = 0});

  @override
  final BookModel? book;
  @override
  final AudiobookModel? audiobook;
  @override
  @JsonKey()
  final dynamic isDialogShown;
  @override
  @JsonKey()
  final dynamic isLoadingAudiobook;
// Player
  @override
  @JsonKey()
  final int statePosition;
  @override
  final int? localPosition;
  @override
  @JsonKey()
  final int currentlyPlayingPart;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isPreparingSession;
  @override
  @JsonKey()
  final bool isPreparingPlaylist;
// Settings
  @override
  @JsonKey()
  final bool isSettingsOpened;
  @override
  @JsonKey()
  final int sleepTimer;
  @override
  @JsonKey()
  final AudioPlayerSpeedEnum speed;
  @override
  @JsonKey()
  final int playToPart;

  @override
  String toString() {
    return 'AudioState(book: $book, audiobook: $audiobook, isDialogShown: $isDialogShown, isLoadingAudiobook: $isLoadingAudiobook, statePosition: $statePosition, localPosition: $localPosition, currentlyPlayingPart: $currentlyPlayingPart, isPlaying: $isPlaying, isPreparingSession: $isPreparingSession, isPreparingPlaylist: $isPreparingPlaylist, isSettingsOpened: $isSettingsOpened, sleepTimer: $sleepTimer, speed: $speed, playToPart: $playToPart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioStateImpl &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.audiobook, audiobook) ||
                other.audiobook == audiobook) &&
            const DeepCollectionEquality()
                .equals(other.isDialogShown, isDialogShown) &&
            const DeepCollectionEquality()
                .equals(other.isLoadingAudiobook, isLoadingAudiobook) &&
            (identical(other.statePosition, statePosition) ||
                other.statePosition == statePosition) &&
            (identical(other.localPosition, localPosition) ||
                other.localPosition == localPosition) &&
            (identical(other.currentlyPlayingPart, currentlyPlayingPart) ||
                other.currentlyPlayingPart == currentlyPlayingPart) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isPreparingSession, isPreparingSession) ||
                other.isPreparingSession == isPreparingSession) &&
            (identical(other.isPreparingPlaylist, isPreparingPlaylist) ||
                other.isPreparingPlaylist == isPreparingPlaylist) &&
            (identical(other.isSettingsOpened, isSettingsOpened) ||
                other.isSettingsOpened == isSettingsOpened) &&
            (identical(other.sleepTimer, sleepTimer) ||
                other.sleepTimer == sleepTimer) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.playToPart, playToPart) ||
                other.playToPart == playToPart));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      book,
      audiobook,
      const DeepCollectionEquality().hash(isDialogShown),
      const DeepCollectionEquality().hash(isLoadingAudiobook),
      statePosition,
      localPosition,
      currentlyPlayingPart,
      isPlaying,
      isPreparingSession,
      isPreparingPlaylist,
      isSettingsOpened,
      sleepTimer,
      speed,
      playToPart);

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioStateImplCopyWith<_$AudioStateImpl> get copyWith =>
      __$$AudioStateImplCopyWithImpl<_$AudioStateImpl>(this, _$identity);
}

abstract class _AudioState implements AudioState {
  const factory _AudioState(
      {final BookModel? book,
      final AudiobookModel? audiobook,
      final dynamic isDialogShown,
      final dynamic isLoadingAudiobook,
      final int statePosition,
      final int? localPosition,
      final int currentlyPlayingPart,
      final bool isPlaying,
      final bool isPreparingSession,
      final bool isPreparingPlaylist,
      final bool isSettingsOpened,
      final int sleepTimer,
      final AudioPlayerSpeedEnum speed,
      final int playToPart}) = _$AudioStateImpl;

  @override
  BookModel? get book;
  @override
  AudiobookModel? get audiobook;
  @override
  dynamic get isDialogShown;
  @override
  dynamic get isLoadingAudiobook; // Player
  @override
  int get statePosition;
  @override
  int? get localPosition;
  @override
  int get currentlyPlayingPart;
  @override
  bool get isPlaying;
  @override
  bool get isPreparingSession;
  @override
  bool get isPreparingPlaylist; // Settings
  @override
  bool get isSettingsOpened;
  @override
  int get sleepTimer;
  @override
  AudioPlayerSpeedEnum get speed;
  @override
  int get playToPart;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioStateImplCopyWith<_$AudioStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
