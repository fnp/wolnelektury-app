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

 bool get isLoadingHints; List<HintModel> get hints; List<HintModel> get lastSearched; String? get query;/// Results
 List<BookModel> get books; ApiResponsePagination get booksPagination; List<TextSearchResultModel> get texts; ApiResponsePagination get textsPagination; GenericSearchResultModel? get generic; bool get isLoadingResults; bool get showResults;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.isLoadingHints, isLoadingHints) || other.isLoadingHints == isLoadingHints)&&const DeepCollectionEquality().equals(other.hints, hints)&&const DeepCollectionEquality().equals(other.lastSearched, lastSearched)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.books, books)&&(identical(other.booksPagination, booksPagination) || other.booksPagination == booksPagination)&&const DeepCollectionEquality().equals(other.texts, texts)&&(identical(other.textsPagination, textsPagination) || other.textsPagination == textsPagination)&&(identical(other.generic, generic) || other.generic == generic)&&(identical(other.isLoadingResults, isLoadingResults) || other.isLoadingResults == isLoadingResults)&&(identical(other.showResults, showResults) || other.showResults == showResults));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingHints,const DeepCollectionEquality().hash(hints),const DeepCollectionEquality().hash(lastSearched),query,const DeepCollectionEquality().hash(books),booksPagination,const DeepCollectionEquality().hash(texts),textsPagination,generic,isLoadingResults,showResults);

@override
String toString() {
  return 'SearchState(isLoadingHints: $isLoadingHints, hints: $hints, lastSearched: $lastSearched, query: $query, books: $books, booksPagination: $booksPagination, texts: $texts, textsPagination: $textsPagination, generic: $generic, isLoadingResults: $isLoadingResults, showResults: $showResults)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingHints, List<HintModel> hints, List<HintModel> lastSearched, String? query, List<BookModel> books, ApiResponsePagination booksPagination, List<TextSearchResultModel> texts, ApiResponsePagination textsPagination, GenericSearchResultModel? generic, bool isLoadingResults, bool showResults
});


$ApiResponsePaginationCopyWith<$Res> get booksPagination;$ApiResponsePaginationCopyWith<$Res> get textsPagination;$GenericSearchResultModelCopyWith<$Res>? get generic;

}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingHints = null,Object? hints = null,Object? lastSearched = null,Object? query = freezed,Object? books = null,Object? booksPagination = null,Object? texts = null,Object? textsPagination = null,Object? generic = freezed,Object? isLoadingResults = null,Object? showResults = null,}) {
  return _then(_self.copyWith(
isLoadingHints: null == isLoadingHints ? _self.isLoadingHints : isLoadingHints // ignore: cast_nullable_to_non_nullable
as bool,hints: null == hints ? _self.hints : hints // ignore: cast_nullable_to_non_nullable
as List<HintModel>,lastSearched: null == lastSearched ? _self.lastSearched : lastSearched // ignore: cast_nullable_to_non_nullable
as List<HintModel>,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<BookModel>,booksPagination: null == booksPagination ? _self.booksPagination : booksPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,texts: null == texts ? _self.texts : texts // ignore: cast_nullable_to_non_nullable
as List<TextSearchResultModel>,textsPagination: null == textsPagination ? _self.textsPagination : textsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,generic: freezed == generic ? _self.generic : generic // ignore: cast_nullable_to_non_nullable
as GenericSearchResultModel?,isLoadingResults: null == isLoadingResults ? _self.isLoadingResults : isLoadingResults // ignore: cast_nullable_to_non_nullable
as bool,showResults: null == showResults ? _self.showResults : showResults // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get booksPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.booksPagination, (value) {
    return _then(_self.copyWith(booksPagination: value));
  });
}/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get textsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.textsPagination, (value) {
    return _then(_self.copyWith(textsPagination: value));
  });
}/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenericSearchResultModelCopyWith<$Res>? get generic {
    if (_self.generic == null) {
    return null;
  }

  return $GenericSearchResultModelCopyWith<$Res>(_self.generic!, (value) {
    return _then(_self.copyWith(generic: value));
  });
}
}


/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.isLoadingHints = false, final  List<HintModel> hints = const [], final  List<HintModel> lastSearched = const [], this.query, final  List<BookModel> books = const [], this.booksPagination = const ApiResponsePagination(), final  List<TextSearchResultModel> texts = const [], this.textsPagination = const ApiResponsePagination(), this.generic, this.isLoadingResults = false, this.showResults = false}): _hints = hints,_lastSearched = lastSearched,_books = books,_texts = texts;
  

@override@JsonKey() final  bool isLoadingHints;
 final  List<HintModel> _hints;
@override@JsonKey() List<HintModel> get hints {
  if (_hints is EqualUnmodifiableListView) return _hints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hints);
}

 final  List<HintModel> _lastSearched;
@override@JsonKey() List<HintModel> get lastSearched {
  if (_lastSearched is EqualUnmodifiableListView) return _lastSearched;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lastSearched);
}

@override final  String? query;
/// Results
 final  List<BookModel> _books;
/// Results
@override@JsonKey() List<BookModel> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

@override@JsonKey() final  ApiResponsePagination booksPagination;
 final  List<TextSearchResultModel> _texts;
@override@JsonKey() List<TextSearchResultModel> get texts {
  if (_texts is EqualUnmodifiableListView) return _texts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_texts);
}

@override@JsonKey() final  ApiResponsePagination textsPagination;
@override final  GenericSearchResultModel? generic;
@override@JsonKey() final  bool isLoadingResults;
@override@JsonKey() final  bool showResults;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.isLoadingHints, isLoadingHints) || other.isLoadingHints == isLoadingHints)&&const DeepCollectionEquality().equals(other._hints, _hints)&&const DeepCollectionEquality().equals(other._lastSearched, _lastSearched)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._books, _books)&&(identical(other.booksPagination, booksPagination) || other.booksPagination == booksPagination)&&const DeepCollectionEquality().equals(other._texts, _texts)&&(identical(other.textsPagination, textsPagination) || other.textsPagination == textsPagination)&&(identical(other.generic, generic) || other.generic == generic)&&(identical(other.isLoadingResults, isLoadingResults) || other.isLoadingResults == isLoadingResults)&&(identical(other.showResults, showResults) || other.showResults == showResults));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingHints,const DeepCollectionEquality().hash(_hints),const DeepCollectionEquality().hash(_lastSearched),query,const DeepCollectionEquality().hash(_books),booksPagination,const DeepCollectionEquality().hash(_texts),textsPagination,generic,isLoadingResults,showResults);

@override
String toString() {
  return 'SearchState(isLoadingHints: $isLoadingHints, hints: $hints, lastSearched: $lastSearched, query: $query, books: $books, booksPagination: $booksPagination, texts: $texts, textsPagination: $textsPagination, generic: $generic, isLoadingResults: $isLoadingResults, showResults: $showResults)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingHints, List<HintModel> hints, List<HintModel> lastSearched, String? query, List<BookModel> books, ApiResponsePagination booksPagination, List<TextSearchResultModel> texts, ApiResponsePagination textsPagination, GenericSearchResultModel? generic, bool isLoadingResults, bool showResults
});


@override $ApiResponsePaginationCopyWith<$Res> get booksPagination;@override $ApiResponsePaginationCopyWith<$Res> get textsPagination;@override $GenericSearchResultModelCopyWith<$Res>? get generic;

}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingHints = null,Object? hints = null,Object? lastSearched = null,Object? query = freezed,Object? books = null,Object? booksPagination = null,Object? texts = null,Object? textsPagination = null,Object? generic = freezed,Object? isLoadingResults = null,Object? showResults = null,}) {
  return _then(_SearchState(
isLoadingHints: null == isLoadingHints ? _self.isLoadingHints : isLoadingHints // ignore: cast_nullable_to_non_nullable
as bool,hints: null == hints ? _self._hints : hints // ignore: cast_nullable_to_non_nullable
as List<HintModel>,lastSearched: null == lastSearched ? _self._lastSearched : lastSearched // ignore: cast_nullable_to_non_nullable
as List<HintModel>,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<BookModel>,booksPagination: null == booksPagination ? _self.booksPagination : booksPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,texts: null == texts ? _self._texts : texts // ignore: cast_nullable_to_non_nullable
as List<TextSearchResultModel>,textsPagination: null == textsPagination ? _self.textsPagination : textsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,generic: freezed == generic ? _self.generic : generic // ignore: cast_nullable_to_non_nullable
as GenericSearchResultModel?,isLoadingResults: null == isLoadingResults ? _self.isLoadingResults : isLoadingResults // ignore: cast_nullable_to_non_nullable
as bool,showResults: null == showResults ? _self.showResults : showResults // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get booksPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.booksPagination, (value) {
    return _then(_self.copyWith(booksPagination: value));
  });
}/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get textsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.textsPagination, (value) {
    return _then(_self.copyWith(textsPagination: value));
  });
}/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenericSearchResultModelCopyWith<$Res>? get generic {
    if (_self.generic == null) {
    return null;
  }

  return $GenericSearchResultModelCopyWith<$Res>(_self.generic!, (value) {
    return _then(_self.copyWith(generic: value));
  });
}
}

// dart format on
