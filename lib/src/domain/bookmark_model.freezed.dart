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

 String get location;@JsonKey(name: 'book') String get slug; String get note; String get anchor; String get href;// This field is optional and used for syncing purposes.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarkModel&&(identical(other.location, location) || other.location == location)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.note, note) || other.note == note)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.href, href) || other.href == href)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,slug,note,anchor,href,timestamp,isDeleted);

@override
String toString() {
  return 'BookmarkModel(location: $location, slug: $slug, note: $note, anchor: $anchor, href: $href, timestamp: $timestamp, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $BookmarkModelCopyWith<$Res>  {
  factory $BookmarkModelCopyWith(BookmarkModel value, $Res Function(BookmarkModel) _then) = _$BookmarkModelCopyWithImpl;
@useResult
$Res call({
 String location,@JsonKey(name: 'book') String slug, String note, String anchor, String href, int? timestamp, bool isDeleted
});




}
/// @nodoc
class _$BookmarkModelCopyWithImpl<$Res>
    implements $BookmarkModelCopyWith<$Res> {
  _$BookmarkModelCopyWithImpl(this._self, this._then);

  final BookmarkModel _self;
  final $Res Function(BookmarkModel) _then;

/// Create a copy of BookmarkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? slug = null,Object? note = null,Object? anchor = null,Object? href = null,Object? timestamp = freezed,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookmarkModel implements BookmarkModel {
  const _BookmarkModel({required this.location, @JsonKey(name: 'book') required this.slug, required this.note, required this.anchor, required this.href, this.timestamp, this.isDeleted = false});
  factory _BookmarkModel.fromJson(Map<String, dynamic> json) => _$BookmarkModelFromJson(json);

@override final  String location;
@override@JsonKey(name: 'book') final  String slug;
@override final  String note;
@override final  String anchor;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookmarkModel&&(identical(other.location, location) || other.location == location)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.note, note) || other.note == note)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.href, href) || other.href == href)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,slug,note,anchor,href,timestamp,isDeleted);

@override
String toString() {
  return 'BookmarkModel(location: $location, slug: $slug, note: $note, anchor: $anchor, href: $href, timestamp: $timestamp, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$BookmarkModelCopyWith<$Res> implements $BookmarkModelCopyWith<$Res> {
  factory _$BookmarkModelCopyWith(_BookmarkModel value, $Res Function(_BookmarkModel) _then) = __$BookmarkModelCopyWithImpl;
@override @useResult
$Res call({
 String location,@JsonKey(name: 'book') String slug, String note, String anchor, String href, int? timestamp, bool isDeleted
});




}
/// @nodoc
class __$BookmarkModelCopyWithImpl<$Res>
    implements _$BookmarkModelCopyWith<$Res> {
  __$BookmarkModelCopyWithImpl(this._self, this._then);

  final _BookmarkModel _self;
  final $Res Function(_BookmarkModel) _then;

/// Create a copy of BookmarkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? slug = null,Object? note = null,Object? anchor = null,Object? href = null,Object? timestamp = freezed,Object? isDeleted = null,}) {
  return _then(_BookmarkModel(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
