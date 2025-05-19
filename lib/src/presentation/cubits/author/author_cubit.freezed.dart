// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthorState {
  bool get isLoading => throw _privateConstructorUsedError;
  DetailedAuthorModel? get author =>
      throw _privateConstructorUsedError; // Lists of books by the author
  bool get isLoadingAuthorsBooks => throw _privateConstructorUsedError;
  List<BookModel> get authorsBooks => throw _privateConstructorUsedError;
  ApiResponsePagination get authorsBooksPagination =>
      throw _privateConstructorUsedError; // Lists of books translated by the author
  bool get isLoadingAuthorsTranslations => throw _privateConstructorUsedError;
  List<BookModel> get authorsTranslations => throw _privateConstructorUsedError;
  ApiResponsePagination get authorsTranslationsPagination =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthorStateCopyWith<AuthorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorStateCopyWith<$Res> {
  factory $AuthorStateCopyWith(
          AuthorState value, $Res Function(AuthorState) then) =
      _$AuthorStateCopyWithImpl<$Res, AuthorState>;
  @useResult
  $Res call(
      {bool isLoading,
      DetailedAuthorModel? author,
      bool isLoadingAuthorsBooks,
      List<BookModel> authorsBooks,
      ApiResponsePagination authorsBooksPagination,
      bool isLoadingAuthorsTranslations,
      List<BookModel> authorsTranslations,
      ApiResponsePagination authorsTranslationsPagination});

  $DetailedAuthorModelCopyWith<$Res>? get author;
  $ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination;
  $ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination;
}

/// @nodoc
class _$AuthorStateCopyWithImpl<$Res, $Val extends AuthorState>
    implements $AuthorStateCopyWith<$Res> {
  _$AuthorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? author = freezed,
    Object? isLoadingAuthorsBooks = null,
    Object? authorsBooks = null,
    Object? authorsBooksPagination = null,
    Object? isLoadingAuthorsTranslations = null,
    Object? authorsTranslations = null,
    Object? authorsTranslationsPagination = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as DetailedAuthorModel?,
      isLoadingAuthorsBooks: null == isLoadingAuthorsBooks
          ? _value.isLoadingAuthorsBooks
          : isLoadingAuthorsBooks // ignore: cast_nullable_to_non_nullable
              as bool,
      authorsBooks: null == authorsBooks
          ? _value.authorsBooks
          : authorsBooks // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
      authorsBooksPagination: null == authorsBooksPagination
          ? _value.authorsBooksPagination
          : authorsBooksPagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      isLoadingAuthorsTranslations: null == isLoadingAuthorsTranslations
          ? _value.isLoadingAuthorsTranslations
          : isLoadingAuthorsTranslations // ignore: cast_nullable_to_non_nullable
              as bool,
      authorsTranslations: null == authorsTranslations
          ? _value.authorsTranslations
          : authorsTranslations // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
      authorsTranslationsPagination: null == authorsTranslationsPagination
          ? _value.authorsTranslationsPagination
          : authorsTranslationsPagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
    ) as $Val);
  }

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DetailedAuthorModelCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $DetailedAuthorModelCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination {
    return $ApiResponsePaginationCopyWith<$Res>(_value.authorsBooksPagination,
        (value) {
      return _then(_value.copyWith(authorsBooksPagination: value) as $Val);
    });
  }

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination {
    return $ApiResponsePaginationCopyWith<$Res>(
        _value.authorsTranslationsPagination, (value) {
      return _then(
          _value.copyWith(authorsTranslationsPagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthorStateImplCopyWith<$Res>
    implements $AuthorStateCopyWith<$Res> {
  factory _$$AuthorStateImplCopyWith(
          _$AuthorStateImpl value, $Res Function(_$AuthorStateImpl) then) =
      __$$AuthorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      DetailedAuthorModel? author,
      bool isLoadingAuthorsBooks,
      List<BookModel> authorsBooks,
      ApiResponsePagination authorsBooksPagination,
      bool isLoadingAuthorsTranslations,
      List<BookModel> authorsTranslations,
      ApiResponsePagination authorsTranslationsPagination});

  @override
  $DetailedAuthorModelCopyWith<$Res>? get author;
  @override
  $ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination;
  @override
  $ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination;
}

/// @nodoc
class __$$AuthorStateImplCopyWithImpl<$Res>
    extends _$AuthorStateCopyWithImpl<$Res, _$AuthorStateImpl>
    implements _$$AuthorStateImplCopyWith<$Res> {
  __$$AuthorStateImplCopyWithImpl(
      _$AuthorStateImpl _value, $Res Function(_$AuthorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? author = freezed,
    Object? isLoadingAuthorsBooks = null,
    Object? authorsBooks = null,
    Object? authorsBooksPagination = null,
    Object? isLoadingAuthorsTranslations = null,
    Object? authorsTranslations = null,
    Object? authorsTranslationsPagination = null,
  }) {
    return _then(_$AuthorStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as DetailedAuthorModel?,
      isLoadingAuthorsBooks: null == isLoadingAuthorsBooks
          ? _value.isLoadingAuthorsBooks
          : isLoadingAuthorsBooks // ignore: cast_nullable_to_non_nullable
              as bool,
      authorsBooks: null == authorsBooks
          ? _value._authorsBooks
          : authorsBooks // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
      authorsBooksPagination: null == authorsBooksPagination
          ? _value.authorsBooksPagination
          : authorsBooksPagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      isLoadingAuthorsTranslations: null == isLoadingAuthorsTranslations
          ? _value.isLoadingAuthorsTranslations
          : isLoadingAuthorsTranslations // ignore: cast_nullable_to_non_nullable
              as bool,
      authorsTranslations: null == authorsTranslations
          ? _value._authorsTranslations
          : authorsTranslations // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
      authorsTranslationsPagination: null == authorsTranslationsPagination
          ? _value.authorsTranslationsPagination
          : authorsTranslationsPagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
    ));
  }
}

/// @nodoc

class _$AuthorStateImpl implements _AuthorState {
  const _$AuthorStateImpl(
      {this.isLoading = false,
      this.author,
      this.isLoadingAuthorsBooks = false,
      final List<BookModel> authorsBooks = const [],
      this.authorsBooksPagination = const ApiResponsePagination(),
      this.isLoadingAuthorsTranslations = false,
      final List<BookModel> authorsTranslations = const [],
      this.authorsTranslationsPagination = const ApiResponsePagination()})
      : _authorsBooks = authorsBooks,
        _authorsTranslations = authorsTranslations;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final DetailedAuthorModel? author;
// Lists of books by the author
  @override
  @JsonKey()
  final bool isLoadingAuthorsBooks;
  final List<BookModel> _authorsBooks;
  @override
  @JsonKey()
  List<BookModel> get authorsBooks {
    if (_authorsBooks is EqualUnmodifiableListView) return _authorsBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorsBooks);
  }

  @override
  @JsonKey()
  final ApiResponsePagination authorsBooksPagination;
// Lists of books translated by the author
  @override
  @JsonKey()
  final bool isLoadingAuthorsTranslations;
  final List<BookModel> _authorsTranslations;
  @override
  @JsonKey()
  List<BookModel> get authorsTranslations {
    if (_authorsTranslations is EqualUnmodifiableListView)
      return _authorsTranslations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorsTranslations);
  }

  @override
  @JsonKey()
  final ApiResponsePagination authorsTranslationsPagination;

  @override
  String toString() {
    return 'AuthorState(isLoading: $isLoading, author: $author, isLoadingAuthorsBooks: $isLoadingAuthorsBooks, authorsBooks: $authorsBooks, authorsBooksPagination: $authorsBooksPagination, isLoadingAuthorsTranslations: $isLoadingAuthorsTranslations, authorsTranslations: $authorsTranslations, authorsTranslationsPagination: $authorsTranslationsPagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.isLoadingAuthorsBooks, isLoadingAuthorsBooks) ||
                other.isLoadingAuthorsBooks == isLoadingAuthorsBooks) &&
            const DeepCollectionEquality()
                .equals(other._authorsBooks, _authorsBooks) &&
            (identical(other.authorsBooksPagination, authorsBooksPagination) ||
                other.authorsBooksPagination == authorsBooksPagination) &&
            (identical(other.isLoadingAuthorsTranslations,
                    isLoadingAuthorsTranslations) ||
                other.isLoadingAuthorsTranslations ==
                    isLoadingAuthorsTranslations) &&
            const DeepCollectionEquality()
                .equals(other._authorsTranslations, _authorsTranslations) &&
            (identical(other.authorsTranslationsPagination,
                    authorsTranslationsPagination) ||
                other.authorsTranslationsPagination ==
                    authorsTranslationsPagination));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      author,
      isLoadingAuthorsBooks,
      const DeepCollectionEquality().hash(_authorsBooks),
      authorsBooksPagination,
      isLoadingAuthorsTranslations,
      const DeepCollectionEquality().hash(_authorsTranslations),
      authorsTranslationsPagination);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorStateImplCopyWith<_$AuthorStateImpl> get copyWith =>
      __$$AuthorStateImplCopyWithImpl<_$AuthorStateImpl>(this, _$identity);
}

abstract class _AuthorState implements AuthorState {
  const factory _AuthorState(
          {final bool isLoading,
          final DetailedAuthorModel? author,
          final bool isLoadingAuthorsBooks,
          final List<BookModel> authorsBooks,
          final ApiResponsePagination authorsBooksPagination,
          final bool isLoadingAuthorsTranslations,
          final List<BookModel> authorsTranslations,
          final ApiResponsePagination authorsTranslationsPagination}) =
      _$AuthorStateImpl;

  @override
  bool get isLoading;
  @override
  DetailedAuthorModel? get author; // Lists of books by the author
  @override
  bool get isLoadingAuthorsBooks;
  @override
  List<BookModel> get authorsBooks;
  @override
  ApiResponsePagination
      get authorsBooksPagination; // Lists of books translated by the author
  @override
  bool get isLoadingAuthorsTranslations;
  @override
  List<BookModel> get authorsTranslations;
  @override
  ApiResponsePagination get authorsTranslationsPagination;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorStateImplCopyWith<_$AuthorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
