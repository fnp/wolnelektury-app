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

 String? get currentSlug; double get textSizeFactor; ReaderFontType get fontType; bool get isJsonLoading; ReaderBookModel? get book;// ParagraphSheet
 int? get selectedIndex; ReaderBookModelContent? get selectedParagraph; bool get isAddingBookmark;// Progress
 TextProgressModel? get progress;
/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingPageStateCopyWith<ReadingPageState> get copyWith => _$ReadingPageStateCopyWithImpl<ReadingPageState>(this as ReadingPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingPageState&&(identical(other.currentSlug, currentSlug) || other.currentSlug == currentSlug)&&(identical(other.textSizeFactor, textSizeFactor) || other.textSizeFactor == textSizeFactor)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.isJsonLoading, isJsonLoading) || other.isJsonLoading == isJsonLoading)&&(identical(other.book, book) || other.book == book)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.selectedParagraph, selectedParagraph) || other.selectedParagraph == selectedParagraph)&&(identical(other.isAddingBookmark, isAddingBookmark) || other.isAddingBookmark == isAddingBookmark)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,currentSlug,textSizeFactor,fontType,isJsonLoading,book,selectedIndex,selectedParagraph,isAddingBookmark,progress);

@override
String toString() {
  return 'ReadingPageState(currentSlug: $currentSlug, textSizeFactor: $textSizeFactor, fontType: $fontType, isJsonLoading: $isJsonLoading, book: $book, selectedIndex: $selectedIndex, selectedParagraph: $selectedParagraph, isAddingBookmark: $isAddingBookmark, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $ReadingPageStateCopyWith<$Res>  {
  factory $ReadingPageStateCopyWith(ReadingPageState value, $Res Function(ReadingPageState) _then) = _$ReadingPageStateCopyWithImpl;
@useResult
$Res call({
 String? currentSlug, double textSizeFactor, ReaderFontType fontType, bool isJsonLoading, ReaderBookModel? book, int? selectedIndex, ReaderBookModelContent? selectedParagraph, bool isAddingBookmark, TextProgressModel? progress
});


$TextProgressModelCopyWith<$Res>? get progress;

}
/// @nodoc
class _$ReadingPageStateCopyWithImpl<$Res>
    implements $ReadingPageStateCopyWith<$Res> {
  _$ReadingPageStateCopyWithImpl(this._self, this._then);

  final ReadingPageState _self;
  final $Res Function(ReadingPageState) _then;

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentSlug = freezed,Object? textSizeFactor = null,Object? fontType = null,Object? isJsonLoading = null,Object? book = freezed,Object? selectedIndex = freezed,Object? selectedParagraph = freezed,Object? isAddingBookmark = null,Object? progress = freezed,}) {
  return _then(_self.copyWith(
currentSlug: freezed == currentSlug ? _self.currentSlug : currentSlug // ignore: cast_nullable_to_non_nullable
as String?,textSizeFactor: null == textSizeFactor ? _self.textSizeFactor : textSizeFactor // ignore: cast_nullable_to_non_nullable
as double,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as ReaderFontType,isJsonLoading: null == isJsonLoading ? _self.isJsonLoading : isJsonLoading // ignore: cast_nullable_to_non_nullable
as bool,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as ReaderBookModel?,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedParagraph: freezed == selectedParagraph ? _self.selectedParagraph : selectedParagraph // ignore: cast_nullable_to_non_nullable
as ReaderBookModelContent?,isAddingBookmark: null == isAddingBookmark ? _self.isAddingBookmark : isAddingBookmark // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as TextProgressModel?,
  ));
}
/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextProgressModelCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $TextProgressModelCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// @nodoc


class _ReadingPageState implements ReadingPageState {
  const _ReadingPageState({this.currentSlug, this.textSizeFactor = 0.5, this.fontType = ReaderFontType.sans, this.isJsonLoading = false, this.book, this.selectedIndex, this.selectedParagraph, this.isAddingBookmark = false, this.progress});
  

@override final  String? currentSlug;
@override@JsonKey() final  double textSizeFactor;
@override@JsonKey() final  ReaderFontType fontType;
@override@JsonKey() final  bool isJsonLoading;
@override final  ReaderBookModel? book;
// ParagraphSheet
@override final  int? selectedIndex;
@override final  ReaderBookModelContent? selectedParagraph;
@override@JsonKey() final  bool isAddingBookmark;
// Progress
@override final  TextProgressModel? progress;

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingPageStateCopyWith<_ReadingPageState> get copyWith => __$ReadingPageStateCopyWithImpl<_ReadingPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingPageState&&(identical(other.currentSlug, currentSlug) || other.currentSlug == currentSlug)&&(identical(other.textSizeFactor, textSizeFactor) || other.textSizeFactor == textSizeFactor)&&(identical(other.fontType, fontType) || other.fontType == fontType)&&(identical(other.isJsonLoading, isJsonLoading) || other.isJsonLoading == isJsonLoading)&&(identical(other.book, book) || other.book == book)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.selectedParagraph, selectedParagraph) || other.selectedParagraph == selectedParagraph)&&(identical(other.isAddingBookmark, isAddingBookmark) || other.isAddingBookmark == isAddingBookmark)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,currentSlug,textSizeFactor,fontType,isJsonLoading,book,selectedIndex,selectedParagraph,isAddingBookmark,progress);

@override
String toString() {
  return 'ReadingPageState(currentSlug: $currentSlug, textSizeFactor: $textSizeFactor, fontType: $fontType, isJsonLoading: $isJsonLoading, book: $book, selectedIndex: $selectedIndex, selectedParagraph: $selectedParagraph, isAddingBookmark: $isAddingBookmark, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$ReadingPageStateCopyWith<$Res> implements $ReadingPageStateCopyWith<$Res> {
  factory _$ReadingPageStateCopyWith(_ReadingPageState value, $Res Function(_ReadingPageState) _then) = __$ReadingPageStateCopyWithImpl;
@override @useResult
$Res call({
 String? currentSlug, double textSizeFactor, ReaderFontType fontType, bool isJsonLoading, ReaderBookModel? book, int? selectedIndex, ReaderBookModelContent? selectedParagraph, bool isAddingBookmark, TextProgressModel? progress
});


@override $TextProgressModelCopyWith<$Res>? get progress;

}
/// @nodoc
class __$ReadingPageStateCopyWithImpl<$Res>
    implements _$ReadingPageStateCopyWith<$Res> {
  __$ReadingPageStateCopyWithImpl(this._self, this._then);

  final _ReadingPageState _self;
  final $Res Function(_ReadingPageState) _then;

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentSlug = freezed,Object? textSizeFactor = null,Object? fontType = null,Object? isJsonLoading = null,Object? book = freezed,Object? selectedIndex = freezed,Object? selectedParagraph = freezed,Object? isAddingBookmark = null,Object? progress = freezed,}) {
  return _then(_ReadingPageState(
currentSlug: freezed == currentSlug ? _self.currentSlug : currentSlug // ignore: cast_nullable_to_non_nullable
as String?,textSizeFactor: null == textSizeFactor ? _self.textSizeFactor : textSizeFactor // ignore: cast_nullable_to_non_nullable
as double,fontType: null == fontType ? _self.fontType : fontType // ignore: cast_nullable_to_non_nullable
as ReaderFontType,isJsonLoading: null == isJsonLoading ? _self.isJsonLoading : isJsonLoading // ignore: cast_nullable_to_non_nullable
as bool,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as ReaderBookModel?,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedParagraph: freezed == selectedParagraph ? _self.selectedParagraph : selectedParagraph // ignore: cast_nullable_to_non_nullable
as ReaderBookModelContent?,isAddingBookmark: null == isAddingBookmark ? _self.isAddingBookmark : isAddingBookmark // ignore: cast_nullable_to_non_nullable
as bool,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as TextProgressModel?,
  ));
}

/// Create a copy of ReadingPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextProgressModelCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $TextProgressModelCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
