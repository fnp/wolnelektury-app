// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kind_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KindModel _$KindModelFromJson(Map<String, dynamic> json) {
  return _KindModel.fromJson(json);
}

/// @nodoc
mixin _$KindModel {
  String? get url => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get href => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;

  /// Serializes this KindModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KindModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KindModelCopyWith<KindModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KindModelCopyWith<$Res> {
  factory $KindModelCopyWith(KindModel value, $Res Function(KindModel) then) =
      _$KindModelCopyWithImpl<$Res, KindModel>;
  @useResult
  $Res call({String? url, String? name, String? href, String? slug});
}

/// @nodoc
class _$KindModelCopyWithImpl<$Res, $Val extends KindModel>
    implements $KindModelCopyWith<$Res> {
  _$KindModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KindModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? name = freezed,
    Object? href = freezed,
    Object? slug = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KindModelImplCopyWith<$Res>
    implements $KindModelCopyWith<$Res> {
  factory _$$KindModelImplCopyWith(
          _$KindModelImpl value, $Res Function(_$KindModelImpl) then) =
      __$$KindModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, String? name, String? href, String? slug});
}

/// @nodoc
class __$$KindModelImplCopyWithImpl<$Res>
    extends _$KindModelCopyWithImpl<$Res, _$KindModelImpl>
    implements _$$KindModelImplCopyWith<$Res> {
  __$$KindModelImplCopyWithImpl(
      _$KindModelImpl _value, $Res Function(_$KindModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of KindModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? name = freezed,
    Object? href = freezed,
    Object? slug = freezed,
  }) {
    return _then(_$KindModelImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KindModelImpl implements _KindModel {
  const _$KindModelImpl({this.url, this.name, this.href, this.slug});

  factory _$KindModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KindModelImplFromJson(json);

  @override
  final String? url;
  @override
  final String? name;
  @override
  final String? href;
  @override
  final String? slug;

  @override
  String toString() {
    return 'KindModel(url: $url, name: $name, href: $href, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KindModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, name, href, slug);

  /// Create a copy of KindModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KindModelImplCopyWith<_$KindModelImpl> get copyWith =>
      __$$KindModelImplCopyWithImpl<_$KindModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KindModelImplToJson(
      this,
    );
  }
}

abstract class _KindModel implements KindModel {
  const factory _KindModel(
      {final String? url,
      final String? name,
      final String? href,
      final String? slug}) = _$KindModelImpl;

  factory _KindModel.fromJson(Map<String, dynamic> json) =
      _$KindModelImpl.fromJson;

  @override
  String? get url;
  @override
  String? get name;
  @override
  String? get href;
  @override
  String? get slug;

  /// Create a copy of KindModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KindModelImplCopyWith<_$KindModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
