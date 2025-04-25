// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'books_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BooksState {
  List<BookModel> get books => throw _privateConstructorUsedError;
  List<TagModel> get filterTags => throw _privateConstructorUsedError;
  SortEnum get sort => throw _privateConstructorUsedError;
  ApiResponsePagination get pagination => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;

  /// Create a copy of BooksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BooksStateCopyWith<BooksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BooksStateCopyWith<$Res> {
  factory $BooksStateCopyWith(
          BooksState value, $Res Function(BooksState) then) =
      _$BooksStateCopyWithImpl<$Res, BooksState>;
  @useResult
  $Res call(
      {List<BookModel> books,
      List<TagModel> filterTags,
      SortEnum sort,
      ApiResponsePagination pagination,
      bool isLoading,
      bool isLoadingMore,
      bool? isSuccess});

  $ApiResponsePaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$BooksStateCopyWithImpl<$Res, $Val extends BooksState>
    implements $BooksStateCopyWith<$Res> {
  _$BooksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BooksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? filterTags = null,
    Object? sort = null,
    Object? pagination = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? isSuccess = freezed,
  }) {
    return _then(_value.copyWith(
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
      filterTags: null == filterTags
          ? _value.filterTags
          : filterTags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as SortEnum,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: freezed == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of BooksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponsePaginationCopyWith<$Res> get pagination {
    return $ApiResponsePaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BooksStateImplCopyWith<$Res>
    implements $BooksStateCopyWith<$Res> {
  factory _$$BooksStateImplCopyWith(
          _$BooksStateImpl value, $Res Function(_$BooksStateImpl) then) =
      __$$BooksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BookModel> books,
      List<TagModel> filterTags,
      SortEnum sort,
      ApiResponsePagination pagination,
      bool isLoading,
      bool isLoadingMore,
      bool? isSuccess});

  @override
  $ApiResponsePaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$BooksStateImplCopyWithImpl<$Res>
    extends _$BooksStateCopyWithImpl<$Res, _$BooksStateImpl>
    implements _$$BooksStateImplCopyWith<$Res> {
  __$$BooksStateImplCopyWithImpl(
      _$BooksStateImpl _value, $Res Function(_$BooksStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BooksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? filterTags = null,
    Object? sort = null,
    Object? pagination = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? isSuccess = freezed,
  }) {
    return _then(_$BooksStateImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
      filterTags: null == filterTags
          ? _value._filterTags
          : filterTags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as SortEnum,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: freezed == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$BooksStateImpl implements _BooksState {
  const _$BooksStateImpl(
      {final List<BookModel> books = const [],
      final List<TagModel> filterTags = const [],
      this.sort = SortEnum.alphabeticallyAsc,
      this.pagination = const ApiResponsePagination(),
      this.isLoading = false,
      this.isLoadingMore = false,
      this.isSuccess})
      : _books = books,
        _filterTags = filterTags;

  final List<BookModel> _books;
  @override
  @JsonKey()
  List<BookModel> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  final List<TagModel> _filterTags;
  @override
  @JsonKey()
  List<TagModel> get filterTags {
    if (_filterTags is EqualUnmodifiableListView) return _filterTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterTags);
  }

  @override
  @JsonKey()
  final SortEnum sort;
  @override
  @JsonKey()
  final ApiResponsePagination pagination;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final bool? isSuccess;

  @override
  String toString() {
    return 'BooksState(books: $books, filterTags: $filterTags, sort: $sort, pagination: $pagination, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BooksStateImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            const DeepCollectionEquality()
                .equals(other._filterTags, _filterTags) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_books),
      const DeepCollectionEquality().hash(_filterTags),
      sort,
      pagination,
      isLoading,
      isLoadingMore,
      isSuccess);

  /// Create a copy of BooksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BooksStateImplCopyWith<_$BooksStateImpl> get copyWith =>
      __$$BooksStateImplCopyWithImpl<_$BooksStateImpl>(this, _$identity);
}

abstract class _BooksState implements BooksState {
  const factory _BooksState(
      {final List<BookModel> books,
      final List<TagModel> filterTags,
      final SortEnum sort,
      final ApiResponsePagination pagination,
      final bool isLoading,
      final bool isLoadingMore,
      final bool? isSuccess}) = _$BooksStateImpl;

  @override
  List<BookModel> get books;
  @override
  List<TagModel> get filterTags;
  @override
  SortEnum get sort;
  @override
  ApiResponsePagination get pagination;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool? get isSuccess;

  /// Create a copy of BooksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BooksStateImplCopyWith<_$BooksStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
