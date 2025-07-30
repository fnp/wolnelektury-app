// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_sync_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LikeSyncModel {

@JsonKey(name: 'book_slug') String get slug; bool get deleted; bool get favourite; int? get timestamp;
/// Create a copy of LikeSyncModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeSyncModelCopyWith<LikeSyncModel> get copyWith => _$LikeSyncModelCopyWithImpl<LikeSyncModel>(this as LikeSyncModel, _$identity);

  /// Serializes this LikeSyncModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeSyncModel&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.favourite, favourite) || other.favourite == favourite)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,deleted,favourite,timestamp);

@override
String toString() {
  return 'LikeSyncModel(slug: $slug, deleted: $deleted, favourite: $favourite, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $LikeSyncModelCopyWith<$Res>  {
  factory $LikeSyncModelCopyWith(LikeSyncModel value, $Res Function(LikeSyncModel) _then) = _$LikeSyncModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'book_slug') String slug, bool deleted, bool favourite, int? timestamp
});




}
/// @nodoc
class _$LikeSyncModelCopyWithImpl<$Res>
    implements $LikeSyncModelCopyWith<$Res> {
  _$LikeSyncModelCopyWithImpl(this._self, this._then);

  final LikeSyncModel _self;
  final $Res Function(LikeSyncModel) _then;

/// Create a copy of LikeSyncModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? deleted = null,Object? favourite = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,favourite: null == favourite ? _self.favourite : favourite // ignore: cast_nullable_to_non_nullable
as bool,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LikeSyncModel implements LikeSyncModel {
  const _LikeSyncModel({@JsonKey(name: 'book_slug') required this.slug, this.deleted = false, this.favourite = true, this.timestamp});
  factory _LikeSyncModel.fromJson(Map<String, dynamic> json) => _$LikeSyncModelFromJson(json);

@override@JsonKey(name: 'book_slug') final  String slug;
@override@JsonKey() final  bool deleted;
@override@JsonKey() final  bool favourite;
@override final  int? timestamp;

/// Create a copy of LikeSyncModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeSyncModelCopyWith<_LikeSyncModel> get copyWith => __$LikeSyncModelCopyWithImpl<_LikeSyncModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LikeSyncModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeSyncModel&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.favourite, favourite) || other.favourite == favourite)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,deleted,favourite,timestamp);

@override
String toString() {
  return 'LikeSyncModel(slug: $slug, deleted: $deleted, favourite: $favourite, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$LikeSyncModelCopyWith<$Res> implements $LikeSyncModelCopyWith<$Res> {
  factory _$LikeSyncModelCopyWith(_LikeSyncModel value, $Res Function(_LikeSyncModel) _then) = __$LikeSyncModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'book_slug') String slug, bool deleted, bool favourite, int? timestamp
});




}
/// @nodoc
class __$LikeSyncModelCopyWithImpl<$Res>
    implements _$LikeSyncModelCopyWith<$Res> {
  __$LikeSyncModelCopyWithImpl(this._self, this._then);

  final _LikeSyncModel _self;
  final $Res Function(_LikeSyncModel) _then;

/// Create a copy of LikeSyncModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? deleted = null,Object? favourite = null,Object? timestamp = freezed,}) {
  return _then(_LikeSyncModel(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,favourite: null == favourite ? _self.favourite : favourite // ignore: cast_nullable_to_non_nullable
as bool,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
