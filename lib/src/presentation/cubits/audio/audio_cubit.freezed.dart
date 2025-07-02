// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioState {

 BookModel? get book; AudiobookModel? get audiobook; dynamic get isDialogShown; dynamic get isLoadingAudiobook;// Player
 int get statePosition; int? get localPosition; int get currentlyPlayingPart; bool get isPlaying; bool get isPreparingSession; bool get isPreparingPlaylist;// Settings
 bool get isSettingsOpened; bool get isBookmarksOpened; int get sleepTimer; AudioPlayerSpeedEnum get speed; int get playToPart;// Error
 bool get isError;// Progress
 ProgressModel? get progress;
/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioStateCopyWith<AudioState> get copyWith => _$AudioStateCopyWithImpl<AudioState>(this as AudioState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioState&&(identical(other.book, book) || other.book == book)&&(identical(other.audiobook, audiobook) || other.audiobook == audiobook)&&const DeepCollectionEquality().equals(other.isDialogShown, isDialogShown)&&const DeepCollectionEquality().equals(other.isLoadingAudiobook, isLoadingAudiobook)&&(identical(other.statePosition, statePosition) || other.statePosition == statePosition)&&(identical(other.localPosition, localPosition) || other.localPosition == localPosition)&&(identical(other.currentlyPlayingPart, currentlyPlayingPart) || other.currentlyPlayingPart == currentlyPlayingPart)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isPreparingSession, isPreparingSession) || other.isPreparingSession == isPreparingSession)&&(identical(other.isPreparingPlaylist, isPreparingPlaylist) || other.isPreparingPlaylist == isPreparingPlaylist)&&(identical(other.isSettingsOpened, isSettingsOpened) || other.isSettingsOpened == isSettingsOpened)&&(identical(other.isBookmarksOpened, isBookmarksOpened) || other.isBookmarksOpened == isBookmarksOpened)&&(identical(other.sleepTimer, sleepTimer) || other.sleepTimer == sleepTimer)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.playToPart, playToPart) || other.playToPart == playToPart)&&(identical(other.isError, isError) || other.isError == isError)&&const DeepCollectionEquality().equals(other.progress, progress));
}


@override
int get hashCode => Object.hash(runtimeType,book,audiobook,const DeepCollectionEquality().hash(isDialogShown),const DeepCollectionEquality().hash(isLoadingAudiobook),statePosition,localPosition,currentlyPlayingPart,isPlaying,isPreparingSession,isPreparingPlaylist,isSettingsOpened,isBookmarksOpened,sleepTimer,speed,playToPart,isError,const DeepCollectionEquality().hash(progress));

@override
String toString() {
  return 'AudioState(book: $book, audiobook: $audiobook, isDialogShown: $isDialogShown, isLoadingAudiobook: $isLoadingAudiobook, statePosition: $statePosition, localPosition: $localPosition, currentlyPlayingPart: $currentlyPlayingPart, isPlaying: $isPlaying, isPreparingSession: $isPreparingSession, isPreparingPlaylist: $isPreparingPlaylist, isSettingsOpened: $isSettingsOpened, isBookmarksOpened: $isBookmarksOpened, sleepTimer: $sleepTimer, speed: $speed, playToPart: $playToPart, isError: $isError, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $AudioStateCopyWith<$Res>  {
  factory $AudioStateCopyWith(AudioState value, $Res Function(AudioState) _then) = _$AudioStateCopyWithImpl;
@useResult
$Res call({
 BookModel? book, AudiobookModel? audiobook, dynamic isDialogShown, dynamic isLoadingAudiobook, int statePosition, int? localPosition, int currentlyPlayingPart, bool isPlaying, bool isPreparingSession, bool isPreparingPlaylist, bool isSettingsOpened, bool isBookmarksOpened, int sleepTimer, AudioPlayerSpeedEnum speed, int playToPart, bool isError, ProgressModel? progress
});


$BookModelCopyWith<$Res>? get book;$AudiobookModelCopyWith<$Res>? get audiobook;

}
/// @nodoc
class _$AudioStateCopyWithImpl<$Res>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._self, this._then);

  final AudioState _self;
  final $Res Function(AudioState) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = freezed,Object? audiobook = freezed,Object? isDialogShown = freezed,Object? isLoadingAudiobook = freezed,Object? statePosition = null,Object? localPosition = freezed,Object? currentlyPlayingPart = null,Object? isPlaying = null,Object? isPreparingSession = null,Object? isPreparingPlaylist = null,Object? isSettingsOpened = null,Object? isBookmarksOpened = null,Object? sleepTimer = null,Object? speed = null,Object? playToPart = null,Object? isError = null,Object? progress = freezed,}) {
  return _then(_self.copyWith(
book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel?,audiobook: freezed == audiobook ? _self.audiobook : audiobook // ignore: cast_nullable_to_non_nullable
as AudiobookModel?,isDialogShown: freezed == isDialogShown ? _self.isDialogShown : isDialogShown // ignore: cast_nullable_to_non_nullable
as dynamic,isLoadingAudiobook: freezed == isLoadingAudiobook ? _self.isLoadingAudiobook : isLoadingAudiobook // ignore: cast_nullable_to_non_nullable
as dynamic,statePosition: null == statePosition ? _self.statePosition : statePosition // ignore: cast_nullable_to_non_nullable
as int,localPosition: freezed == localPosition ? _self.localPosition : localPosition // ignore: cast_nullable_to_non_nullable
as int?,currentlyPlayingPart: null == currentlyPlayingPart ? _self.currentlyPlayingPart : currentlyPlayingPart // ignore: cast_nullable_to_non_nullable
as int,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isPreparingSession: null == isPreparingSession ? _self.isPreparingSession : isPreparingSession // ignore: cast_nullable_to_non_nullable
as bool,isPreparingPlaylist: null == isPreparingPlaylist ? _self.isPreparingPlaylist : isPreparingPlaylist // ignore: cast_nullable_to_non_nullable
as bool,isSettingsOpened: null == isSettingsOpened ? _self.isSettingsOpened : isSettingsOpened // ignore: cast_nullable_to_non_nullable
as bool,isBookmarksOpened: null == isBookmarksOpened ? _self.isBookmarksOpened : isBookmarksOpened // ignore: cast_nullable_to_non_nullable
as bool,sleepTimer: null == sleepTimer ? _self.sleepTimer : sleepTimer // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as AudioPlayerSpeedEnum,playToPart: null == playToPart ? _self.playToPart : playToPart // ignore: cast_nullable_to_non_nullable
as int,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel?,
  ));
}
/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res>? get book {
    if (_self.book == null) {
    return null;
  }

  return $BookModelCopyWith<$Res>(_self.book!, (value) {
    return _then(_self.copyWith(book: value));
  });
}/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookModelCopyWith<$Res>? get audiobook {
    if (_self.audiobook == null) {
    return null;
  }

  return $AudiobookModelCopyWith<$Res>(_self.audiobook!, (value) {
    return _then(_self.copyWith(audiobook: value));
  });
}
}


/// @nodoc


class _AudioState implements AudioState {
  const _AudioState({this.book, this.audiobook, this.isDialogShown = false, this.isLoadingAudiobook = false, this.statePosition = 0, this.localPosition, this.currentlyPlayingPart = 0, this.isPlaying = false, this.isPreparingSession = false, this.isPreparingPlaylist = false, this.isSettingsOpened = false, this.isBookmarksOpened = false, this.sleepTimer = 0, this.speed = AudioPlayerSpeedEnum.x1, this.playToPart = 0, this.isError = false, this.progress});
  

@override final  BookModel? book;
@override final  AudiobookModel? audiobook;
@override@JsonKey() final  dynamic isDialogShown;
@override@JsonKey() final  dynamic isLoadingAudiobook;
// Player
@override@JsonKey() final  int statePosition;
@override final  int? localPosition;
@override@JsonKey() final  int currentlyPlayingPart;
@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool isPreparingSession;
@override@JsonKey() final  bool isPreparingPlaylist;
// Settings
@override@JsonKey() final  bool isSettingsOpened;
@override@JsonKey() final  bool isBookmarksOpened;
@override@JsonKey() final  int sleepTimer;
@override@JsonKey() final  AudioPlayerSpeedEnum speed;
@override@JsonKey() final  int playToPart;
// Error
@override@JsonKey() final  bool isError;
// Progress
@override final  ProgressModel? progress;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioStateCopyWith<_AudioState> get copyWith => __$AudioStateCopyWithImpl<_AudioState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioState&&(identical(other.book, book) || other.book == book)&&(identical(other.audiobook, audiobook) || other.audiobook == audiobook)&&const DeepCollectionEquality().equals(other.isDialogShown, isDialogShown)&&const DeepCollectionEquality().equals(other.isLoadingAudiobook, isLoadingAudiobook)&&(identical(other.statePosition, statePosition) || other.statePosition == statePosition)&&(identical(other.localPosition, localPosition) || other.localPosition == localPosition)&&(identical(other.currentlyPlayingPart, currentlyPlayingPart) || other.currentlyPlayingPart == currentlyPlayingPart)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isPreparingSession, isPreparingSession) || other.isPreparingSession == isPreparingSession)&&(identical(other.isPreparingPlaylist, isPreparingPlaylist) || other.isPreparingPlaylist == isPreparingPlaylist)&&(identical(other.isSettingsOpened, isSettingsOpened) || other.isSettingsOpened == isSettingsOpened)&&(identical(other.isBookmarksOpened, isBookmarksOpened) || other.isBookmarksOpened == isBookmarksOpened)&&(identical(other.sleepTimer, sleepTimer) || other.sleepTimer == sleepTimer)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.playToPart, playToPart) || other.playToPart == playToPart)&&(identical(other.isError, isError) || other.isError == isError)&&const DeepCollectionEquality().equals(other.progress, progress));
}


@override
int get hashCode => Object.hash(runtimeType,book,audiobook,const DeepCollectionEquality().hash(isDialogShown),const DeepCollectionEquality().hash(isLoadingAudiobook),statePosition,localPosition,currentlyPlayingPart,isPlaying,isPreparingSession,isPreparingPlaylist,isSettingsOpened,isBookmarksOpened,sleepTimer,speed,playToPart,isError,const DeepCollectionEquality().hash(progress));

@override
String toString() {
  return 'AudioState(book: $book, audiobook: $audiobook, isDialogShown: $isDialogShown, isLoadingAudiobook: $isLoadingAudiobook, statePosition: $statePosition, localPosition: $localPosition, currentlyPlayingPart: $currentlyPlayingPart, isPlaying: $isPlaying, isPreparingSession: $isPreparingSession, isPreparingPlaylist: $isPreparingPlaylist, isSettingsOpened: $isSettingsOpened, isBookmarksOpened: $isBookmarksOpened, sleepTimer: $sleepTimer, speed: $speed, playToPart: $playToPart, isError: $isError, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$AudioStateCopyWith<$Res> implements $AudioStateCopyWith<$Res> {
  factory _$AudioStateCopyWith(_AudioState value, $Res Function(_AudioState) _then) = __$AudioStateCopyWithImpl;
@override @useResult
$Res call({
 BookModel? book, AudiobookModel? audiobook, dynamic isDialogShown, dynamic isLoadingAudiobook, int statePosition, int? localPosition, int currentlyPlayingPart, bool isPlaying, bool isPreparingSession, bool isPreparingPlaylist, bool isSettingsOpened, bool isBookmarksOpened, int sleepTimer, AudioPlayerSpeedEnum speed, int playToPart, bool isError, ProgressModel? progress
});


@override $BookModelCopyWith<$Res>? get book;@override $AudiobookModelCopyWith<$Res>? get audiobook;

}
/// @nodoc
class __$AudioStateCopyWithImpl<$Res>
    implements _$AudioStateCopyWith<$Res> {
  __$AudioStateCopyWithImpl(this._self, this._then);

  final _AudioState _self;
  final $Res Function(_AudioState) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = freezed,Object? audiobook = freezed,Object? isDialogShown = freezed,Object? isLoadingAudiobook = freezed,Object? statePosition = null,Object? localPosition = freezed,Object? currentlyPlayingPart = null,Object? isPlaying = null,Object? isPreparingSession = null,Object? isPreparingPlaylist = null,Object? isSettingsOpened = null,Object? isBookmarksOpened = null,Object? sleepTimer = null,Object? speed = null,Object? playToPart = null,Object? isError = null,Object? progress = freezed,}) {
  return _then(_AudioState(
book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel?,audiobook: freezed == audiobook ? _self.audiobook : audiobook // ignore: cast_nullable_to_non_nullable
as AudiobookModel?,isDialogShown: freezed == isDialogShown ? _self.isDialogShown : isDialogShown // ignore: cast_nullable_to_non_nullable
as dynamic,isLoadingAudiobook: freezed == isLoadingAudiobook ? _self.isLoadingAudiobook : isLoadingAudiobook // ignore: cast_nullable_to_non_nullable
as dynamic,statePosition: null == statePosition ? _self.statePosition : statePosition // ignore: cast_nullable_to_non_nullable
as int,localPosition: freezed == localPosition ? _self.localPosition : localPosition // ignore: cast_nullable_to_non_nullable
as int?,currentlyPlayingPart: null == currentlyPlayingPart ? _self.currentlyPlayingPart : currentlyPlayingPart // ignore: cast_nullable_to_non_nullable
as int,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isPreparingSession: null == isPreparingSession ? _self.isPreparingSession : isPreparingSession // ignore: cast_nullable_to_non_nullable
as bool,isPreparingPlaylist: null == isPreparingPlaylist ? _self.isPreparingPlaylist : isPreparingPlaylist // ignore: cast_nullable_to_non_nullable
as bool,isSettingsOpened: null == isSettingsOpened ? _self.isSettingsOpened : isSettingsOpened // ignore: cast_nullable_to_non_nullable
as bool,isBookmarksOpened: null == isBookmarksOpened ? _self.isBookmarksOpened : isBookmarksOpened // ignore: cast_nullable_to_non_nullable
as bool,sleepTimer: null == sleepTimer ? _self.sleepTimer : sleepTimer // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as AudioPlayerSpeedEnum,playToPart: null == playToPart ? _self.playToPart : playToPart // ignore: cast_nullable_to_non_nullable
as int,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel?,
  ));
}

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res>? get book {
    if (_self.book == null) {
    return null;
  }

  return $BookModelCopyWith<$Res>(_self.book!, (value) {
    return _then(_self.copyWith(book: value));
  });
}/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookModelCopyWith<$Res>? get audiobook {
    if (_self.audiobook == null) {
    return null;
  }

  return $AudiobookModelCopyWith<$Res>(_self.audiobook!, (value) {
    return _then(_self.copyWith(audiobook: value));
  });
}
}

// dart format on
