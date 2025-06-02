// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_mode_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppModeState {
  AppModeEnum get mode => throw _privateConstructorUsedError;

  /// Create a copy of AppModeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppModeStateCopyWith<AppModeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppModeStateCopyWith<$Res> {
  factory $AppModeStateCopyWith(
          AppModeState value, $Res Function(AppModeState) then) =
      _$AppModeStateCopyWithImpl<$Res, AppModeState>;
  @useResult
  $Res call({AppModeEnum mode});
}

/// @nodoc
class _$AppModeStateCopyWithImpl<$Res, $Val extends AppModeState>
    implements $AppModeStateCopyWith<$Res> {
  _$AppModeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppModeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AppModeEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppModeStateImplCopyWith<$Res>
    implements $AppModeStateCopyWith<$Res> {
  factory _$$AppModeStateImplCopyWith(
          _$AppModeStateImpl value, $Res Function(_$AppModeStateImpl) then) =
      __$$AppModeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppModeEnum mode});
}

/// @nodoc
class __$$AppModeStateImplCopyWithImpl<$Res>
    extends _$AppModeStateCopyWithImpl<$Res, _$AppModeStateImpl>
    implements _$$AppModeStateImplCopyWith<$Res> {
  __$$AppModeStateImplCopyWithImpl(
      _$AppModeStateImpl _value, $Res Function(_$AppModeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppModeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
  }) {
    return _then(_$AppModeStateImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AppModeEnum,
    ));
  }
}

/// @nodoc

class _$AppModeStateImpl implements _AppModeState {
  const _$AppModeStateImpl({this.mode = AppModeEnum.defaultMode});

  @override
  @JsonKey()
  final AppModeEnum mode;

  @override
  String toString() {
    return 'AppModeState(mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppModeStateImpl &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode);

  /// Create a copy of AppModeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppModeStateImplCopyWith<_$AppModeStateImpl> get copyWith =>
      __$$AppModeStateImplCopyWithImpl<_$AppModeStateImpl>(this, _$identity);
}

abstract class _AppModeState implements AppModeState {
  const factory _AppModeState({final AppModeEnum mode}) = _$AppModeStateImpl;

  @override
  AppModeEnum get mode;

  /// Create a copy of AppModeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppModeStateImplCopyWith<_$AppModeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
