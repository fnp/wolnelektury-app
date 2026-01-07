// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_mode_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppModeState {

 AppModeEnum get mode;
/// Create a copy of AppModeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppModeStateCopyWith<AppModeState> get copyWith => _$AppModeStateCopyWithImpl<AppModeState>(this as AppModeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppModeState&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AppModeState(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $AppModeStateCopyWith<$Res>  {
  factory $AppModeStateCopyWith(AppModeState value, $Res Function(AppModeState) _then) = _$AppModeStateCopyWithImpl;
@useResult
$Res call({
 AppModeEnum mode
});




}
/// @nodoc
class _$AppModeStateCopyWithImpl<$Res>
    implements $AppModeStateCopyWith<$Res> {
  _$AppModeStateCopyWithImpl(this._self, this._then);

  final AppModeState _self;
  final $Res Function(AppModeState) _then;

/// Create a copy of AppModeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppModeEnum,
  ));
}

}


/// @nodoc


class _AppModeState implements AppModeState {
  const _AppModeState({this.mode = AppModeEnum.defaultMode});
  

@override@JsonKey() final  AppModeEnum mode;

/// Create a copy of AppModeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppModeStateCopyWith<_AppModeState> get copyWith => __$AppModeStateCopyWithImpl<_AppModeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppModeState&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AppModeState(mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$AppModeStateCopyWith<$Res> implements $AppModeStateCopyWith<$Res> {
  factory _$AppModeStateCopyWith(_AppModeState value, $Res Function(_AppModeState) _then) = __$AppModeStateCopyWithImpl;
@override @useResult
$Res call({
 AppModeEnum mode
});




}
/// @nodoc
class __$AppModeStateCopyWithImpl<$Res>
    implements _$AppModeStateCopyWith<$Res> {
  __$AppModeStateCopyWithImpl(this._self, this._then);

  final _AppModeState _self;
  final $Res Function(_AppModeState) _then;

/// Create a copy of AppModeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(_AppModeState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppModeEnum,
  ));
}


}

// dart format on
