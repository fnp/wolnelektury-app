// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'books_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BooksState {

 List<BookModel> get books; List<TagModel> get filterTags; SortEnum get sort; ApiResponsePagination get pagination; bool get isLoading; bool get isLoadingMore; bool? get isSuccess;
/// Create a copy of BooksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BooksStateCopyWith<BooksState> get copyWith => _$BooksStateCopyWithImpl<BooksState>(this as BooksState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BooksState&&const DeepCollectionEquality().equals(other.books, books)&&const DeepCollectionEquality().equals(other.filterTags, filterTags)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(books),const DeepCollectionEquality().hash(filterTags),sort,pagination,isLoading,isLoadingMore,isSuccess);

@override
String toString() {
  return 'BooksState(books: $books, filterTags: $filterTags, sort: $sort, pagination: $pagination, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class $BooksStateCopyWith<$Res>  {
  factory $BooksStateCopyWith(BooksState value, $Res Function(BooksState) _then) = _$BooksStateCopyWithImpl;
@useResult
$Res call({
 List<BookModel> books, List<TagModel> filterTags, SortEnum sort, ApiResponsePagination pagination, bool isLoading, bool isLoadingMore, bool? isSuccess
});


$ApiResponsePaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class _$BooksStateCopyWithImpl<$Res>
    implements $BooksStateCopyWith<$Res> {
  _$BooksStateCopyWithImpl(this._self, this._then);

  final BooksState _self;
  final $Res Function(BooksState) _then;

/// Create a copy of BooksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? books = null,Object? filterTags = null,Object? sort = null,Object? pagination = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isSuccess = freezed,}) {
  return _then(_self.copyWith(
books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<BookModel>,filterTags: null == filterTags ? _self.filterTags : filterTags // ignore: cast_nullable_to_non_nullable
as List<TagModel>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SortEnum,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of BooksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// @nodoc


class _BooksState implements BooksState {
  const _BooksState({final  List<BookModel> books = const [], final  List<TagModel> filterTags = const [], this.sort = SortEnum.alphabeticallyAsc, this.pagination = const ApiResponsePagination(), this.isLoading = false, this.isLoadingMore = false, this.isSuccess}): _books = books,_filterTags = filterTags;
  

 final  List<BookModel> _books;
@override@JsonKey() List<BookModel> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

 final  List<TagModel> _filterTags;
@override@JsonKey() List<TagModel> get filterTags {
  if (_filterTags is EqualUnmodifiableListView) return _filterTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filterTags);
}

@override@JsonKey() final  SortEnum sort;
@override@JsonKey() final  ApiResponsePagination pagination;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override final  bool? isSuccess;

/// Create a copy of BooksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BooksStateCopyWith<_BooksState> get copyWith => __$BooksStateCopyWithImpl<_BooksState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BooksState&&const DeepCollectionEquality().equals(other._books, _books)&&const DeepCollectionEquality().equals(other._filterTags, _filterTags)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_books),const DeepCollectionEquality().hash(_filterTags),sort,pagination,isLoading,isLoadingMore,isSuccess);

@override
String toString() {
  return 'BooksState(books: $books, filterTags: $filterTags, sort: $sort, pagination: $pagination, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class _$BooksStateCopyWith<$Res> implements $BooksStateCopyWith<$Res> {
  factory _$BooksStateCopyWith(_BooksState value, $Res Function(_BooksState) _then) = __$BooksStateCopyWithImpl;
@override @useResult
$Res call({
 List<BookModel> books, List<TagModel> filterTags, SortEnum sort, ApiResponsePagination pagination, bool isLoading, bool isLoadingMore, bool? isSuccess
});


@override $ApiResponsePaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class __$BooksStateCopyWithImpl<$Res>
    implements _$BooksStateCopyWith<$Res> {
  __$BooksStateCopyWithImpl(this._self, this._then);

  final _BooksState _self;
  final $Res Function(_BooksState) _then;

/// Create a copy of BooksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? books = null,Object? filterTags = null,Object? sort = null,Object? pagination = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isSuccess = freezed,}) {
  return _then(_BooksState(
books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<BookModel>,filterTags: null == filterTags ? _self._filterTags : filterTags // ignore: cast_nullable_to_non_nullable
as List<TagModel>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SortEnum,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of BooksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

// dart format on
