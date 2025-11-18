// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_text_audio_sync_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookTextAudioSyncModel {

 String get id; double get timestamp;
/// Create a copy of BookTextAudioSyncModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookTextAudioSyncModelCopyWith<BookTextAudioSyncModel> get copyWith => _$BookTextAudioSyncModelCopyWithImpl<BookTextAudioSyncModel>(this as BookTextAudioSyncModel, _$identity);

  /// Serializes this BookTextAudioSyncModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookTextAudioSyncModel&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp);

@override
String toString() {
  return 'BookTextAudioSyncModel(id: $id, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $BookTextAudioSyncModelCopyWith<$Res>  {
  factory $BookTextAudioSyncModelCopyWith(BookTextAudioSyncModel value, $Res Function(BookTextAudioSyncModel) _then) = _$BookTextAudioSyncModelCopyWithImpl;
@useResult
$Res call({
 String id, double timestamp
});




}
/// @nodoc
class _$BookTextAudioSyncModelCopyWithImpl<$Res>
    implements $BookTextAudioSyncModelCopyWith<$Res> {
  _$BookTextAudioSyncModelCopyWithImpl(this._self, this._then);

  final BookTextAudioSyncModel _self;
  final $Res Function(BookTextAudioSyncModel) _then;

/// Create a copy of BookTextAudioSyncModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookTextAudioSyncModel implements BookTextAudioSyncModel {
  const _BookTextAudioSyncModel({required this.id, required this.timestamp});
  factory _BookTextAudioSyncModel.fromJson(Map<String, dynamic> json) => _$BookTextAudioSyncModelFromJson(json);

@override final  String id;
@override final  double timestamp;

/// Create a copy of BookTextAudioSyncModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookTextAudioSyncModelCopyWith<_BookTextAudioSyncModel> get copyWith => __$BookTextAudioSyncModelCopyWithImpl<_BookTextAudioSyncModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookTextAudioSyncModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookTextAudioSyncModel&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp);

@override
String toString() {
  return 'BookTextAudioSyncModel(id: $id, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$BookTextAudioSyncModelCopyWith<$Res> implements $BookTextAudioSyncModelCopyWith<$Res> {
  factory _$BookTextAudioSyncModelCopyWith(_BookTextAudioSyncModel value, $Res Function(_BookTextAudioSyncModel) _then) = __$BookTextAudioSyncModelCopyWithImpl;
@override @useResult
$Res call({
 String id, double timestamp
});




}
/// @nodoc
class __$BookTextAudioSyncModelCopyWithImpl<$Res>
    implements _$BookTextAudioSyncModelCopyWith<$Res> {
  __$BookTextAudioSyncModelCopyWithImpl(this._self, this._then);

  final _BookTextAudioSyncModel _self;
  final $Res Function(_BookTextAudioSyncModel) _then;

/// Create a copy of BookTextAudioSyncModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,}) {
  return _then(_BookTextAudioSyncModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
