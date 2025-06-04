// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detailed_author_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetailedAuthorModel {

 int get id; String get name; String get slug; String? get description; String? get photo;
/// Create a copy of DetailedAuthorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedAuthorModelCopyWith<DetailedAuthorModel> get copyWith => _$DetailedAuthorModelCopyWithImpl<DetailedAuthorModel>(this as DetailedAuthorModel, _$identity);

  /// Serializes this DetailedAuthorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedAuthorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.photo, photo) || other.photo == photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,photo);

@override
String toString() {
  return 'DetailedAuthorModel(id: $id, name: $name, slug: $slug, description: $description, photo: $photo)';
}


}

/// @nodoc
abstract mixin class $DetailedAuthorModelCopyWith<$Res>  {
  factory $DetailedAuthorModelCopyWith(DetailedAuthorModel value, $Res Function(DetailedAuthorModel) _then) = _$DetailedAuthorModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? description, String? photo
});




}
/// @nodoc
class _$DetailedAuthorModelCopyWithImpl<$Res>
    implements $DetailedAuthorModelCopyWith<$Res> {
  _$DetailedAuthorModelCopyWithImpl(this._self, this._then);

  final DetailedAuthorModel _self;
  final $Res Function(DetailedAuthorModel) _then;

/// Create a copy of DetailedAuthorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? description = freezed,Object? photo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DetailedAuthorModel implements DetailedAuthorModel {
  const _DetailedAuthorModel({required this.id, required this.name, required this.slug, this.description, this.photo});
  factory _DetailedAuthorModel.fromJson(Map<String, dynamic> json) => _$DetailedAuthorModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String? description;
@override final  String? photo;

/// Create a copy of DetailedAuthorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailedAuthorModelCopyWith<_DetailedAuthorModel> get copyWith => __$DetailedAuthorModelCopyWithImpl<_DetailedAuthorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetailedAuthorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailedAuthorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.photo, photo) || other.photo == photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,photo);

@override
String toString() {
  return 'DetailedAuthorModel(id: $id, name: $name, slug: $slug, description: $description, photo: $photo)';
}


}

/// @nodoc
abstract mixin class _$DetailedAuthorModelCopyWith<$Res> implements $DetailedAuthorModelCopyWith<$Res> {
  factory _$DetailedAuthorModelCopyWith(_DetailedAuthorModel value, $Res Function(_DetailedAuthorModel) _then) = __$DetailedAuthorModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? description, String? photo
});




}
/// @nodoc
class __$DetailedAuthorModelCopyWithImpl<$Res>
    implements _$DetailedAuthorModelCopyWith<$Res> {
  __$DetailedAuthorModelCopyWithImpl(this._self, this._then);

  final _DetailedAuthorModel _self;
  final $Res Function(_DetailedAuthorModel) _then;

/// Create a copy of DetailedAuthorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? description = freezed,Object? photo = freezed,}) {
  return _then(_DetailedAuthorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
