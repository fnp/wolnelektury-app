// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {

 bool get isLoadingHints; List<HintModel> get hints; String? get query;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.isLoadingHints, isLoadingHints) || other.isLoadingHints == isLoadingHints)&&const DeepCollectionEquality().equals(other.hints, hints)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingHints,const DeepCollectionEquality().hash(hints),query);

@override
String toString() {
  return 'SearchState(isLoadingHints: $isLoadingHints, hints: $hints, query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingHints, List<HintModel> hints, String? query
});




}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingHints = null,Object? hints = null,Object? query = freezed,}) {
  return _then(_self.copyWith(
isLoadingHints: null == isLoadingHints ? _self.isLoadingHints : isLoadingHints // ignore: cast_nullable_to_non_nullable
as bool,hints: null == hints ? _self.hints : hints // ignore: cast_nullable_to_non_nullable
as List<HintModel>,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.isLoadingHints = false, final  List<HintModel> hints = const [], this.query}): _hints = hints;
  

@override@JsonKey() final  bool isLoadingHints;
 final  List<HintModel> _hints;
@override@JsonKey() List<HintModel> get hints {
  if (_hints is EqualUnmodifiableListView) return _hints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hints);
}

@override final  String? query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.isLoadingHints, isLoadingHints) || other.isLoadingHints == isLoadingHints)&&const DeepCollectionEquality().equals(other._hints, _hints)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingHints,const DeepCollectionEquality().hash(_hints),query);

@override
String toString() {
  return 'SearchState(isLoadingHints: $isLoadingHints, hints: $hints, query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingHints, List<HintModel> hints, String? query
});




}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingHints = null,Object? hints = null,Object? query = freezed,}) {
  return _then(_SearchState(
isLoadingHints: null == isLoadingHints ? _self.isLoadingHints : isLoadingHints // ignore: cast_nullable_to_non_nullable
as bool,hints: null == hints ? _self._hints : hints // ignore: cast_nullable_to_non_nullable
as List<HintModel>,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
