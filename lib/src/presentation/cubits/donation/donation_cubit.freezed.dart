// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonationState {

 bool get isLoading; bool get isSuccess;
/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationStateCopyWith<DonationState> get copyWith => _$DonationStateCopyWithImpl<DonationState>(this as DonationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSuccess);

@override
String toString() {
  return 'DonationState(isLoading: $isLoading, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class $DonationStateCopyWith<$Res>  {
  factory $DonationStateCopyWith(DonationState value, $Res Function(DonationState) _then) = _$DonationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSuccess
});




}
/// @nodoc
class _$DonationStateCopyWithImpl<$Res>
    implements $DonationStateCopyWith<$Res> {
  _$DonationStateCopyWithImpl(this._self, this._then);

  final DonationState _self;
  final $Res Function(DonationState) _then;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSuccess = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _DonationState implements DonationState {
  const _DonationState({this.isLoading = false, this.isSuccess = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DonationStateCopyWith<_DonationState> get copyWith => __$DonationStateCopyWithImpl<_DonationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSuccess);

@override
String toString() {
  return 'DonationState(isLoading: $isLoading, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class _$DonationStateCopyWith<$Res> implements $DonationStateCopyWith<$Res> {
  factory _$DonationStateCopyWith(_DonationState value, $Res Function(_DonationState) _then) = __$DonationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSuccess
});




}
/// @nodoc
class __$DonationStateCopyWithImpl<$Res>
    implements _$DonationStateCopyWith<$Res> {
  __$DonationStateCopyWithImpl(this._self, this._then);

  final _DonationState _self;
  final $Res Function(_DonationState) _then;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSuccess = null,}) {
  return _then(_DonationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
