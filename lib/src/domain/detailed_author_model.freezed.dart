// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detailed_author_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DetailedAuthorModel _$DetailedAuthorModelFromJson(Map<String, dynamic> json) {
  return _DetailedAuthorModel.fromJson(json);
}

/// @nodoc
mixin _$DetailedAuthorModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  /// Serializes this DetailedAuthorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetailedAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailedAuthorModelCopyWith<DetailedAuthorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailedAuthorModelCopyWith<$Res> {
  factory $DetailedAuthorModelCopyWith(
          DetailedAuthorModel value, $Res Function(DetailedAuthorModel) then) =
      _$DetailedAuthorModelCopyWithImpl<$Res, DetailedAuthorModel>;
  @useResult
  $Res call(
      {int id, String name, String slug, String? description, String? photo});
}

/// @nodoc
class _$DetailedAuthorModelCopyWithImpl<$Res, $Val extends DetailedAuthorModel>
    implements $DetailedAuthorModelCopyWith<$Res> {
  _$DetailedAuthorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetailedAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DetailedAuthorModelImplCopyWith<$Res>
    implements $DetailedAuthorModelCopyWith<$Res> {
  factory _$$DetailedAuthorModelImplCopyWith(_$DetailedAuthorModelImpl value,
          $Res Function(_$DetailedAuthorModelImpl) then) =
      __$$DetailedAuthorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String name, String slug, String? description, String? photo});
}

/// @nodoc
class __$$DetailedAuthorModelImplCopyWithImpl<$Res>
    extends _$DetailedAuthorModelCopyWithImpl<$Res, _$DetailedAuthorModelImpl>
    implements _$$DetailedAuthorModelImplCopyWith<$Res> {
  __$$DetailedAuthorModelImplCopyWithImpl(_$DetailedAuthorModelImpl _value,
      $Res Function(_$DetailedAuthorModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DetailedAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? photo = freezed,
  }) {
    return _then(_$DetailedAuthorModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailedAuthorModelImpl implements _DetailedAuthorModel {
  const _$DetailedAuthorModelImpl(
      {required this.id,
      required this.name,
      required this.slug,
      this.description,
      this.photo});

  factory _$DetailedAuthorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailedAuthorModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  final String? photo;

  @override
  String toString() {
    return 'DetailedAuthorModel(id: $id, name: $name, slug: $slug, description: $description, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailedAuthorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, slug, description, photo);

  /// Create a copy of DetailedAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailedAuthorModelImplCopyWith<_$DetailedAuthorModelImpl> get copyWith =>
      __$$DetailedAuthorModelImplCopyWithImpl<_$DetailedAuthorModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailedAuthorModelImplToJson(
      this,
    );
  }
}

abstract class _DetailedAuthorModel implements DetailedAuthorModel {
  const factory _DetailedAuthorModel(
      {required final int id,
      required final String name,
      required final String slug,
      final String? description,
      final String? photo}) = _$DetailedAuthorModelImpl;

  factory _DetailedAuthorModel.fromJson(Map<String, dynamic> json) =
      _$DetailedAuthorModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get description;
  @override
  String? get photo;

  /// Create a copy of DetailedAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailedAuthorModelImplCopyWith<_$DetailedAuthorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
