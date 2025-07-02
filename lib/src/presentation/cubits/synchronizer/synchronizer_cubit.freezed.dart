// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'synchronizer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SynchronizerState {

 bool get isLoading; bool get isError;
/// Create a copy of SynchronizerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SynchronizerStateCopyWith<SynchronizerState> get copyWith => _$SynchronizerStateCopyWithImpl<SynchronizerState>(this as SynchronizerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SynchronizerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isError);

@override
String toString() {
  return 'SynchronizerState(isLoading: $isLoading, isError: $isError)';
}


}

/// @nodoc
abstract mixin class $SynchronizerStateCopyWith<$Res>  {
  factory $SynchronizerStateCopyWith(SynchronizerState value, $Res Function(SynchronizerState) _then) = _$SynchronizerStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isError
});




}
/// @nodoc
class _$SynchronizerStateCopyWithImpl<$Res>
    implements $SynchronizerStateCopyWith<$Res> {
  _$SynchronizerStateCopyWithImpl(this._self, this._then);

  final SynchronizerState _self;
  final $Res Function(SynchronizerState) _then;

/// Create a copy of SynchronizerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isError = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _SynchronizerState implements SynchronizerState {
  const _SynchronizerState({this.isLoading = false, this.isError = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isError;

/// Create a copy of SynchronizerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SynchronizerStateCopyWith<_SynchronizerState> get copyWith => __$SynchronizerStateCopyWithImpl<_SynchronizerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SynchronizerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isError);

@override
String toString() {
  return 'SynchronizerState(isLoading: $isLoading, isError: $isError)';
}


}

/// @nodoc
abstract mixin class _$SynchronizerStateCopyWith<$Res> implements $SynchronizerStateCopyWith<$Res> {
  factory _$SynchronizerStateCopyWith(_SynchronizerState value, $Res Function(_SynchronizerState) _then) = __$SynchronizerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isError
});




}
/// @nodoc
class __$SynchronizerStateCopyWithImpl<$Res>
    implements _$SynchronizerStateCopyWith<$Res> {
  __$SynchronizerStateCopyWithImpl(this._self, this._then);

  final _SynchronizerState _self;
  final $Res Function(_SynchronizerState) _then;

/// Create a copy of SynchronizerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isError = null,}) {
  return _then(_SynchronizerState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
