// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'minimized_player_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MinimizedPlayerState {

 double get maxWidth; double get maxHeight; Offset? get position;
/// Create a copy of MinimizedPlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MinimizedPlayerStateCopyWith<MinimizedPlayerState> get copyWith => _$MinimizedPlayerStateCopyWithImpl<MinimizedPlayerState>(this as MinimizedPlayerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MinimizedPlayerState&&(identical(other.maxWidth, maxWidth) || other.maxWidth == maxWidth)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,maxWidth,maxHeight,position);

@override
String toString() {
  return 'MinimizedPlayerState(maxWidth: $maxWidth, maxHeight: $maxHeight, position: $position)';
}


}

/// @nodoc
abstract mixin class $MinimizedPlayerStateCopyWith<$Res>  {
  factory $MinimizedPlayerStateCopyWith(MinimizedPlayerState value, $Res Function(MinimizedPlayerState) _then) = _$MinimizedPlayerStateCopyWithImpl;
@useResult
$Res call({
 double maxWidth, double maxHeight, Offset? position
});




}
/// @nodoc
class _$MinimizedPlayerStateCopyWithImpl<$Res>
    implements $MinimizedPlayerStateCopyWith<$Res> {
  _$MinimizedPlayerStateCopyWithImpl(this._self, this._then);

  final MinimizedPlayerState _self;
  final $Res Function(MinimizedPlayerState) _then;

/// Create a copy of MinimizedPlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxWidth = null,Object? maxHeight = null,Object? position = freezed,}) {
  return _then(_self.copyWith(
maxWidth: null == maxWidth ? _self.maxWidth : maxWidth // ignore: cast_nullable_to_non_nullable
as double,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as double,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset?,
  ));
}

}


/// @nodoc


class _MinimizedPlayerState implements MinimizedPlayerState {
  const _MinimizedPlayerState({required this.maxWidth, required this.maxHeight, this.position});
  

@override final  double maxWidth;
@override final  double maxHeight;
@override final  Offset? position;

/// Create a copy of MinimizedPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MinimizedPlayerStateCopyWith<_MinimizedPlayerState> get copyWith => __$MinimizedPlayerStateCopyWithImpl<_MinimizedPlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MinimizedPlayerState&&(identical(other.maxWidth, maxWidth) || other.maxWidth == maxWidth)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,maxWidth,maxHeight,position);

@override
String toString() {
  return 'MinimizedPlayerState(maxWidth: $maxWidth, maxHeight: $maxHeight, position: $position)';
}


}

/// @nodoc
abstract mixin class _$MinimizedPlayerStateCopyWith<$Res> implements $MinimizedPlayerStateCopyWith<$Res> {
  factory _$MinimizedPlayerStateCopyWith(_MinimizedPlayerState value, $Res Function(_MinimizedPlayerState) _then) = __$MinimizedPlayerStateCopyWithImpl;
@override @useResult
$Res call({
 double maxWidth, double maxHeight, Offset? position
});




}
/// @nodoc
class __$MinimizedPlayerStateCopyWithImpl<$Res>
    implements _$MinimizedPlayerStateCopyWith<$Res> {
  __$MinimizedPlayerStateCopyWithImpl(this._self, this._then);

  final _MinimizedPlayerState _self;
  final $Res Function(_MinimizedPlayerState) _then;

/// Create a copy of MinimizedPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxWidth = null,Object? maxHeight = null,Object? position = freezed,}) {
  return _then(_MinimizedPlayerState(
maxWidth: null == maxWidth ? _self.maxWidth : maxWidth // ignore: cast_nullable_to_non_nullable
as double,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as double,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset?,
  ));
}


}

// dart format on
