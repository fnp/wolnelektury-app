// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReadingPageState {

 BookModel? get currentBook; ReaderBookModel? get readerBook; double get textSizeFactor; ReaderFontType get fontType; double get fontHeightMultiplier; bool get isJsonLoading; bool get isJsonLoadingError;// Audio sync pairs
 List<BookTextAudioSyncModel> get audioSyncPairs;// ParagraphSheet
 int? get selectedIndex; int? get highlightedIndex; bool get isEnabledHighlighting; ReaderBookModelContent? get selectedParagraph; bool get isAddingBookmark;// Progress
 ProgressModel? get progress;// Visual progress in %
 int get readTimeInSeconds; int get visualProgress; bool get isVisualProgressIncreasing;
/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingPageStateCopyWith<ReadingPageState> get copyWith => _$ReadingPageStateCopyWithImpl<ReadingPageState>(this as ReadingPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingPageState&&(identical(other.currentBook, currentBook) || other.currentBook == currentBook)&&(identical(other.readerBook, readerBook) || other.readerBook == readerBook)&&(identical(other.textSizeFactor, textSizeFactor) || other.textSizeFactor == textSizeFactor)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.fontHeightMultiplier, fontHeightMultiplier) || other.fontHeightMultiplier == fontHeightMultiplier)&&(identical(other.isJsonLoading, isJsonLoading) || other.isJsonLoading == isJsonLoading)&&(identical(other.isJsonLoadingError, isJsonLoadingError) || other.isJsonLoadingError == isJsonLoadingError)&&const DeepCollectionEquality().equals(other.audioSyncPairs, audioSyncPairs)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.highlightedIndex, highlightedIndex) || other.highlightedIndex == highlightedIndex)&&(identical(other.isEnabledHighlighting, isEnabledHighlighting) || other.isEnabledHighlighting == isEnabledHighlighting)&&(identical(other.selectedParagraph, selectedParagraph) || other.selectedParagraph == selectedParagraph)&&(identical(other.isAddingBookmark, isAddingBookmark) || other.isAddingBookmark == isAddingBookmark)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.readTimeInSeconds, readTimeInSeconds) || other.readTimeInSeconds == readTimeInSeconds)&&(identical(other.visualProgress, visualProgress) || other.visualProgress == visualProgress)&&(identical(other.isVisualProgressIncreasing, isVisualProgressIncreasing) || other.isVisualProgressIncreasing == isVisualProgressIncreasing));
}


@override
int get hashCode => Object.hash(runtimeType,currentBook,readerBook,textSizeFactor,fontType,fontHeightMultiplier,isJsonLoading,isJsonLoadingError,const DeepCollectionEquality().hash(audioSyncPairs),selectedIndex,highlightedIndex,isEnabledHighlighting,selectedParagraph,isAddingBookmark,progress,readTimeInSeconds,visualProgress,isVisualProgressIncreasing);

@override
String toString() {
  return 'ReadingPageState(currentBook: $currentBook, readerBook: $readerBook, textSizeFactor: $textSizeFactor, fontType: $fontType, fontHeightMultiplier: $fontHeightMultiplier, isJsonLoading: $isJsonLoading, isJsonLoadingError: $isJsonLoadingError, audioSyncPairs: $audioSyncPairs, selectedIndex: $selectedIndex, highlightedIndex: $highlightedIndex, isEnabledHighlighting: $isEnabledHighlighting, selectedParagraph: $selectedParagraph, isAddingBookmark: $isAddingBookmark, progress: $progress, readTimeInSeconds: $readTimeInSeconds, visualProgress: $visualProgress, isVisualProgressIncreasing: $isVisualProgressIncreasing)';
}


}

/// @nodoc
abstract mixin class $ReadingPageStateCopyWith<$Res>  {
  factory $ReadingPageStateCopyWith(ReadingPageState value, $Res Function(ReadingPageState) _then) = _$ReadingPageStateCopyWithImpl;
@useResult
$Res call({
 BookModel? currentBook, ReaderBookModel? readerBook, double textSizeFactor, ReaderFontType fontType, double fontHeightMultiplier, bool isJsonLoading, bool isJsonLoadingError, List<BookTextAudioSyncModel> audioSyncPairs, int? selectedIndex, int? highlightedIndex, bool isEnabledHighlighting, ReaderBookModelContent? selectedParagraph, bool isAddingBookmark, ProgressModel? progress, int readTimeInSeconds, int visualProgress, bool isVisualProgressIncreasing
});


$BookModelCopyWith<$Res>? get currentBook;$ProgressModelCopyWith<$Res>? get progress;

}
/// @nodoc
class _$ReadingPageStateCopyWithImpl<$Res>
    implements $ReadingPageStateCopyWith<$Res> {
  _$ReadingPageStateCopyWithImpl(this._self, this._then);

  final ReadingPageState _self;
  final $Res Function(ReadingPageState) _then;

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentBook = freezed,Object? readerBook = freezed,Object? textSizeFactor = null,Object? fontType = null,Object? fontHeightMultiplier = null,Object? isJsonLoading = null,Object? isJsonLoadingError = null,Object? audioSyncPairs = null,Object? selectedIndex = freezed,Object? highlightedIndex = freezed,Object? isEnabledHighlighting = null,Object? selectedParagraph = freezed,Object? isAddingBookmark = null,Object? progress = freezed,Object? readTimeInSeconds = null,Object? visualProgress = null,Object? isVisualProgressIncreasing = null,}) {
  return _then(_self.copyWith(
currentBook: freezed == currentBook ? _self.currentBook : currentBook // ignore: cast_nullable_to_non_nullable
as BookModel?,readerBook: freezed == readerBook ? _self.readerBook : readerBook // ignore: cast_nullable_to_non_nullable
as ReaderBookModel?,textSizeFactor: null == textSizeFactor ? _self.textSizeFactor : textSizeFactor // ignore: cast_nullable_to_non_nullable
as double,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as ReaderFontType,fontHeightMultiplier: null == fontHeightMultiplier ? _self.fontHeightMultiplier : fontHeightMultiplier // ignore: cast_nullable_to_non_nullable
as double,isJsonLoading: null == isJsonLoading ? _self.isJsonLoading : isJsonLoading // ignore: cast_nullable_to_non_nullable
as bool,isJsonLoadingError: null == isJsonLoadingError ? _self.isJsonLoadingError : isJsonLoadingError // ignore: cast_nullable_to_non_nullable
as bool,audioSyncPairs: null == audioSyncPairs ? _self.audioSyncPairs : audioSyncPairs // ignore: cast_nullable_to_non_nullable
as List<BookTextAudioSyncModel>,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,highlightedIndex: freezed == highlightedIndex ? _self.highlightedIndex : highlightedIndex // ignore: cast_nullable_to_non_nullable
as int?,isEnabledHighlighting: null == isEnabledHighlighting ? _self.isEnabledHighlighting : isEnabledHighlighting // ignore: cast_nullable_to_non_nullable
as bool,selectedParagraph: freezed == selectedParagraph ? _self.selectedParagraph : selectedParagraph // ignore: cast_nullable_to_non_nullable
as ReaderBookModelContent?,isAddingBookmark: null == isAddingBookmark ? _self.isAddingBookmark : isAddingBookmark // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel?,readTimeInSeconds: null == readTimeInSeconds ? _self.readTimeInSeconds : readTimeInSeconds // ignore: cast_nullable_to_non_nullable
as int,visualProgress: null == visualProgress ? _self.visualProgress : visualProgress // ignore: cast_nullable_to_non_nullable
as int,isVisualProgressIncreasing: null == isVisualProgressIncreasing ? _self.isVisualProgressIncreasing : isVisualProgressIncreasing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res>? get currentBook {
    if (_self.currentBook == null) {
    return null;
  }

  return $BookModelCopyWith<$Res>(_self.currentBook!, (value) {
    return _then(_self.copyWith(currentBook: value));
  });
}/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $ProgressModelCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// @nodoc


class _ReadingPageState implements ReadingPageState {
  const _ReadingPageState({this.currentBook, this.readerBook, this.textSizeFactor = 0.5, this.fontType = ReaderFontType.sans, this.fontHeightMultiplier = 0, this.isJsonLoading = false, this.isJsonLoadingError = false, final  List<BookTextAudioSyncModel> audioSyncPairs = const [], this.selectedIndex, this.highlightedIndex, this.isEnabledHighlighting = false, this.selectedParagraph, this.isAddingBookmark = false, this.progress, this.readTimeInSeconds = 0, this.visualProgress = 0, this.isVisualProgressIncreasing = false}): _audioSyncPairs = audioSyncPairs;
  

@override final  BookModel? currentBook;
@override final  ReaderBookModel? readerBook;
@override@JsonKey() final  double textSizeFactor;
@override@JsonKey() final  ReaderFontType fontType;
@override@JsonKey() final  double fontHeightMultiplier;
@override@JsonKey() final  bool isJsonLoading;
@override@JsonKey() final  bool isJsonLoadingError;
// Audio sync pairs
 final  List<BookTextAudioSyncModel> _audioSyncPairs;
// Audio sync pairs
@override@JsonKey() List<BookTextAudioSyncModel> get audioSyncPairs {
  if (_audioSyncPairs is EqualUnmodifiableListView) return _audioSyncPairs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audioSyncPairs);
}

// ParagraphSheet
@override final  int? selectedIndex;
@override final  int? highlightedIndex;
@override@JsonKey() final  bool isEnabledHighlighting;
@override final  ReaderBookModelContent? selectedParagraph;
@override@JsonKey() final  bool isAddingBookmark;
// Progress
@override final  ProgressModel? progress;
// Visual progress in %
@override@JsonKey() final  int readTimeInSeconds;
@override@JsonKey() final  int visualProgress;
@override@JsonKey() final  bool isVisualProgressIncreasing;

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingPageStateCopyWith<_ReadingPageState> get copyWith => __$ReadingPageStateCopyWithImpl<_ReadingPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingPageState&&(identical(other.currentBook, currentBook) || other.currentBook == currentBook)&&(identical(other.readerBook, readerBook) || other.readerBook == readerBook)&&(identical(other.textSizeFactor, textSizeFactor) || other.textSizeFactor == textSizeFactor)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.fontHeightMultiplier, fontHeightMultiplier) || other.fontHeightMultiplier == fontHeightMultiplier)&&(identical(other.isJsonLoading, isJsonLoading) || other.isJsonLoading == isJsonLoading)&&(identical(other.isJsonLoadingError, isJsonLoadingError) || other.isJsonLoadingError == isJsonLoadingError)&&const DeepCollectionEquality().equals(other._audioSyncPairs, _audioSyncPairs)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.highlightedIndex, highlightedIndex) || other.highlightedIndex == highlightedIndex)&&(identical(other.isEnabledHighlighting, isEnabledHighlighting) || other.isEnabledHighlighting == isEnabledHighlighting)&&(identical(other.selectedParagraph, selectedParagraph) || other.selectedParagraph == selectedParagraph)&&(identical(other.isAddingBookmark, isAddingBookmark) || other.isAddingBookmark == isAddingBookmark)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.readTimeInSeconds, readTimeInSeconds) || other.readTimeInSeconds == readTimeInSeconds)&&(identical(other.visualProgress, visualProgress) || other.visualProgress == visualProgress)&&(identical(other.isVisualProgressIncreasing, isVisualProgressIncreasing) || other.isVisualProgressIncreasing == isVisualProgressIncreasing));
}


@override
int get hashCode => Object.hash(runtimeType,currentBook,readerBook,textSizeFactor,fontType,fontHeightMultiplier,isJsonLoading,isJsonLoadingError,const DeepCollectionEquality().hash(_audioSyncPairs),selectedIndex,highlightedIndex,isEnabledHighlighting,selectedParagraph,isAddingBookmark,progress,readTimeInSeconds,visualProgress,isVisualProgressIncreasing);

@override
String toString() {
  return 'ReadingPageState(currentBook: $currentBook, readerBook: $readerBook, textSizeFactor: $textSizeFactor, fontType: $fontType, fontHeightMultiplier: $fontHeightMultiplier, isJsonLoading: $isJsonLoading, isJsonLoadingError: $isJsonLoadingError, audioSyncPairs: $audioSyncPairs, selectedIndex: $selectedIndex, highlightedIndex: $highlightedIndex, isEnabledHighlighting: $isEnabledHighlighting, selectedParagraph: $selectedParagraph, isAddingBookmark: $isAddingBookmark, progress: $progress, readTimeInSeconds: $readTimeInSeconds, visualProgress: $visualProgress, isVisualProgressIncreasing: $isVisualProgressIncreasing)';
}


}

/// @nodoc
abstract mixin class _$ReadingPageStateCopyWith<$Res> implements $ReadingPageStateCopyWith<$Res> {
  factory _$ReadingPageStateCopyWith(_ReadingPageState value, $Res Function(_ReadingPageState) _then) = __$ReadingPageStateCopyWithImpl;
@override @useResult
$Res call({
 BookModel? currentBook, ReaderBookModel? readerBook, double textSizeFactor, ReaderFontType fontType, double fontHeightMultiplier, bool isJsonLoading, bool isJsonLoadingError, List<BookTextAudioSyncModel> audioSyncPairs, int? selectedIndex, int? highlightedIndex, bool isEnabledHighlighting, ReaderBookModelContent? selectedParagraph, bool isAddingBookmark, ProgressModel? progress, int readTimeInSeconds, int visualProgress, bool isVisualProgressIncreasing
});


@override $BookModelCopyWith<$Res>? get currentBook;@override $ProgressModelCopyWith<$Res>? get progress;

}
/// @nodoc
class __$ReadingPageStateCopyWithImpl<$Res>
    implements _$ReadingPageStateCopyWith<$Res> {
  __$ReadingPageStateCopyWithImpl(this._self, this._then);

  final _ReadingPageState _self;
  final $Res Function(_ReadingPageState) _then;

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentBook = freezed,Object? readerBook = freezed,Object? textSizeFactor = null,Object? fontType = null,Object? fontHeightMultiplier = null,Object? isJsonLoading = null,Object? isJsonLoadingError = null,Object? audioSyncPairs = null,Object? selectedIndex = freezed,Object? highlightedIndex = freezed,Object? isEnabledHighlighting = null,Object? selectedParagraph = freezed,Object? isAddingBookmark = null,Object? progress = freezed,Object? readTimeInSeconds = null,Object? visualProgress = null,Object? isVisualProgressIncreasing = null,}) {
  return _then(_ReadingPageState(
currentBook: freezed == currentBook ? _self.currentBook : currentBook // ignore: cast_nullable_to_non_nullable
as BookModel?,readerBook: freezed == readerBook ? _self.readerBook : readerBook // ignore: cast_nullable_to_non_nullable
as ReaderBookModel?,textSizeFactor: null == textSizeFactor ? _self.textSizeFactor : textSizeFactor // ignore: cast_nullable_to_non_nullable
as double,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as ReaderFontType,fontHeightMultiplier: null == fontHeightMultiplier ? _self.fontHeightMultiplier : fontHeightMultiplier // ignore: cast_nullable_to_non_nullable
as double,isJsonLoading: null == isJsonLoading ? _self.isJsonLoading : isJsonLoading // ignore: cast_nullable_to_non_nullable
as bool,isJsonLoadingError: null == isJsonLoadingError ? _self.isJsonLoadingError : isJsonLoadingError // ignore: cast_nullable_to_non_nullable
as bool,audioSyncPairs: null == audioSyncPairs ? _self._audioSyncPairs : audioSyncPairs // ignore: cast_nullable_to_non_nullable
as List<BookTextAudioSyncModel>,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,highlightedIndex: freezed == highlightedIndex ? _self.highlightedIndex : highlightedIndex // ignore: cast_nullable_to_non_nullable
as int?,isEnabledHighlighting: null == isEnabledHighlighting ? _self.isEnabledHighlighting : isEnabledHighlighting // ignore: cast_nullable_to_non_nullable
as bool,selectedParagraph: freezed == selectedParagraph ? _self.selectedParagraph : selectedParagraph // ignore: cast_nullable_to_non_nullable
as ReaderBookModelContent?,isAddingBookmark: null == isAddingBookmark ? _self.isAddingBookmark : isAddingBookmark // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ProgressModel?,readTimeInSeconds: null == readTimeInSeconds ? _self.readTimeInSeconds : readTimeInSeconds // ignore: cast_nullable_to_non_nullable
as int,visualProgress: null == visualProgress ? _self.visualProgress : visualProgress // ignore: cast_nullable_to_non_nullable
as int,isVisualProgressIncreasing: null == isVisualProgressIncreasing ? _self.isVisualProgressIncreasing : isVisualProgressIncreasing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res>? get currentBook {
    if (_self.currentBook == null) {
    return null;
  }

  return $BookModelCopyWith<$Res>(_self.currentBook!, (value) {
    return _then(_self.copyWith(currentBook: value));
  });
}/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $ProgressModelCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
