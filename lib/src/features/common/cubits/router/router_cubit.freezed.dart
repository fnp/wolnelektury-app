// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'router_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouterState {

 String get location; String get previousLocation; MyLibraryEnum get lastEnteredMyLibraryEnum;
/// Create a copy of RouterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouterStateCopyWith<RouterState> get copyWith => _$RouterStateCopyWithImpl<RouterState>(this as RouterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouterState&&(identical(other.location, location) || other.location == location)&&(identical(other.previousLocation, previousLocation) || other.previousLocation == previousLocation)&&(identical(other.lastEnteredMyLibraryEnum, lastEnteredMyLibraryEnum) || other.lastEnteredMyLibraryEnum == lastEnteredMyLibraryEnum));
}


@override
int get hashCode => Object.hash(runtimeType,location,previousLocation,lastEnteredMyLibraryEnum);

@override
String toString() {
  return 'RouterState(location: $location, previousLocation: $previousLocation, lastEnteredMyLibraryEnum: $lastEnteredMyLibraryEnum)';
}


}

/// @nodoc
abstract mixin class $RouterStateCopyWith<$Res>  {
  factory $RouterStateCopyWith(RouterState value, $Res Function(RouterState) _then) = _$RouterStateCopyWithImpl;
@useResult
$Res call({
 String location, String previousLocation, MyLibraryEnum lastEnteredMyLibraryEnum
});




}
/// @nodoc
class _$RouterStateCopyWithImpl<$Res>
    implements $RouterStateCopyWith<$Res> {
  _$RouterStateCopyWithImpl(this._self, this._then);

  final RouterState _self;
  final $Res Function(RouterState) _then;

/// Create a copy of RouterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? previousLocation = null,Object? lastEnteredMyLibraryEnum = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,previousLocation: null == previousLocation ? _self.previousLocation : previousLocation // ignore: cast_nullable_to_non_nullable
as String,lastEnteredMyLibraryEnum: null == lastEnteredMyLibraryEnum ? _self.lastEnteredMyLibraryEnum : lastEnteredMyLibraryEnum // ignore: cast_nullable_to_non_nullable
as MyLibraryEnum,
  ));
}

}


/// @nodoc


class _RouterState implements RouterState {
  const _RouterState({required this.location, required this.previousLocation, this.lastEnteredMyLibraryEnum = MyLibraryEnum.audiobooks});
  

@override final  String location;
@override final  String previousLocation;
@override@JsonKey() final  MyLibraryEnum lastEnteredMyLibraryEnum;

/// Create a copy of RouterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouterStateCopyWith<_RouterState> get copyWith => __$RouterStateCopyWithImpl<_RouterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouterState&&(identical(other.location, location) || other.location == location)&&(identical(other.previousLocation, previousLocation) || other.previousLocation == previousLocation)&&(identical(other.lastEnteredMyLibraryEnum, lastEnteredMyLibraryEnum) || other.lastEnteredMyLibraryEnum == lastEnteredMyLibraryEnum));
}


@override
int get hashCode => Object.hash(runtimeType,location,previousLocation,lastEnteredMyLibraryEnum);

@override
String toString() {
  return 'RouterState(location: $location, previousLocation: $previousLocation, lastEnteredMyLibraryEnum: $lastEnteredMyLibraryEnum)';
}


}

/// @nodoc
abstract mixin class _$RouterStateCopyWith<$Res> implements $RouterStateCopyWith<$Res> {
  factory _$RouterStateCopyWith(_RouterState value, $Res Function(_RouterState) _then) = __$RouterStateCopyWithImpl;
@override @useResult
$Res call({
 String location, String previousLocation, MyLibraryEnum lastEnteredMyLibraryEnum
});




}
/// @nodoc
class __$RouterStateCopyWithImpl<$Res>
    implements _$RouterStateCopyWith<$Res> {
  __$RouterStateCopyWithImpl(this._self, this._then);

  final _RouterState _self;
  final $Res Function(_RouterState) _then;

/// Create a copy of RouterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? previousLocation = null,Object? lastEnteredMyLibraryEnum = null,}) {
  return _then(_RouterState(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,previousLocation: null == previousLocation ? _self.previousLocation : previousLocation // ignore: cast_nullable_to_non_nullable
as String,lastEnteredMyLibraryEnum: null == lastEnteredMyLibraryEnum ? _self.lastEnteredMyLibraryEnum : lastEnteredMyLibraryEnum // ignore: cast_nullable_to_non_nullable
as MyLibraryEnum,
  ));
}


}

// dart format on
