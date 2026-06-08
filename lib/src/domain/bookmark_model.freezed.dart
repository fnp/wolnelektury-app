// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookmarkModel {

 String? get uuid; String get location; BookModel get book;@JsonKey(name: 'book_slug') String? get bookSlug;@JsonKey(name: 'audio_timestamp') int? get audioTimestamp; String? get anchor; String get note; String get href;// This field is optional and used for syncing purposes.
 int? get timestamp; bool get isDeleted;
/// Create a copy of BookmarkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookmarkModelCopyWith<BookmarkModel> get copyWith => _$BookmarkModelCopyWithImpl<BookmarkModel>(this as BookmarkModel, _$identity);

  /// Serializes this BookmarkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarkModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.location, location) || other.location == location)&&(identical(other.book, book) || other.book == book)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.note, note) || other.note == note)&&(identical(other.href, href) || other.href == href)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,location,book,bookSlug,audioTimestamp,anchor,note,href,timestamp,isDeleted);

@override
String toString() {
  return 'BookmarkModel(uuid: $uuid, location: $location, book: $book, bookSlug: $bookSlug, audioTimestamp: $audioTimestamp, anchor: $anchor, note: $note, href: $href, timestamp: $timestamp, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $BookmarkModelCopyWith<$Res>  {
  factory $BookmarkModelCopyWith(BookmarkModel value, $Res Function(BookmarkModel) _then) = _$BookmarkModelCopyWithImpl;
@useResult
$Res call({
 String? uuid, String location, BookModel book,@JsonKey(name: 'book_slug') String? bookSlug,@JsonKey(name: 'audio_timestamp') int? audioTimestamp, String? anchor, String note, String href, int? timestamp, bool isDeleted
});


$BookModelCopyWith<$Res> get book;

}
/// @nodoc
class _$BookmarkModelCopyWithImpl<$Res>
    implements $BookmarkModelCopyWith<$Res> {
  _$BookmarkModelCopyWithImpl(this._self, this._then);

  final BookmarkModel _self;
  final $Res Function(BookmarkModel) _then;

/// Create a copy of BookmarkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? location = null,Object? book = null,Object? bookSlug = freezed,Object? audioTimestamp = freezed,Object? anchor = freezed,Object? note = null,Object? href = null,Object? timestamp = freezed,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,bookSlug: freezed == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String?,audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as int?,anchor: freezed == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BookmarkModel
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

class _BookmarkModel implements BookmarkModel {
  const _BookmarkModel({this.uuid, required this.location, required this.book, @JsonKey(name: 'book_slug') this.bookSlug, @JsonKey(name: 'audio_timestamp') this.audioTimestamp, this.anchor, required this.note, required this.href, this.timestamp, this.isDeleted = false});
  factory _BookmarkModel.fromJson(Map<String, dynamic> json) => _$BookmarkModelFromJson(json);

@override final  String? uuid;
@override final  String location;
@override final  BookModel book;
@override@JsonKey(name: 'book_slug') final  String? bookSlug;
@override@JsonKey(name: 'audio_timestamp') final  int? audioTimestamp;
@override final  String? anchor;
@override final  String note;
@override final  String href;
// This field is optional and used for syncing purposes.
@override final  int? timestamp;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of BookmarkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookmarkModelCopyWith<_BookmarkModel> get copyWith => __$BookmarkModelCopyWithImpl<_BookmarkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookmarkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookmarkModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.location, location) || other.location == location)&&(identical(other.book, book) || other.book == book)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.note, note) || other.note == note)&&(identical(other.href, href) || other.href == href)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,location,book,bookSlug,audioTimestamp,anchor,note,href,timestamp,isDeleted);

@override
String toString() {
  return 'BookmarkModel(uuid: $uuid, location: $location, book: $book, bookSlug: $bookSlug, audioTimestamp: $audioTimestamp, anchor: $anchor, note: $note, href: $href, timestamp: $timestamp, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$BookmarkModelCopyWith<$Res> implements $BookmarkModelCopyWith<$Res> {
  factory _$BookmarkModelCopyWith(_BookmarkModel value, $Res Function(_BookmarkModel) _then) = __$BookmarkModelCopyWithImpl;
@override @useResult
$Res call({
 String? uuid, String location, BookModel book,@JsonKey(name: 'book_slug') String? bookSlug,@JsonKey(name: 'audio_timestamp') int? audioTimestamp, String? anchor, String note, String href, int? timestamp, bool isDeleted
});


@override $BookModelCopyWith<$Res> get book;

}
/// @nodoc
class __$BookmarkModelCopyWithImpl<$Res>
    implements _$BookmarkModelCopyWith<$Res> {
  __$BookmarkModelCopyWithImpl(this._self, this._then);

  final _BookmarkModel _self;
  final $Res Function(_BookmarkModel) _then;

/// Create a copy of BookmarkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? location = null,Object? book = null,Object? bookSlug = freezed,Object? audioTimestamp = freezed,Object? anchor = freezed,Object? note = null,Object? href = null,Object? timestamp = freezed,Object? isDeleted = null,}) {
  return _then(_BookmarkModel(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,bookSlug: freezed == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String?,audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as int?,anchor: freezed == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BookmarkModel
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
