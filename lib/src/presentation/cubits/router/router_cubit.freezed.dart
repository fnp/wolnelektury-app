// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'router_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RouterState {
  String get location => throw _privateConstructorUsedError;
  String get previousLocation => throw _privateConstructorUsedError;

  /// Create a copy of RouterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouterStateCopyWith<RouterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouterStateCopyWith<$Res> {
  factory $RouterStateCopyWith(
          RouterState value, $Res Function(RouterState) then) =
      _$RouterStateCopyWithImpl<$Res, RouterState>;
  @useResult
  $Res call({String location, String previousLocation});
}

/// @nodoc
class _$RouterStateCopyWithImpl<$Res, $Val extends RouterState>
    implements $RouterStateCopyWith<$Res> {
  _$RouterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? previousLocation = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      previousLocation: null == previousLocation
          ? _value.previousLocation
          : previousLocation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouterStateImplCopyWith<$Res>
    implements $RouterStateCopyWith<$Res> {
  factory _$$RouterStateImplCopyWith(
          _$RouterStateImpl value, $Res Function(_$RouterStateImpl) then) =
      __$$RouterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String location, String previousLocation});
}

/// @nodoc
class __$$RouterStateImplCopyWithImpl<$Res>
    extends _$RouterStateCopyWithImpl<$Res, _$RouterStateImpl>
    implements _$$RouterStateImplCopyWith<$Res> {
  __$$RouterStateImplCopyWithImpl(
      _$RouterStateImpl _value, $Res Function(_$RouterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? previousLocation = null,
  }) {
    return _then(_$RouterStateImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      previousLocation: null == previousLocation
          ? _value.previousLocation
          : previousLocation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RouterStateImpl implements _RouterState {
  const _$RouterStateImpl(
      {required this.location, required this.previousLocation});

  @override
  final String location;
  @override
  final String previousLocation;

  @override
  String toString() {
    return 'RouterState(location: $location, previousLocation: $previousLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouterStateImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.previousLocation, previousLocation) ||
                other.previousLocation == previousLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location, previousLocation);

  /// Create a copy of RouterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouterStateImplCopyWith<_$RouterStateImpl> get copyWith =>
      __$$RouterStateImplCopyWithImpl<_$RouterStateImpl>(this, _$identity);
}

abstract class _RouterState implements RouterState {
  const factory _RouterState(
      {required final String location,
      required final String previousLocation}) = _$RouterStateImpl;

  @override
  String get location;
  @override
  String get previousLocation;

  /// Create a copy of RouterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouterStateImplCopyWith<_$RouterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
