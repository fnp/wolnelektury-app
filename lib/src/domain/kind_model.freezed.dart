// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kind_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KindModel {

 String? get url; String? get name; String? get href; String? get slug;
/// Create a copy of KindModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KindModelCopyWith<KindModel> get copyWith => _$KindModelCopyWithImpl<KindModel>(this as KindModel, _$identity);

  /// Serializes this KindModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KindModel&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.href, href) || other.href == href)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,href,slug);

@override
String toString() {
  return 'KindModel(url: $url, name: $name, href: $href, slug: $slug)';
}


}

/// @nodoc
abstract mixin class $KindModelCopyWith<$Res>  {
  factory $KindModelCopyWith(KindModel value, $Res Function(KindModel) _then) = _$KindModelCopyWithImpl;
@useResult
$Res call({
 String? url, String? name, String? href, String? slug
});




}
/// @nodoc
class _$KindModelCopyWithImpl<$Res>
    implements $KindModelCopyWith<$Res> {
  _$KindModelCopyWithImpl(this._self, this._then);

  final KindModel _self;
  final $Res Function(KindModel) _then;

/// Create a copy of KindModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? name = freezed,Object? href = freezed,Object? slug = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,href: freezed == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KindModel implements KindModel {
  const _KindModel({this.url, this.name, this.href, this.slug});
  factory _KindModel.fromJson(Map<String, dynamic> json) => _$KindModelFromJson(json);

@override final  String? url;
@override final  String? name;
@override final  String? href;
@override final  String? slug;

/// Create a copy of KindModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KindModelCopyWith<_KindModel> get copyWith => __$KindModelCopyWithImpl<_KindModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KindModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KindModel&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.href, href) || other.href == href)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,href,slug);

@override
String toString() {
  return 'KindModel(url: $url, name: $name, href: $href, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$KindModelCopyWith<$Res> implements $KindModelCopyWith<$Res> {
  factory _$KindModelCopyWith(_KindModel value, $Res Function(_KindModel) _then) = __$KindModelCopyWithImpl;
@override @useResult
$Res call({
 String? url, String? name, String? href, String? slug
});




}
/// @nodoc
class __$KindModelCopyWithImpl<$Res>
    implements _$KindModelCopyWith<$Res> {
  __$KindModelCopyWithImpl(this._self, this._then);

  final _KindModel _self;
  final $Res Function(_KindModel) _then;

/// Create a copy of KindModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? name = freezed,Object? href = freezed,Object? slug = freezed,}) {
  return _then(_KindModel(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,href: freezed == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
