// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavouritesState {

// List of slugs
 List<String> get favourites; int get itemsPerPage;
/// Create a copy of FavouritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavouritesStateCopyWith<FavouritesState> get copyWith => _$FavouritesStateCopyWithImpl<FavouritesState>(this as FavouritesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavouritesState&&const DeepCollectionEquality().equals(other.favourites, favourites)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(favourites),itemsPerPage);

@override
String toString() {
  return 'FavouritesState(favourites: $favourites, itemsPerPage: $itemsPerPage)';
}


}

/// @nodoc
abstract mixin class $FavouritesStateCopyWith<$Res>  {
  factory $FavouritesStateCopyWith(FavouritesState value, $Res Function(FavouritesState) _then) = _$FavouritesStateCopyWithImpl;
@useResult
$Res call({
 List<String> favourites, int itemsPerPage
});




}
/// @nodoc
class _$FavouritesStateCopyWithImpl<$Res>
    implements $FavouritesStateCopyWith<$Res> {
  _$FavouritesStateCopyWithImpl(this._self, this._then);

  final FavouritesState _self;
  final $Res Function(FavouritesState) _then;

/// Create a copy of FavouritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favourites = null,Object? itemsPerPage = null,}) {
  return _then(_self.copyWith(
favourites: null == favourites ? _self.favourites : favourites // ignore: cast_nullable_to_non_nullable
as List<String>,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _FavouritesState implements FavouritesState {
  const _FavouritesState({final  List<String> favourites = const [], this.itemsPerPage = 10}): _favourites = favourites;
  

// List of slugs
 final  List<String> _favourites;
// List of slugs
@override@JsonKey() List<String> get favourites {
  if (_favourites is EqualUnmodifiableListView) return _favourites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favourites);
}

@override@JsonKey() final  int itemsPerPage;

/// Create a copy of FavouritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavouritesStateCopyWith<_FavouritesState> get copyWith => __$FavouritesStateCopyWithImpl<_FavouritesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavouritesState&&const DeepCollectionEquality().equals(other._favourites, _favourites)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favourites),itemsPerPage);

@override
String toString() {
  return 'FavouritesState(favourites: $favourites, itemsPerPage: $itemsPerPage)';
}


}

/// @nodoc
abstract mixin class _$FavouritesStateCopyWith<$Res> implements $FavouritesStateCopyWith<$Res> {
  factory _$FavouritesStateCopyWith(_FavouritesState value, $Res Function(_FavouritesState) _then) = __$FavouritesStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> favourites, int itemsPerPage
});




}
/// @nodoc
class __$FavouritesStateCopyWithImpl<$Res>
    implements _$FavouritesStateCopyWith<$Res> {
  __$FavouritesStateCopyWithImpl(this._self, this._then);

  final _FavouritesState _self;
  final $Res Function(_FavouritesState) _then;

/// Create a copy of FavouritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favourites = null,Object? itemsPerPage = null,}) {
  return _then(_FavouritesState(
favourites: null == favourites ? _self._favourites : favourites // ignore: cast_nullable_to_non_nullable
as List<String>,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
