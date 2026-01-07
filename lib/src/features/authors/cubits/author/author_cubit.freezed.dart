// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthorState {

 bool get isLoading; DetailedAuthorModel? get author;// Lists of books by the author
 bool get isLoadingAuthorsBooks; List<BookModel> get authorsBooks; ApiResponsePagination get authorsBooksPagination;// Lists of books translated by the author
 bool get isLoadingAuthorsTranslations; List<BookModel> get authorsTranslations; ApiResponsePagination get authorsTranslationsPagination;
/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorStateCopyWith<AuthorState> get copyWith => _$AuthorStateCopyWithImpl<AuthorState>(this as AuthorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthorState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.author, author) || other.author == author)&&(identical(other.isLoadingAuthorsBooks, isLoadingAuthorsBooks) || other.isLoadingAuthorsBooks == isLoadingAuthorsBooks)&&const DeepCollectionEquality().equals(other.authorsBooks, authorsBooks)&&(identical(other.authorsBooksPagination, authorsBooksPagination) || other.authorsBooksPagination == authorsBooksPagination)&&(identical(other.isLoadingAuthorsTranslations, isLoadingAuthorsTranslations) || other.isLoadingAuthorsTranslations == isLoadingAuthorsTranslations)&&const DeepCollectionEquality().equals(other.authorsTranslations, authorsTranslations)&&(identical(other.authorsTranslationsPagination, authorsTranslationsPagination) || other.authorsTranslationsPagination == authorsTranslationsPagination));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,author,isLoadingAuthorsBooks,const DeepCollectionEquality().hash(authorsBooks),authorsBooksPagination,isLoadingAuthorsTranslations,const DeepCollectionEquality().hash(authorsTranslations),authorsTranslationsPagination);

@override
String toString() {
  return 'AuthorState(isLoading: $isLoading, author: $author, isLoadingAuthorsBooks: $isLoadingAuthorsBooks, authorsBooks: $authorsBooks, authorsBooksPagination: $authorsBooksPagination, isLoadingAuthorsTranslations: $isLoadingAuthorsTranslations, authorsTranslations: $authorsTranslations, authorsTranslationsPagination: $authorsTranslationsPagination)';
}


}

/// @nodoc
abstract mixin class $AuthorStateCopyWith<$Res>  {
  factory $AuthorStateCopyWith(AuthorState value, $Res Function(AuthorState) _then) = _$AuthorStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, DetailedAuthorModel? author, bool isLoadingAuthorsBooks, List<BookModel> authorsBooks, ApiResponsePagination authorsBooksPagination, bool isLoadingAuthorsTranslations, List<BookModel> authorsTranslations, ApiResponsePagination authorsTranslationsPagination
});


$DetailedAuthorModelCopyWith<$Res>? get author;$ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination;$ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination;

}
/// @nodoc
class _$AuthorStateCopyWithImpl<$Res>
    implements $AuthorStateCopyWith<$Res> {
  _$AuthorStateCopyWithImpl(this._self, this._then);

  final AuthorState _self;
  final $Res Function(AuthorState) _then;

/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? author = freezed,Object? isLoadingAuthorsBooks = null,Object? authorsBooks = null,Object? authorsBooksPagination = null,Object? isLoadingAuthorsTranslations = null,Object? authorsTranslations = null,Object? authorsTranslationsPagination = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as DetailedAuthorModel?,isLoadingAuthorsBooks: null == isLoadingAuthorsBooks ? _self.isLoadingAuthorsBooks : isLoadingAuthorsBooks // ignore: cast_nullable_to_non_nullable
as bool,authorsBooks: null == authorsBooks ? _self.authorsBooks : authorsBooks // ignore: cast_nullable_to_non_nullable
as List<BookModel>,authorsBooksPagination: null == authorsBooksPagination ? _self.authorsBooksPagination : authorsBooksPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoadingAuthorsTranslations: null == isLoadingAuthorsTranslations ? _self.isLoadingAuthorsTranslations : isLoadingAuthorsTranslations // ignore: cast_nullable_to_non_nullable
as bool,authorsTranslations: null == authorsTranslations ? _self.authorsTranslations : authorsTranslations // ignore: cast_nullable_to_non_nullable
as List<BookModel>,authorsTranslationsPagination: null == authorsTranslationsPagination ? _self.authorsTranslationsPagination : authorsTranslationsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,
  ));
}
/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailedAuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $DetailedAuthorModelCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.authorsBooksPagination, (value) {
    return _then(_self.copyWith(authorsBooksPagination: value));
  });
}/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.authorsTranslationsPagination, (value) {
    return _then(_self.copyWith(authorsTranslationsPagination: value));
  });
}
}


/// @nodoc


class _AuthorState implements AuthorState {
  const _AuthorState({this.isLoading = false, this.author, this.isLoadingAuthorsBooks = false, final  List<BookModel> authorsBooks = const [], this.authorsBooksPagination = const ApiResponsePagination(), this.isLoadingAuthorsTranslations = false, final  List<BookModel> authorsTranslations = const [], this.authorsTranslationsPagination = const ApiResponsePagination()}): _authorsBooks = authorsBooks,_authorsTranslations = authorsTranslations;
  

@override@JsonKey() final  bool isLoading;
@override final  DetailedAuthorModel? author;
// Lists of books by the author
@override@JsonKey() final  bool isLoadingAuthorsBooks;
 final  List<BookModel> _authorsBooks;
@override@JsonKey() List<BookModel> get authorsBooks {
  if (_authorsBooks is EqualUnmodifiableListView) return _authorsBooks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authorsBooks);
}

@override@JsonKey() final  ApiResponsePagination authorsBooksPagination;
// Lists of books translated by the author
@override@JsonKey() final  bool isLoadingAuthorsTranslations;
 final  List<BookModel> _authorsTranslations;
@override@JsonKey() List<BookModel> get authorsTranslations {
  if (_authorsTranslations is EqualUnmodifiableListView) return _authorsTranslations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authorsTranslations);
}

@override@JsonKey() final  ApiResponsePagination authorsTranslationsPagination;

/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorStateCopyWith<_AuthorState> get copyWith => __$AuthorStateCopyWithImpl<_AuthorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthorState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.author, author) || other.author == author)&&(identical(other.isLoadingAuthorsBooks, isLoadingAuthorsBooks) || other.isLoadingAuthorsBooks == isLoadingAuthorsBooks)&&const DeepCollectionEquality().equals(other._authorsBooks, _authorsBooks)&&(identical(other.authorsBooksPagination, authorsBooksPagination) || other.authorsBooksPagination == authorsBooksPagination)&&(identical(other.isLoadingAuthorsTranslations, isLoadingAuthorsTranslations) || other.isLoadingAuthorsTranslations == isLoadingAuthorsTranslations)&&const DeepCollectionEquality().equals(other._authorsTranslations, _authorsTranslations)&&(identical(other.authorsTranslationsPagination, authorsTranslationsPagination) || other.authorsTranslationsPagination == authorsTranslationsPagination));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,author,isLoadingAuthorsBooks,const DeepCollectionEquality().hash(_authorsBooks),authorsBooksPagination,isLoadingAuthorsTranslations,const DeepCollectionEquality().hash(_authorsTranslations),authorsTranslationsPagination);

@override
String toString() {
  return 'AuthorState(isLoading: $isLoading, author: $author, isLoadingAuthorsBooks: $isLoadingAuthorsBooks, authorsBooks: $authorsBooks, authorsBooksPagination: $authorsBooksPagination, isLoadingAuthorsTranslations: $isLoadingAuthorsTranslations, authorsTranslations: $authorsTranslations, authorsTranslationsPagination: $authorsTranslationsPagination)';
}


}

/// @nodoc
abstract mixin class _$AuthorStateCopyWith<$Res> implements $AuthorStateCopyWith<$Res> {
  factory _$AuthorStateCopyWith(_AuthorState value, $Res Function(_AuthorState) _then) = __$AuthorStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, DetailedAuthorModel? author, bool isLoadingAuthorsBooks, List<BookModel> authorsBooks, ApiResponsePagination authorsBooksPagination, bool isLoadingAuthorsTranslations, List<BookModel> authorsTranslations, ApiResponsePagination authorsTranslationsPagination
});


@override $DetailedAuthorModelCopyWith<$Res>? get author;@override $ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination;@override $ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination;

}
/// @nodoc
class __$AuthorStateCopyWithImpl<$Res>
    implements _$AuthorStateCopyWith<$Res> {
  __$AuthorStateCopyWithImpl(this._self, this._then);

  final _AuthorState _self;
  final $Res Function(_AuthorState) _then;

/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? author = freezed,Object? isLoadingAuthorsBooks = null,Object? authorsBooks = null,Object? authorsBooksPagination = null,Object? isLoadingAuthorsTranslations = null,Object? authorsTranslations = null,Object? authorsTranslationsPagination = null,}) {
  return _then(_AuthorState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as DetailedAuthorModel?,isLoadingAuthorsBooks: null == isLoadingAuthorsBooks ? _self.isLoadingAuthorsBooks : isLoadingAuthorsBooks // ignore: cast_nullable_to_non_nullable
as bool,authorsBooks: null == authorsBooks ? _self._authorsBooks : authorsBooks // ignore: cast_nullable_to_non_nullable
as List<BookModel>,authorsBooksPagination: null == authorsBooksPagination ? _self.authorsBooksPagination : authorsBooksPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoadingAuthorsTranslations: null == isLoadingAuthorsTranslations ? _self.isLoadingAuthorsTranslations : isLoadingAuthorsTranslations // ignore: cast_nullable_to_non_nullable
as bool,authorsTranslations: null == authorsTranslations ? _self._authorsTranslations : authorsTranslations // ignore: cast_nullable_to_non_nullable
as List<BookModel>,authorsTranslationsPagination: null == authorsTranslationsPagination ? _self.authorsTranslationsPagination : authorsTranslationsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,
  ));
}

/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailedAuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $DetailedAuthorModelCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get authorsBooksPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.authorsBooksPagination, (value) {
    return _then(_self.copyWith(authorsBooksPagination: value));
  });
}/// Create a copy of AuthorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get authorsTranslationsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.authorsTranslationsPagination, (value) {
    return _then(_self.copyWith(authorsTranslationsPagination: value));
  });
}
}

// dart format on
