// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteModel {

 String? get uuid; String get text; BookModel get book;@JsonKey(name: 'book_slug') String? get bookSlug;@JsonKey(name: 'start_elem') String? get startElem;@JsonKey(name: 'end_elem') String? get endElem;@JsonKey(name: 'start_offset') int? get startOffset;@JsonKey(name: 'end_offset') int? get endOffset; String get href;// These fields are optional and used for syncing purposes.
 int? get timestamp; bool get deleted;
/// Create a copy of QuoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteModelCopyWith<QuoteModel> get copyWith => _$QuoteModelCopyWithImpl<QuoteModel>(this as QuoteModel, _$identity);

  /// Serializes this QuoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.text, text) || other.text == text)&&(identical(other.book, book) || other.book == book)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.startElem, startElem) || other.startElem == startElem)&&(identical(other.endElem, endElem) || other.endElem == endElem)&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&(identical(other.href, href) || other.href == href)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,text,book,bookSlug,startElem,endElem,startOffset,endOffset,href,timestamp,deleted);

@override
String toString() {
  return 'QuoteModel(uuid: $uuid, text: $text, book: $book, bookSlug: $bookSlug, startElem: $startElem, endElem: $endElem, startOffset: $startOffset, endOffset: $endOffset, href: $href, timestamp: $timestamp, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $QuoteModelCopyWith<$Res>  {
  factory $QuoteModelCopyWith(QuoteModel value, $Res Function(QuoteModel) _then) = _$QuoteModelCopyWithImpl;
@useResult
$Res call({
 String? uuid, String text, BookModel book,@JsonKey(name: 'book_slug') String? bookSlug,@JsonKey(name: 'start_elem') String? startElem,@JsonKey(name: 'end_elem') String? endElem,@JsonKey(name: 'start_offset') int? startOffset,@JsonKey(name: 'end_offset') int? endOffset, String href, int? timestamp, bool deleted
});


$BookModelCopyWith<$Res> get book;

}
/// @nodoc
class _$QuoteModelCopyWithImpl<$Res>
    implements $QuoteModelCopyWith<$Res> {
  _$QuoteModelCopyWithImpl(this._self, this._then);

  final QuoteModel _self;
  final $Res Function(QuoteModel) _then;

/// Create a copy of QuoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? text = null,Object? book = null,Object? bookSlug = freezed,Object? startElem = freezed,Object? endElem = freezed,Object? startOffset = freezed,Object? endOffset = freezed,Object? href = null,Object? timestamp = freezed,Object? deleted = null,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,bookSlug: freezed == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String?,startElem: freezed == startElem ? _self.startElem : startElem // ignore: cast_nullable_to_non_nullable
as String?,endElem: freezed == endElem ? _self.endElem : endElem // ignore: cast_nullable_to_non_nullable
as String?,startOffset: freezed == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int?,endOffset: freezed == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int?,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QuoteModel
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

class _QuoteModel implements QuoteModel {
  const _QuoteModel({this.uuid, this.text = '', required this.book, @JsonKey(name: 'book_slug') this.bookSlug, @JsonKey(name: 'start_elem') this.startElem, @JsonKey(name: 'end_elem') this.endElem, @JsonKey(name: 'start_offset') this.startOffset, @JsonKey(name: 'end_offset') this.endOffset, required this.href, this.timestamp, this.deleted = false});
  factory _QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);

@override final  String? uuid;
@override@JsonKey() final  String text;
@override final  BookModel book;
@override@JsonKey(name: 'book_slug') final  String? bookSlug;
@override@JsonKey(name: 'start_elem') final  String? startElem;
@override@JsonKey(name: 'end_elem') final  String? endElem;
@override@JsonKey(name: 'start_offset') final  int? startOffset;
@override@JsonKey(name: 'end_offset') final  int? endOffset;
@override final  String href;
// These fields are optional and used for syncing purposes.
@override final  int? timestamp;
@override@JsonKey() final  bool deleted;

/// Create a copy of QuoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteModelCopyWith<_QuoteModel> get copyWith => __$QuoteModelCopyWithImpl<_QuoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.text, text) || other.text == text)&&(identical(other.book, book) || other.book == book)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.startElem, startElem) || other.startElem == startElem)&&(identical(other.endElem, endElem) || other.endElem == endElem)&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&(identical(other.href, href) || other.href == href)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,text,book,bookSlug,startElem,endElem,startOffset,endOffset,href,timestamp,deleted);

@override
String toString() {
  return 'QuoteModel(uuid: $uuid, text: $text, book: $book, bookSlug: $bookSlug, startElem: $startElem, endElem: $endElem, startOffset: $startOffset, endOffset: $endOffset, href: $href, timestamp: $timestamp, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$QuoteModelCopyWith<$Res> implements $QuoteModelCopyWith<$Res> {
  factory _$QuoteModelCopyWith(_QuoteModel value, $Res Function(_QuoteModel) _then) = __$QuoteModelCopyWithImpl;
@override @useResult
$Res call({
 String? uuid, String text, BookModel book,@JsonKey(name: 'book_slug') String? bookSlug,@JsonKey(name: 'start_elem') String? startElem,@JsonKey(name: 'end_elem') String? endElem,@JsonKey(name: 'start_offset') int? startOffset,@JsonKey(name: 'end_offset') int? endOffset, String href, int? timestamp, bool deleted
});


@override $BookModelCopyWith<$Res> get book;

}
/// @nodoc
class __$QuoteModelCopyWithImpl<$Res>
    implements _$QuoteModelCopyWith<$Res> {
  __$QuoteModelCopyWithImpl(this._self, this._then);

  final _QuoteModel _self;
  final $Res Function(_QuoteModel) _then;

/// Create a copy of QuoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? text = null,Object? book = null,Object? bookSlug = freezed,Object? startElem = freezed,Object? endElem = freezed,Object? startOffset = freezed,Object? endOffset = freezed,Object? href = null,Object? timestamp = freezed,Object? deleted = null,}) {
  return _then(_QuoteModel(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,bookSlug: freezed == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String?,startElem: freezed == startElem ? _self.startElem : startElem // ignore: cast_nullable_to_non_nullable
as String?,endElem: freezed == endElem ? _self.endElem : endElem // ignore: cast_nullable_to_non_nullable
as String?,startOffset: freezed == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int?,endOffset: freezed == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int?,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QuoteModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res> get book {
  
  return $BookModelCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}

// dart format on
