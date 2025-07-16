// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SyncModel _$SyncModelFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'progress':
          return SyncModelProgress.fromJson(
            json
          );
                case 'user-list':
          return SyncModelUserList.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SyncModel',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SyncModel {

 String get id; int get timestamp; SyncType get type;//todo tu będzie np. model zakładki
 dynamic get object;
/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncModelCopyWith<SyncModel> get copyWith => _$SyncModelCopyWithImpl<SyncModel>(this as SyncModel, _$identity);

  /// Serializes this SyncModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncModel&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.object, object));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp,type,const DeepCollectionEquality().hash(object));

@override
String toString() {
  return 'SyncModel(id: $id, timestamp: $timestamp, type: $type, object: $object)';
}


}

/// @nodoc
abstract mixin class $SyncModelCopyWith<$Res>  {
  factory $SyncModelCopyWith(SyncModel value, $Res Function(SyncModel) _then) = _$SyncModelCopyWithImpl;
@useResult
$Res call({
 String id, int timestamp, SyncType type
});




}
/// @nodoc
class _$SyncModelCopyWithImpl<$Res>
    implements $SyncModelCopyWith<$Res> {
  _$SyncModelCopyWithImpl(this._self, this._then);

  final SyncModel _self;
  final $Res Function(SyncModel) _then;

/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncType,
  ));
}

}


/// @nodoc
@JsonSerializable()

class SyncModelProgress implements SyncModel {
  const SyncModelProgress({required this.id, required this.timestamp, required this.type, required this.object});
  factory SyncModelProgress.fromJson(Map<String, dynamic> json) => _$SyncModelProgressFromJson(json);

@override final  String id;
@override final  int timestamp;
@override final  SyncType type;
@override final  ProgressModel object;

/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncModelProgressCopyWith<SyncModelProgress> get copyWith => _$SyncModelProgressCopyWithImpl<SyncModelProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncModelProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncModelProgress&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&(identical(other.object, object) || other.object == object));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp,type,object);

@override
String toString() {
  return 'SyncModel.progress(id: $id, timestamp: $timestamp, type: $type, object: $object)';
}


}

/// @nodoc
abstract mixin class $SyncModelProgressCopyWith<$Res> implements $SyncModelCopyWith<$Res> {
  factory $SyncModelProgressCopyWith(SyncModelProgress value, $Res Function(SyncModelProgress) _then) = _$SyncModelProgressCopyWithImpl;
@override @useResult
$Res call({
 String id, int timestamp, SyncType type, ProgressModel object
});


$ProgressModelCopyWith<$Res> get object;

}
/// @nodoc
class _$SyncModelProgressCopyWithImpl<$Res>
    implements $SyncModelProgressCopyWith<$Res> {
  _$SyncModelProgressCopyWithImpl(this._self, this._then);

  final SyncModelProgress _self;
  final $Res Function(SyncModelProgress) _then;

/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? type = null,Object? object = null,}) {
  return _then(SyncModelProgress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncType,object: null == object ? _self.object : object // ignore: cast_nullable_to_non_nullable
as ProgressModel,
  ));
}

/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<$Res> get object {
  
  return $ProgressModelCopyWith<$Res>(_self.object, (value) {
    return _then(_self.copyWith(object: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class SyncModelUserList implements SyncModel {
  const SyncModelUserList({required this.id, required this.timestamp, required this.type, required this.object});
  factory SyncModelUserList.fromJson(Map<String, dynamic> json) => _$SyncModelUserListFromJson(json);

@override final  String id;
@override final  int timestamp;
@override final  SyncType type;
//todo tu będzie np. model zakładki
@override final  dynamic object;

/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncModelUserListCopyWith<SyncModelUserList> get copyWith => _$SyncModelUserListCopyWithImpl<SyncModelUserList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncModelUserListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncModelUserList&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.object, object));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp,type,const DeepCollectionEquality().hash(object));

@override
String toString() {
  return 'SyncModel.userList(id: $id, timestamp: $timestamp, type: $type, object: $object)';
}


}

/// @nodoc
abstract mixin class $SyncModelUserListCopyWith<$Res> implements $SyncModelCopyWith<$Res> {
  factory $SyncModelUserListCopyWith(SyncModelUserList value, $Res Function(SyncModelUserList) _then) = _$SyncModelUserListCopyWithImpl;
@override @useResult
$Res call({
 String id, int timestamp, SyncType type, dynamic object
});




}
/// @nodoc
class _$SyncModelUserListCopyWithImpl<$Res>
    implements $SyncModelUserListCopyWith<$Res> {
  _$SyncModelUserListCopyWithImpl(this._self, this._then);

  final SyncModelUserList _self;
  final $Res Function(SyncModelUserList) _then;

/// Create a copy of SyncModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? type = null,Object? object = freezed,}) {
  return _then(SyncModelUserList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SyncType,object: freezed == object ? _self.object : object // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
