// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hint_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HintModel {

@JsonKey(unknownEnumValue: HintTypeEnum.unknown) HintTypeEnum get type; String get label; String? get url; String? get img; String? get slug; int? get id;
/// Create a copy of HintModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintModelCopyWith<HintModel> get copyWith => _$HintModelCopyWithImpl<HintModel>(this as HintModel, _$identity);

  /// Serializes this HintModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintModel&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.img, img) || other.img == img)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,url,img,slug,id);

@override
String toString() {
  return 'HintModel(type: $type, label: $label, url: $url, img: $img, slug: $slug, id: $id)';
}


}

/// @nodoc
abstract mixin class $HintModelCopyWith<$Res>  {
  factory $HintModelCopyWith(HintModel value, $Res Function(HintModel) _then) = _$HintModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: HintTypeEnum.unknown) HintTypeEnum type, String label, String? url, String? img, String? slug, int? id
});




}
/// @nodoc
class _$HintModelCopyWithImpl<$Res>
    implements $HintModelCopyWith<$Res> {
  _$HintModelCopyWithImpl(this._self, this._then);

  final HintModel _self;
  final $Res Function(HintModel) _then;

/// Create a copy of HintModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? label = null,Object? url = freezed,Object? img = freezed,Object? slug = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HintTypeEnum,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,img: freezed == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HintModel implements HintModel {
  const _HintModel({@JsonKey(unknownEnumValue: HintTypeEnum.unknown) required this.type, required this.label, this.url, this.img, this.slug, this.id});
  factory _HintModel.fromJson(Map<String, dynamic> json) => _$HintModelFromJson(json);

@override@JsonKey(unknownEnumValue: HintTypeEnum.unknown) final  HintTypeEnum type;
@override final  String label;
@override final  String? url;
@override final  String? img;
@override final  String? slug;
@override final  int? id;

/// Create a copy of HintModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintModelCopyWith<_HintModel> get copyWith => __$HintModelCopyWithImpl<_HintModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HintModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintModel&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.img, img) || other.img == img)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,url,img,slug,id);

@override
String toString() {
  return 'HintModel(type: $type, label: $label, url: $url, img: $img, slug: $slug, id: $id)';
}


}

/// @nodoc
abstract mixin class _$HintModelCopyWith<$Res> implements $HintModelCopyWith<$Res> {
  factory _$HintModelCopyWith(_HintModel value, $Res Function(_HintModel) _then) = __$HintModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: HintTypeEnum.unknown) HintTypeEnum type, String label, String? url, String? img, String? slug, int? id
});




}
/// @nodoc
class __$HintModelCopyWithImpl<$Res>
    implements _$HintModelCopyWith<$Res> {
  __$HintModelCopyWithImpl(this._self, this._then);

  final _HintModel _self;
  final $Res Function(_HintModel) _then;

/// Create a copy of HintModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,Object? url = freezed,Object? img = freezed,Object? slug = freezed,Object? id = freezed,}) {
  return _then(_HintModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HintTypeEnum,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,img: freezed == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
