// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectivityState {

 ConnectivityResult? get result; bool get showAlert; bool get disableNavigation;
/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectivityStateCopyWith<ConnectivityState> get copyWith => _$ConnectivityStateCopyWithImpl<ConnectivityState>(this as ConnectivityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityState&&(identical(other.result, result) || other.result == result)&&(identical(other.showAlert, showAlert) || other.showAlert == showAlert)&&(identical(other.disableNavigation, disableNavigation) || other.disableNavigation == disableNavigation));
}


@override
int get hashCode => Object.hash(runtimeType,result,showAlert,disableNavigation);

@override
String toString() {
  return 'ConnectivityState(result: $result, showAlert: $showAlert, disableNavigation: $disableNavigation)';
}


}

/// @nodoc
abstract mixin class $ConnectivityStateCopyWith<$Res>  {
  factory $ConnectivityStateCopyWith(ConnectivityState value, $Res Function(ConnectivityState) _then) = _$ConnectivityStateCopyWithImpl;
@useResult
$Res call({
 ConnectivityResult? result, bool showAlert, bool disableNavigation
});




}
/// @nodoc
class _$ConnectivityStateCopyWithImpl<$Res>
    implements $ConnectivityStateCopyWith<$Res> {
  _$ConnectivityStateCopyWithImpl(this._self, this._then);

  final ConnectivityState _self;
  final $Res Function(ConnectivityState) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,Object? showAlert = null,Object? disableNavigation = null,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ConnectivityResult?,showAlert: null == showAlert ? _self.showAlert : showAlert // ignore: cast_nullable_to_non_nullable
as bool,disableNavigation: null == disableNavigation ? _self.disableNavigation : disableNavigation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _ConnectivityState implements ConnectivityState {
  const _ConnectivityState({this.result, this.showAlert = false, this.disableNavigation = false});
  

@override final  ConnectivityResult? result;
@override@JsonKey() final  bool showAlert;
@override@JsonKey() final  bool disableNavigation;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectivityStateCopyWith<_ConnectivityState> get copyWith => __$ConnectivityStateCopyWithImpl<_ConnectivityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectivityState&&(identical(other.result, result) || other.result == result)&&(identical(other.showAlert, showAlert) || other.showAlert == showAlert)&&(identical(other.disableNavigation, disableNavigation) || other.disableNavigation == disableNavigation));
}


@override
int get hashCode => Object.hash(runtimeType,result,showAlert,disableNavigation);

@override
String toString() {
  return 'ConnectivityState(result: $result, showAlert: $showAlert, disableNavigation: $disableNavigation)';
}


}

/// @nodoc
abstract mixin class _$ConnectivityStateCopyWith<$Res> implements $ConnectivityStateCopyWith<$Res> {
  factory _$ConnectivityStateCopyWith(_ConnectivityState value, $Res Function(_ConnectivityState) _then) = __$ConnectivityStateCopyWithImpl;
@override @useResult
$Res call({
 ConnectivityResult? result, bool showAlert, bool disableNavigation
});




}
/// @nodoc
class __$ConnectivityStateCopyWithImpl<$Res>
    implements _$ConnectivityStateCopyWith<$Res> {
  __$ConnectivityStateCopyWithImpl(this._self, this._then);

  final _ConnectivityState _self;
  final $Res Function(_ConnectivityState) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,Object? showAlert = null,Object? disableNavigation = null,}) {
  return _then(_ConnectivityState(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ConnectivityResult?,showAlert: null == showAlert ? _self.showAlert : showAlert // ignore: cast_nullable_to_non_nullable
as bool,disableNavigation: null == disableNavigation ? _self.disableNavigation : disableNavigation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
