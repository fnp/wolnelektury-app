// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scroll_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScrollState {

 dynamic get showAppBar;
/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrollStateCopyWith<ScrollState> get copyWith => _$ScrollStateCopyWithImpl<ScrollState>(this as ScrollState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrollState&&const DeepCollectionEquality().equals(other.showAppBar, showAppBar));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(showAppBar));

@override
String toString() {
  return 'ScrollState(showAppBar: $showAppBar)';
}


}

/// @nodoc
abstract mixin class $ScrollStateCopyWith<$Res>  {
  factory $ScrollStateCopyWith(ScrollState value, $Res Function(ScrollState) _then) = _$ScrollStateCopyWithImpl;
@useResult
$Res call({
 dynamic showAppBar
});




}
/// @nodoc
class _$ScrollStateCopyWithImpl<$Res>
    implements $ScrollStateCopyWith<$Res> {
  _$ScrollStateCopyWithImpl(this._self, this._then);

  final ScrollState _self;
  final $Res Function(ScrollState) _then;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showAppBar = freezed,}) {
  return _then(_self.copyWith(
showAppBar: freezed == showAppBar ? _self.showAppBar : showAppBar // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc


class _ScrollState implements ScrollState {
  const _ScrollState({this.showAppBar = true});
  

@override@JsonKey() final  dynamic showAppBar;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrollStateCopyWith<_ScrollState> get copyWith => __$ScrollStateCopyWithImpl<_ScrollState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrollState&&const DeepCollectionEquality().equals(other.showAppBar, showAppBar));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(showAppBar));

@override
String toString() {
  return 'ScrollState(showAppBar: $showAppBar)';
}


}

/// @nodoc
abstract mixin class _$ScrollStateCopyWith<$Res> implements $ScrollStateCopyWith<$Res> {
  factory _$ScrollStateCopyWith(_ScrollState value, $Res Function(_ScrollState) _then) = __$ScrollStateCopyWithImpl;
@override @useResult
$Res call({
 dynamic showAppBar
});




}
/// @nodoc
class __$ScrollStateCopyWithImpl<$Res>
    implements _$ScrollStateCopyWith<$Res> {
  __$ScrollStateCopyWithImpl(this._self, this._then);

  final _ScrollState _self;
  final $Res Function(_ScrollState) _then;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showAppBar = freezed,}) {
  return _then(_ScrollState(
showAppBar: freezed == showAppBar ? _self.showAppBar : showAppBar // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
