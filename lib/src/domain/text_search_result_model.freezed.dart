// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_search_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextSearchResultModel {

 BookModel get book; List<BookSnippetModel> get snippets;
/// Create a copy of TextSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextSearchResultModelCopyWith<TextSearchResultModel> get copyWith => _$TextSearchResultModelCopyWithImpl<TextSearchResultModel>(this as TextSearchResultModel, _$identity);

  /// Serializes this TextSearchResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextSearchResultModel&&(identical(other.book, book) || other.book == book)&&const DeepCollectionEquality().equals(other.snippets, snippets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,const DeepCollectionEquality().hash(snippets));

@override
String toString() {
  return 'TextSearchResultModel(book: $book, snippets: $snippets)';
}


}

/// @nodoc
abstract mixin class $TextSearchResultModelCopyWith<$Res>  {
  factory $TextSearchResultModelCopyWith(TextSearchResultModel value, $Res Function(TextSearchResultModel) _then) = _$TextSearchResultModelCopyWithImpl;
@useResult
$Res call({
 BookModel book, List<BookSnippetModel> snippets
});


$BookModelCopyWith<$Res> get book;

}
/// @nodoc
class _$TextSearchResultModelCopyWithImpl<$Res>
    implements $TextSearchResultModelCopyWith<$Res> {
  _$TextSearchResultModelCopyWithImpl(this._self, this._then);

  final TextSearchResultModel _self;
  final $Res Function(TextSearchResultModel) _then;

/// Create a copy of TextSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? snippets = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,snippets: null == snippets ? _self.snippets : snippets // ignore: cast_nullable_to_non_nullable
as List<BookSnippetModel>,
  ));
}
/// Create a copy of TextSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res> get book {
  
  return $BookModelCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _TextSearchResultModel implements TextSearchResultModel {
  const _TextSearchResultModel({required this.book, final  List<BookSnippetModel> snippets = const []}): _snippets = snippets;
  factory _TextSearchResultModel.fromJson(Map<String, dynamic> json) => _$TextSearchResultModelFromJson(json);

@override final  BookModel book;
 final  List<BookSnippetModel> _snippets;
@override@JsonKey() List<BookSnippetModel> get snippets {
  if (_snippets is EqualUnmodifiableListView) return _snippets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_snippets);
}


/// Create a copy of TextSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextSearchResultModelCopyWith<_TextSearchResultModel> get copyWith => __$TextSearchResultModelCopyWithImpl<_TextSearchResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextSearchResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextSearchResultModel&&(identical(other.book, book) || other.book == book)&&const DeepCollectionEquality().equals(other._snippets, _snippets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,const DeepCollectionEquality().hash(_snippets));

@override
String toString() {
  return 'TextSearchResultModel(book: $book, snippets: $snippets)';
}


}

/// @nodoc
abstract mixin class _$TextSearchResultModelCopyWith<$Res> implements $TextSearchResultModelCopyWith<$Res> {
  factory _$TextSearchResultModelCopyWith(_TextSearchResultModel value, $Res Function(_TextSearchResultModel) _then) = __$TextSearchResultModelCopyWithImpl;
@override @useResult
$Res call({
 BookModel book, List<BookSnippetModel> snippets
});


@override $BookModelCopyWith<$Res> get book;

}
/// @nodoc
class __$TextSearchResultModelCopyWithImpl<$Res>
    implements _$TextSearchResultModelCopyWith<$Res> {
  __$TextSearchResultModelCopyWithImpl(this._self, this._then);

  final _TextSearchResultModel _self;
  final $Res Function(_TextSearchResultModel) _then;

/// Create a copy of TextSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? snippets = null,}) {
  return _then(_TextSearchResultModel(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,snippets: null == snippets ? _self._snippets : snippets // ignore: cast_nullable_to_non_nullable
as List<BookSnippetModel>,
  ));
}

/// Create a copy of TextSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res> get book {
  
  return $BookModelCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// @nodoc
mixin _$BookSnippetModel {

 String get anchor; String get headline;
/// Create a copy of BookSnippetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookSnippetModelCopyWith<BookSnippetModel> get copyWith => _$BookSnippetModelCopyWithImpl<BookSnippetModel>(this as BookSnippetModel, _$identity);

  /// Serializes this BookSnippetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookSnippetModel&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.headline, headline) || other.headline == headline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,anchor,headline);

@override
String toString() {
  return 'BookSnippetModel(anchor: $anchor, headline: $headline)';
}


}

/// @nodoc
abstract mixin class $BookSnippetModelCopyWith<$Res>  {
  factory $BookSnippetModelCopyWith(BookSnippetModel value, $Res Function(BookSnippetModel) _then) = _$BookSnippetModelCopyWithImpl;
@useResult
$Res call({
 String anchor, String headline
});




}
/// @nodoc
class _$BookSnippetModelCopyWithImpl<$Res>
    implements $BookSnippetModelCopyWith<$Res> {
  _$BookSnippetModelCopyWithImpl(this._self, this._then);

  final BookSnippetModel _self;
  final $Res Function(BookSnippetModel) _then;

/// Create a copy of BookSnippetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? anchor = null,Object? headline = null,}) {
  return _then(_self.copyWith(
anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookSnippetModel implements BookSnippetModel {
  const _BookSnippetModel({required this.anchor, required this.headline});
  factory _BookSnippetModel.fromJson(Map<String, dynamic> json) => _$BookSnippetModelFromJson(json);

@override final  String anchor;
@override final  String headline;

/// Create a copy of BookSnippetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookSnippetModelCopyWith<_BookSnippetModel> get copyWith => __$BookSnippetModelCopyWithImpl<_BookSnippetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookSnippetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookSnippetModel&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.headline, headline) || other.headline == headline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,anchor,headline);

@override
String toString() {
  return 'BookSnippetModel(anchor: $anchor, headline: $headline)';
}


}

/// @nodoc
abstract mixin class _$BookSnippetModelCopyWith<$Res> implements $BookSnippetModelCopyWith<$Res> {
  factory _$BookSnippetModelCopyWith(_BookSnippetModel value, $Res Function(_BookSnippetModel) _then) = __$BookSnippetModelCopyWithImpl;
@override @useResult
$Res call({
 String anchor, String headline
});




}
/// @nodoc
class __$BookSnippetModelCopyWithImpl<$Res>
    implements _$BookSnippetModelCopyWith<$Res> {
  __$BookSnippetModelCopyWithImpl(this._self, this._then);

  final _BookSnippetModel _self;
  final $Res Function(_BookSnippetModel) _then;

/// Create a copy of BookSnippetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? anchor = null,Object? headline = null,}) {
  return _then(_BookSnippetModel(
anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
