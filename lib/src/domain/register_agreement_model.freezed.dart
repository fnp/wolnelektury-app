// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_agreement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegisterAgreementModel _$RegisterAgreementModelFromJson(
    Map<String, dynamic> json) {
  return _RegisterAgreementModel.fromJson(json);
}

/// @nodoc
mixin _$RegisterAgreementModel {
  List<String> get info => throw _privateConstructorUsedError;
  List<SingleRegisterAgreementModel> get options =>
      throw _privateConstructorUsedError;

  /// Serializes this RegisterAgreementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterAgreementModelCopyWith<RegisterAgreementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterAgreementModelCopyWith<$Res> {
  factory $RegisterAgreementModelCopyWith(RegisterAgreementModel value,
          $Res Function(RegisterAgreementModel) then) =
      _$RegisterAgreementModelCopyWithImpl<$Res, RegisterAgreementModel>;
  @useResult
  $Res call({List<String> info, List<SingleRegisterAgreementModel> options});
}

/// @nodoc
class _$RegisterAgreementModelCopyWithImpl<$Res,
        $Val extends RegisterAgreementModel>
    implements $RegisterAgreementModelCopyWith<$Res> {
  _$RegisterAgreementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as List<String>,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SingleRegisterAgreementModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterAgreementModelImplCopyWith<$Res>
    implements $RegisterAgreementModelCopyWith<$Res> {
  factory _$$RegisterAgreementModelImplCopyWith(
          _$RegisterAgreementModelImpl value,
          $Res Function(_$RegisterAgreementModelImpl) then) =
      __$$RegisterAgreementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> info, List<SingleRegisterAgreementModel> options});
}

/// @nodoc
class __$$RegisterAgreementModelImplCopyWithImpl<$Res>
    extends _$RegisterAgreementModelCopyWithImpl<$Res,
        _$RegisterAgreementModelImpl>
    implements _$$RegisterAgreementModelImplCopyWith<$Res> {
  __$$RegisterAgreementModelImplCopyWithImpl(
      _$RegisterAgreementModelImpl _value,
      $Res Function(_$RegisterAgreementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? options = null,
  }) {
    return _then(_$RegisterAgreementModelImpl(
      info: null == info
          ? _value._info
          : info // ignore: cast_nullable_to_non_nullable
              as List<String>,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SingleRegisterAgreementModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterAgreementModelImpl implements _RegisterAgreementModel {
  const _$RegisterAgreementModelImpl(
      {final List<String> info = const [],
      final List<SingleRegisterAgreementModel> options = const []})
      : _info = info,
        _options = options;

  factory _$RegisterAgreementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterAgreementModelImplFromJson(json);

  final List<String> _info;
  @override
  @JsonKey()
  List<String> get info {
    if (_info is EqualUnmodifiableListView) return _info;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_info);
  }

  final List<SingleRegisterAgreementModel> _options;
  @override
  @JsonKey()
  List<SingleRegisterAgreementModel> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'RegisterAgreementModel(info: $info, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterAgreementModelImpl &&
            const DeepCollectionEquality().equals(other._info, _info) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_info),
      const DeepCollectionEquality().hash(_options));

  /// Create a copy of RegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterAgreementModelImplCopyWith<_$RegisterAgreementModelImpl>
      get copyWith => __$$RegisterAgreementModelImplCopyWithImpl<
          _$RegisterAgreementModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterAgreementModelImplToJson(
      this,
    );
  }
}

abstract class _RegisterAgreementModel implements RegisterAgreementModel {
  const factory _RegisterAgreementModel(
          {final List<String> info,
          final List<SingleRegisterAgreementModel> options}) =
      _$RegisterAgreementModelImpl;

  factory _RegisterAgreementModel.fromJson(Map<String, dynamic> json) =
      _$RegisterAgreementModelImpl.fromJson;

  @override
  List<String> get info;
  @override
  List<SingleRegisterAgreementModel> get options;

  /// Create a copy of RegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterAgreementModelImplCopyWith<_$RegisterAgreementModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SingleRegisterAgreementModel _$SingleRegisterAgreementModelFromJson(
    Map<String, dynamic> json) {
  return _SingleRegisterAgreementModel.fromJson(json);
}

/// @nodoc
mixin _$SingleRegisterAgreementModel {
  int get id => throw _privateConstructorUsedError;
  String get html => throw _privateConstructorUsedError;
  bool get required => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  /// Serializes this SingleRegisterAgreementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SingleRegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SingleRegisterAgreementModelCopyWith<SingleRegisterAgreementModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleRegisterAgreementModelCopyWith<$Res> {
  factory $SingleRegisterAgreementModelCopyWith(
          SingleRegisterAgreementModel value,
          $Res Function(SingleRegisterAgreementModel) then) =
      _$SingleRegisterAgreementModelCopyWithImpl<$Res,
          SingleRegisterAgreementModel>;
  @useResult
  $Res call({int id, String html, bool required, bool isChecked});
}

/// @nodoc
class _$SingleRegisterAgreementModelCopyWithImpl<$Res,
        $Val extends SingleRegisterAgreementModel>
    implements $SingleRegisterAgreementModelCopyWith<$Res> {
  _$SingleRegisterAgreementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SingleRegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? html = null,
    Object? required = null,
    Object? isChecked = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      html: null == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SingleRegisterAgreementModelImplCopyWith<$Res>
    implements $SingleRegisterAgreementModelCopyWith<$Res> {
  factory _$$SingleRegisterAgreementModelImplCopyWith(
          _$SingleRegisterAgreementModelImpl value,
          $Res Function(_$SingleRegisterAgreementModelImpl) then) =
      __$$SingleRegisterAgreementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String html, bool required, bool isChecked});
}

/// @nodoc
class __$$SingleRegisterAgreementModelImplCopyWithImpl<$Res>
    extends _$SingleRegisterAgreementModelCopyWithImpl<$Res,
        _$SingleRegisterAgreementModelImpl>
    implements _$$SingleRegisterAgreementModelImplCopyWith<$Res> {
  __$$SingleRegisterAgreementModelImplCopyWithImpl(
      _$SingleRegisterAgreementModelImpl _value,
      $Res Function(_$SingleRegisterAgreementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleRegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? html = null,
    Object? required = null,
    Object? isChecked = null,
  }) {
    return _then(_$SingleRegisterAgreementModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      html: null == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SingleRegisterAgreementModelImpl
    implements _SingleRegisterAgreementModel {
  const _$SingleRegisterAgreementModelImpl(
      {required this.id,
      required this.html,
      required this.required,
      this.isChecked = false});

  factory _$SingleRegisterAgreementModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SingleRegisterAgreementModelImplFromJson(json);

  @override
  final int id;
  @override
  final String html;
  @override
  final bool required;
  @override
  @JsonKey()
  final bool isChecked;

  @override
  String toString() {
    return 'SingleRegisterAgreementModel(id: $id, html: $html, required: $required, isChecked: $isChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleRegisterAgreementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.html, html) || other.html == html) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, html, required, isChecked);

  /// Create a copy of SingleRegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleRegisterAgreementModelImplCopyWith<
          _$SingleRegisterAgreementModelImpl>
      get copyWith => __$$SingleRegisterAgreementModelImplCopyWithImpl<
          _$SingleRegisterAgreementModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SingleRegisterAgreementModelImplToJson(
      this,
    );
  }
}

abstract class _SingleRegisterAgreementModel
    implements SingleRegisterAgreementModel {
  const factory _SingleRegisterAgreementModel(
      {required final int id,
      required final String html,
      required final bool required,
      final bool isChecked}) = _$SingleRegisterAgreementModelImpl;

  factory _SingleRegisterAgreementModel.fromJson(Map<String, dynamic> json) =
      _$SingleRegisterAgreementModelImpl.fromJson;

  @override
  int get id;
  @override
  String get html;
  @override
  bool get required;
  @override
  bool get isChecked;

  /// Create a copy of SingleRegisterAgreementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SingleRegisterAgreementModelImplCopyWith<
          _$SingleRegisterAgreementModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
