// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_book_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SingleBookState {

 bool get isLoading; BookModel? get book;
/// Create a copy of SingleBookState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleBookStateCopyWith<SingleBookState> get copyWith => _$SingleBookStateCopyWithImpl<SingleBookState>(this as SingleBookState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleBookState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.book, book) || other.book == book));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,book);

@override
String toString() {
  return 'SingleBookState(isLoading: $isLoading, book: $book)';
}


}

/// @nodoc
abstract mixin class $SingleBookStateCopyWith<$Res>  {
  factory $SingleBookStateCopyWith(SingleBookState value, $Res Function(SingleBookState) _then) = _$SingleBookStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, BookModel? book
});


$BookModelCopyWith<$Res>? get book;

}
/// @nodoc
class _$SingleBookStateCopyWithImpl<$Res>
    implements $SingleBookStateCopyWith<$Res> {
  _$SingleBookStateCopyWithImpl(this._self, this._then);

  final SingleBookState _self;
  final $Res Function(SingleBookState) _then;

/// Create a copy of SingleBookState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? book = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel?,
  ));
}
/// Create a copy of SingleBookState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res>? get book {
    if (_self.book == null) {
    return null;
  }

  return $BookModelCopyWith<$Res>(_self.book!, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// @nodoc


class _SingleBookState implements SingleBookState {
  const _SingleBookState({this.isLoading = false, this.book});
  

@override@JsonKey() final  bool isLoading;
@override final  BookModel? book;

/// Create a copy of SingleBookState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleBookStateCopyWith<_SingleBookState> get copyWith => __$SingleBookStateCopyWithImpl<_SingleBookState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleBookState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.book, book) || other.book == book));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,book);

@override
String toString() {
  return 'SingleBookState(isLoading: $isLoading, book: $book)';
}


}

/// @nodoc
abstract mixin class _$SingleBookStateCopyWith<$Res> implements $SingleBookStateCopyWith<$Res> {
  factory _$SingleBookStateCopyWith(_SingleBookState value, $Res Function(_SingleBookState) _then) = __$SingleBookStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, BookModel? book
});


@override $BookModelCopyWith<$Res>? get book;

}
/// @nodoc
class __$SingleBookStateCopyWithImpl<$Res>
    implements _$SingleBookStateCopyWith<$Res> {
  __$SingleBookStateCopyWithImpl(this._self, this._then);

  final _SingleBookState _self;
  final $Res Function(_SingleBookState) _then;

/// Create a copy of SingleBookState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? book = freezed,}) {
  return _then(_SingleBookState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel?,
  ));
}

/// Create a copy of SingleBookState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res>? get book {
    if (_self.book == null) {
    return null;
  }

  return $BookModelCopyWith<$Res>(_self.book!, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}

// dart format on
