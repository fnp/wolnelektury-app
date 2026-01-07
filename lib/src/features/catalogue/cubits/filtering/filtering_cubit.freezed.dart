// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filtering_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilteringState {

 bool get isLoading; bool get isLoadingMore; List<TagModel> get tags; List<TagModel> get selectedTags; String? get query; ApiResponsePagination get pagination;
/// Create a copy of FilteringState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilteringStateCopyWith<FilteringState> get copyWith => _$FilteringStateCopyWithImpl<FilteringState>(this as FilteringState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilteringState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.selectedTags, selectedTags)&&(identical(other.query, query) || other.query == query)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(selectedTags),query,pagination);

@override
String toString() {
  return 'FilteringState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, tags: $tags, selectedTags: $selectedTags, query: $query, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $FilteringStateCopyWith<$Res>  {
  factory $FilteringStateCopyWith(FilteringState value, $Res Function(FilteringState) _then) = _$FilteringStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<TagModel> tags, List<TagModel> selectedTags, String? query, ApiResponsePagination pagination
});


$ApiResponsePaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class _$FilteringStateCopyWithImpl<$Res>
    implements $FilteringStateCopyWith<$Res> {
  _$FilteringStateCopyWithImpl(this._self, this._then);

  final FilteringState _self;
  final $Res Function(FilteringState) _then;

/// Create a copy of FilteringState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? tags = null,Object? selectedTags = null,Object? query = freezed,Object? pagination = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagModel>,selectedTags: null == selectedTags ? _self.selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<TagModel>,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,
  ));
}
/// Create a copy of FilteringState
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


class _FilteringState implements FilteringState {
  const _FilteringState({this.isLoading = false, this.isLoadingMore = false, final  List<TagModel> tags = const [], final  List<TagModel> selectedTags = const [], this.query, this.pagination = const ApiResponsePagination()}): _tags = tags,_selectedTags = selectedTags;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
 final  List<TagModel> _tags;
@override@JsonKey() List<TagModel> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<TagModel> _selectedTags;
@override@JsonKey() List<TagModel> get selectedTags {
  if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTags);
}

@override final  String? query;
@override@JsonKey() final  ApiResponsePagination pagination;

/// Create a copy of FilteringState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilteringStateCopyWith<_FilteringState> get copyWith => __$FilteringStateCopyWithImpl<_FilteringState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilteringState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._selectedTags, _selectedTags)&&(identical(other.query, query) || other.query == query)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_selectedTags),query,pagination);

@override
String toString() {
  return 'FilteringState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, tags: $tags, selectedTags: $selectedTags, query: $query, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$FilteringStateCopyWith<$Res> implements $FilteringStateCopyWith<$Res> {
  factory _$FilteringStateCopyWith(_FilteringState value, $Res Function(_FilteringState) _then) = __$FilteringStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<TagModel> tags, List<TagModel> selectedTags, String? query, ApiResponsePagination pagination
});


@override $ApiResponsePaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class __$FilteringStateCopyWithImpl<$Res>
    implements _$FilteringStateCopyWith<$Res> {
  __$FilteringStateCopyWithImpl(this._self, this._then);

  final _FilteringState _self;
  final $Res Function(_FilteringState) _then;

/// Create a copy of FilteringState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? tags = null,Object? selectedTags = null,Object? query = freezed,Object? pagination = null,}) {
  return _then(_FilteringState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagModel>,selectedTags: null == selectedTags ? _self._selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<TagModel>,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,
  ));
}

/// Create a copy of FilteringState
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
