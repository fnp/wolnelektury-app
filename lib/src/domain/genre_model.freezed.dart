// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'genre_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenreModel {

 int? get id; String? get url; String? get name; String? get href; String? get slug;
/// Create a copy of GenreModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenreModelCopyWith<GenreModel> get copyWith => _$GenreModelCopyWithImpl<GenreModel>(this as GenreModel, _$identity);

  /// Serializes this GenreModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenreModel&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.href, href) || other.href == href)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,name,href,slug);

@override
String toString() {
  return 'GenreModel(id: $id, url: $url, name: $name, href: $href, slug: $slug)';
}


}

/// @nodoc
abstract mixin class $GenreModelCopyWith<$Res>  {
  factory $GenreModelCopyWith(GenreModel value, $Res Function(GenreModel) _then) = _$GenreModelCopyWithImpl;
@useResult
$Res call({
 int? id, String? url, String? name, String? href, String? slug
});




}
/// @nodoc
class _$GenreModelCopyWithImpl<$Res>
    implements $GenreModelCopyWith<$Res> {
  _$GenreModelCopyWithImpl(this._self, this._then);

  final GenreModel _self;
  final $Res Function(GenreModel) _then;

/// Create a copy of GenreModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? url = freezed,Object? name = freezed,Object? href = freezed,Object? slug = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,href: freezed == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _GenreModel implements GenreModel {
  const _GenreModel({this.id, this.url, this.name, this.href, this.slug});
  factory _GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

@override final  int? id;
@override final  String? url;
@override final  String? name;
@override final  String? href;
@override final  String? slug;

/// Create a copy of GenreModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenreModelCopyWith<_GenreModel> get copyWith => __$GenreModelCopyWithImpl<_GenreModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenreModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenreModel&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.href, href) || other.href == href)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,name,href,slug);

@override
String toString() {
  return 'GenreModel(id: $id, url: $url, name: $name, href: $href, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$GenreModelCopyWith<$Res> implements $GenreModelCopyWith<$Res> {
  factory _$GenreModelCopyWith(_GenreModel value, $Res Function(_GenreModel) _then) = __$GenreModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? url, String? name, String? href, String? slug
});




}
/// @nodoc
class __$GenreModelCopyWithImpl<$Res>
    implements _$GenreModelCopyWith<$Res> {
  __$GenreModelCopyWithImpl(this._self, this._then);

  final _GenreModel _self;
  final $Res Function(_GenreModel) _then;

/// Create a copy of GenreModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? url = freezed,Object? name = freezed,Object? href = freezed,Object? slug = freezed,}) {
  return _then(_GenreModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,href: freezed == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
