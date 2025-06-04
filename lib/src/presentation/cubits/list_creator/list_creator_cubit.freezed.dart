// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_creator_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListCreatorState {

 List<BookListModel> get booksToAdd;// (List slug, book slug)
 List<BookToRemove> get booksToRemove; bool? get isSuccess;// Existing lists from the db
 bool get isLoading; bool get isLoadingMore; List<BookListModel> get allLists; ApiResponsePagination get pagination;// Editing list
 BookListModel? get editedList; BookListModel? get editedListToSave; bool get isSavingEditedList; bool get isSavingFailure;// Adding list
 bool get isAdding; bool get isAddingFailure;// Deleting list
 String? get deletingSlug; bool get isDeleteFailure;//  Deleting book from list
 bool get isRemovingBookFailure;
/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListCreatorStateCopyWith<ListCreatorState> get copyWith => _$ListCreatorStateCopyWithImpl<ListCreatorState>(this as ListCreatorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListCreatorState&&const DeepCollectionEquality().equals(other.booksToAdd, booksToAdd)&&const DeepCollectionEquality().equals(other.booksToRemove, booksToRemove)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.allLists, allLists)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.editedList, editedList) || other.editedList == editedList)&&(identical(other.editedListToSave, editedListToSave) || other.editedListToSave == editedListToSave)&&(identical(other.isSavingEditedList, isSavingEditedList) || other.isSavingEditedList == isSavingEditedList)&&(identical(other.isSavingFailure, isSavingFailure) || other.isSavingFailure == isSavingFailure)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isAddingFailure, isAddingFailure) || other.isAddingFailure == isAddingFailure)&&(identical(other.deletingSlug, deletingSlug) || other.deletingSlug == deletingSlug)&&(identical(other.isDeleteFailure, isDeleteFailure) || other.isDeleteFailure == isDeleteFailure)&&(identical(other.isRemovingBookFailure, isRemovingBookFailure) || other.isRemovingBookFailure == isRemovingBookFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(booksToAdd),const DeepCollectionEquality().hash(booksToRemove),isSuccess,isLoading,isLoadingMore,const DeepCollectionEquality().hash(allLists),pagination,editedList,editedListToSave,isSavingEditedList,isSavingFailure,isAdding,isAddingFailure,deletingSlug,isDeleteFailure,isRemovingBookFailure);

@override
String toString() {
  return 'ListCreatorState(booksToAdd: $booksToAdd, booksToRemove: $booksToRemove, isSuccess: $isSuccess, isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, pagination: $pagination, editedList: $editedList, editedListToSave: $editedListToSave, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isAdding: $isAdding, isAddingFailure: $isAddingFailure, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRemovingBookFailure: $isRemovingBookFailure)';
}


}

/// @nodoc
abstract mixin class $ListCreatorStateCopyWith<$Res>  {
  factory $ListCreatorStateCopyWith(ListCreatorState value, $Res Function(ListCreatorState) _then) = _$ListCreatorStateCopyWithImpl;
@useResult
$Res call({
 List<BookListModel> booksToAdd, List<BookToRemove> booksToRemove, bool? isSuccess, bool isLoading, bool isLoadingMore, List<BookListModel> allLists, ApiResponsePagination pagination, BookListModel? editedList, BookListModel? editedListToSave, bool isSavingEditedList, bool isSavingFailure, bool isAdding, bool isAddingFailure, String? deletingSlug, bool isDeleteFailure, bool isRemovingBookFailure
});


$ApiResponsePaginationCopyWith<$Res> get pagination;$BookListModelCopyWith<$Res>? get editedList;$BookListModelCopyWith<$Res>? get editedListToSave;

}
/// @nodoc
class _$ListCreatorStateCopyWithImpl<$Res>
    implements $ListCreatorStateCopyWith<$Res> {
  _$ListCreatorStateCopyWithImpl(this._self, this._then);

  final ListCreatorState _self;
  final $Res Function(ListCreatorState) _then;

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booksToAdd = null,Object? booksToRemove = null,Object? isSuccess = freezed,Object? isLoading = null,Object? isLoadingMore = null,Object? allLists = null,Object? pagination = null,Object? editedList = freezed,Object? editedListToSave = freezed,Object? isSavingEditedList = null,Object? isSavingFailure = null,Object? isAdding = null,Object? isAddingFailure = null,Object? deletingSlug = freezed,Object? isDeleteFailure = null,Object? isRemovingBookFailure = null,}) {
  return _then(_self.copyWith(
booksToAdd: null == booksToAdd ? _self.booksToAdd : booksToAdd // ignore: cast_nullable_to_non_nullable
as List<BookListModel>,booksToRemove: null == booksToRemove ? _self.booksToRemove : booksToRemove // ignore: cast_nullable_to_non_nullable
as List<BookToRemove>,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,allLists: null == allLists ? _self.allLists : allLists // ignore: cast_nullable_to_non_nullable
as List<BookListModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,editedList: freezed == editedList ? _self.editedList : editedList // ignore: cast_nullable_to_non_nullable
as BookListModel?,editedListToSave: freezed == editedListToSave ? _self.editedListToSave : editedListToSave // ignore: cast_nullable_to_non_nullable
as BookListModel?,isSavingEditedList: null == isSavingEditedList ? _self.isSavingEditedList : isSavingEditedList // ignore: cast_nullable_to_non_nullable
as bool,isSavingFailure: null == isSavingFailure ? _self.isSavingFailure : isSavingFailure // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isAddingFailure: null == isAddingFailure ? _self.isAddingFailure : isAddingFailure // ignore: cast_nullable_to_non_nullable
as bool,deletingSlug: freezed == deletingSlug ? _self.deletingSlug : deletingSlug // ignore: cast_nullable_to_non_nullable
as String?,isDeleteFailure: null == isDeleteFailure ? _self.isDeleteFailure : isDeleteFailure // ignore: cast_nullable_to_non_nullable
as bool,isRemovingBookFailure: null == isRemovingBookFailure ? _self.isRemovingBookFailure : isRemovingBookFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookListModelCopyWith<$Res>? get editedList {
    if (_self.editedList == null) {
    return null;
  }

  return $BookListModelCopyWith<$Res>(_self.editedList!, (value) {
    return _then(_self.copyWith(editedList: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookListModelCopyWith<$Res>? get editedListToSave {
    if (_self.editedListToSave == null) {
    return null;
  }

  return $BookListModelCopyWith<$Res>(_self.editedListToSave!, (value) {
    return _then(_self.copyWith(editedListToSave: value));
  });
}
}


/// @nodoc


class _ListCreatorState implements ListCreatorState {
  const _ListCreatorState({final  List<BookListModel> booksToAdd = const [], final  List<BookToRemove> booksToRemove = const [], this.isSuccess, this.isLoading = false, this.isLoadingMore = false, final  List<BookListModel> allLists = const [], this.pagination = const ApiResponsePagination(), this.editedList, this.editedListToSave, this.isSavingEditedList = false, this.isSavingFailure = false, this.isAdding = false, this.isAddingFailure = false, this.deletingSlug, this.isDeleteFailure = false, this.isRemovingBookFailure = false}): _booksToAdd = booksToAdd,_booksToRemove = booksToRemove,_allLists = allLists;
  

 final  List<BookListModel> _booksToAdd;
@override@JsonKey() List<BookListModel> get booksToAdd {
  if (_booksToAdd is EqualUnmodifiableListView) return _booksToAdd;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_booksToAdd);
}

// (List slug, book slug)
 final  List<BookToRemove> _booksToRemove;
// (List slug, book slug)
@override@JsonKey() List<BookToRemove> get booksToRemove {
  if (_booksToRemove is EqualUnmodifiableListView) return _booksToRemove;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_booksToRemove);
}

@override final  bool? isSuccess;
// Existing lists from the db
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
 final  List<BookListModel> _allLists;
@override@JsonKey() List<BookListModel> get allLists {
  if (_allLists is EqualUnmodifiableListView) return _allLists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allLists);
}

@override@JsonKey() final  ApiResponsePagination pagination;
// Editing list
@override final  BookListModel? editedList;
@override final  BookListModel? editedListToSave;
@override@JsonKey() final  bool isSavingEditedList;
@override@JsonKey() final  bool isSavingFailure;
// Adding list
@override@JsonKey() final  bool isAdding;
@override@JsonKey() final  bool isAddingFailure;
// Deleting list
@override final  String? deletingSlug;
@override@JsonKey() final  bool isDeleteFailure;
//  Deleting book from list
@override@JsonKey() final  bool isRemovingBookFailure;

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListCreatorStateCopyWith<_ListCreatorState> get copyWith => __$ListCreatorStateCopyWithImpl<_ListCreatorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListCreatorState&&const DeepCollectionEquality().equals(other._booksToAdd, _booksToAdd)&&const DeepCollectionEquality().equals(other._booksToRemove, _booksToRemove)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._allLists, _allLists)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.editedList, editedList) || other.editedList == editedList)&&(identical(other.editedListToSave, editedListToSave) || other.editedListToSave == editedListToSave)&&(identical(other.isSavingEditedList, isSavingEditedList) || other.isSavingEditedList == isSavingEditedList)&&(identical(other.isSavingFailure, isSavingFailure) || other.isSavingFailure == isSavingFailure)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isAddingFailure, isAddingFailure) || other.isAddingFailure == isAddingFailure)&&(identical(other.deletingSlug, deletingSlug) || other.deletingSlug == deletingSlug)&&(identical(other.isDeleteFailure, isDeleteFailure) || other.isDeleteFailure == isDeleteFailure)&&(identical(other.isRemovingBookFailure, isRemovingBookFailure) || other.isRemovingBookFailure == isRemovingBookFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_booksToAdd),const DeepCollectionEquality().hash(_booksToRemove),isSuccess,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_allLists),pagination,editedList,editedListToSave,isSavingEditedList,isSavingFailure,isAdding,isAddingFailure,deletingSlug,isDeleteFailure,isRemovingBookFailure);

@override
String toString() {
  return 'ListCreatorState(booksToAdd: $booksToAdd, booksToRemove: $booksToRemove, isSuccess: $isSuccess, isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, pagination: $pagination, editedList: $editedList, editedListToSave: $editedListToSave, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isAdding: $isAdding, isAddingFailure: $isAddingFailure, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRemovingBookFailure: $isRemovingBookFailure)';
}


}

/// @nodoc
abstract mixin class _$ListCreatorStateCopyWith<$Res> implements $ListCreatorStateCopyWith<$Res> {
  factory _$ListCreatorStateCopyWith(_ListCreatorState value, $Res Function(_ListCreatorState) _then) = __$ListCreatorStateCopyWithImpl;
@override @useResult
$Res call({
 List<BookListModel> booksToAdd, List<BookToRemove> booksToRemove, bool? isSuccess, bool isLoading, bool isLoadingMore, List<BookListModel> allLists, ApiResponsePagination pagination, BookListModel? editedList, BookListModel? editedListToSave, bool isSavingEditedList, bool isSavingFailure, bool isAdding, bool isAddingFailure, String? deletingSlug, bool isDeleteFailure, bool isRemovingBookFailure
});


@override $ApiResponsePaginationCopyWith<$Res> get pagination;@override $BookListModelCopyWith<$Res>? get editedList;@override $BookListModelCopyWith<$Res>? get editedListToSave;

}
/// @nodoc
class __$ListCreatorStateCopyWithImpl<$Res>
    implements _$ListCreatorStateCopyWith<$Res> {
  __$ListCreatorStateCopyWithImpl(this._self, this._then);

  final _ListCreatorState _self;
  final $Res Function(_ListCreatorState) _then;

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booksToAdd = null,Object? booksToRemove = null,Object? isSuccess = freezed,Object? isLoading = null,Object? isLoadingMore = null,Object? allLists = null,Object? pagination = null,Object? editedList = freezed,Object? editedListToSave = freezed,Object? isSavingEditedList = null,Object? isSavingFailure = null,Object? isAdding = null,Object? isAddingFailure = null,Object? deletingSlug = freezed,Object? isDeleteFailure = null,Object? isRemovingBookFailure = null,}) {
  return _then(_ListCreatorState(
booksToAdd: null == booksToAdd ? _self._booksToAdd : booksToAdd // ignore: cast_nullable_to_non_nullable
as List<BookListModel>,booksToRemove: null == booksToRemove ? _self._booksToRemove : booksToRemove // ignore: cast_nullable_to_non_nullable
as List<BookToRemove>,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,allLists: null == allLists ? _self._allLists : allLists // ignore: cast_nullable_to_non_nullable
as List<BookListModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,editedList: freezed == editedList ? _self.editedList : editedList // ignore: cast_nullable_to_non_nullable
as BookListModel?,editedListToSave: freezed == editedListToSave ? _self.editedListToSave : editedListToSave // ignore: cast_nullable_to_non_nullable
as BookListModel?,isSavingEditedList: null == isSavingEditedList ? _self.isSavingEditedList : isSavingEditedList // ignore: cast_nullable_to_non_nullable
as bool,isSavingFailure: null == isSavingFailure ? _self.isSavingFailure : isSavingFailure // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isAddingFailure: null == isAddingFailure ? _self.isAddingFailure : isAddingFailure // ignore: cast_nullable_to_non_nullable
as bool,deletingSlug: freezed == deletingSlug ? _self.deletingSlug : deletingSlug // ignore: cast_nullable_to_non_nullable
as String?,isDeleteFailure: null == isDeleteFailure ? _self.isDeleteFailure : isDeleteFailure // ignore: cast_nullable_to_non_nullable
as bool,isRemovingBookFailure: null == isRemovingBookFailure ? _self.isRemovingBookFailure : isRemovingBookFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookListModelCopyWith<$Res>? get editedList {
    if (_self.editedList == null) {
    return null;
  }

  return $BookListModelCopyWith<$Res>(_self.editedList!, (value) {
    return _then(_self.copyWith(editedList: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookListModelCopyWith<$Res>? get editedListToSave {
    if (_self.editedListToSave == null) {
    return null;
  }

  return $BookListModelCopyWith<$Res>(_self.editedListToSave!, (value) {
    return _then(_self.copyWith(editedListToSave: value));
  });
}
}

// dart format on
