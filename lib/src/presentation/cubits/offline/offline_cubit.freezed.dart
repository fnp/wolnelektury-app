// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OfflineState {

 bool get isLoading; List<OfflineBookModel> get books;
/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineStateCopyWith<OfflineState> get copyWith => _$OfflineStateCopyWithImpl<OfflineState>(this as OfflineState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.books, books));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(books));

@override
String toString() {
  return 'OfflineState(isLoading: $isLoading, books: $books)';
}


}

/// @nodoc
abstract mixin class $OfflineStateCopyWith<$Res>  {
  factory $OfflineStateCopyWith(OfflineState value, $Res Function(OfflineState) _then) = _$OfflineStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<OfflineBookModel> books
});




}
/// @nodoc
class _$OfflineStateCopyWithImpl<$Res>
    implements $OfflineStateCopyWith<$Res> {
  _$OfflineStateCopyWithImpl(this._self, this._then);

  final OfflineState _self;
  final $Res Function(OfflineState) _then;

/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? books = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<OfflineBookModel>,
  ));
}

}


/// @nodoc


class _OfflineState implements OfflineState {
  const _OfflineState({this.isLoading = false, final  List<OfflineBookModel> books = const []}): _books = books;
  

@override@JsonKey() final  bool isLoading;
 final  List<OfflineBookModel> _books;
@override@JsonKey() List<OfflineBookModel> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}


/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineStateCopyWith<_OfflineState> get copyWith => __$OfflineStateCopyWithImpl<_OfflineState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._books, _books));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_books));

@override
String toString() {
  return 'OfflineState(isLoading: $isLoading, books: $books)';
}


}

/// @nodoc
abstract mixin class _$OfflineStateCopyWith<$Res> implements $OfflineStateCopyWith<$Res> {
  factory _$OfflineStateCopyWith(_OfflineState value, $Res Function(_OfflineState) _then) = __$OfflineStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<OfflineBookModel> books
});




}
/// @nodoc
class __$OfflineStateCopyWithImpl<$Res>
    implements _$OfflineStateCopyWith<$Res> {
  __$OfflineStateCopyWithImpl(this._self, this._then);

  final _OfflineState _self;
  final $Res Function(_OfflineState) _then;

/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? books = null,}) {
  return _then(_OfflineState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<OfflineBookModel>,
  ));
}


}

// dart format on
