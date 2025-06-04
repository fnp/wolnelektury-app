// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'epoch_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpochModel {

 String? get url; String? get name; String? get href; String? get slug;
/// Create a copy of EpochModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpochModelCopyWith<EpochModel> get copyWith => _$EpochModelCopyWithImpl<EpochModel>(this as EpochModel, _$identity);

  /// Serializes this EpochModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpochModel&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.href, href) || other.href == href)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,href,slug);

@override
String toString() {
  return 'EpochModel(url: $url, name: $name, href: $href, slug: $slug)';
}


}

/// @nodoc
abstract mixin class $EpochModelCopyWith<$Res>  {
  factory $EpochModelCopyWith(EpochModel value, $Res Function(EpochModel) _then) = _$EpochModelCopyWithImpl;
@useResult
$Res call({
 String? url, String? name, String? href, String? slug
});




}
/// @nodoc
class _$EpochModelCopyWithImpl<$Res>
    implements $EpochModelCopyWith<$Res> {
  _$EpochModelCopyWithImpl(this._self, this._then);

  final EpochModel _self;
  final $Res Function(EpochModel) _then;

/// Create a copy of EpochModel
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

class _EpochModel implements EpochModel {
  const _EpochModel({this.url, this.name, this.href, this.slug});
  factory _EpochModel.fromJson(Map<String, dynamic> json) => _$EpochModelFromJson(json);

@override final  String? url;
@override final  String? name;
@override final  String? href;
@override final  String? slug;

/// Create a copy of EpochModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpochModelCopyWith<_EpochModel> get copyWith => __$EpochModelCopyWithImpl<_EpochModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpochModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpochModel&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.href, href) || other.href == href)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,href,slug);

@override
String toString() {
  return 'EpochModel(url: $url, name: $name, href: $href, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$EpochModelCopyWith<$Res> implements $EpochModelCopyWith<$Res> {
  factory _$EpochModelCopyWith(_EpochModel value, $Res Function(_EpochModel) _then) = __$EpochModelCopyWithImpl;
@override @useResult
$Res call({
 String? url, String? name, String? href, String? slug
});




}
/// @nodoc
class __$EpochModelCopyWithImpl<$Res>
    implements _$EpochModelCopyWith<$Res> {
  __$EpochModelCopyWithImpl(this._self, this._then);

  final _EpochModel _self;
  final $Res Function(_EpochModel) _then;

/// Create a copy of EpochModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? name = freezed,Object? href = freezed,Object? slug = freezed,}) {
  return _then(_EpochModel(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,href: freezed == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
