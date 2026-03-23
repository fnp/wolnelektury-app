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

 List<ListModel> get itemsToAdd;// (List slug, item slug)
 List<ItemToRemove> get itemsToRemove; bool? get isSuccess;// Existing lists from the db
 bool get isLoading; bool get isLoadingMore; List<ListModel> get allLists; ListModel? get fetchedSingleList; ApiResponsePagination get pagination;// Pagination for items within a single list
 ApiResponsePagination get itemsPagination; bool get isLoadingMoreItems;// Editing list
 ListModel? get editedList; ListModel? get editedListToSave; bool get isSavingEditedList; bool get isSavingFailure;// Adding list
 bool get isAdding; bool get isAddingFailure; ListModel? get pendingList;// Deleting list
 String? get deletingSlug; bool get isDeleteFailure;// Renaming list
 bool get isRenaming; bool get isRenamingFailure; bool get isDuplicateFailure;// Deleting item from list
// List slug, item slug
 (String, String)? get itemToRemoveFromList; bool get isRemovingItemFailure;
/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListCreatorStateCopyWith<ListCreatorState> get copyWith => _$ListCreatorStateCopyWithImpl<ListCreatorState>(this as ListCreatorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListCreatorState&&const DeepCollectionEquality().equals(other.itemsToAdd, itemsToAdd)&&const DeepCollectionEquality().equals(other.itemsToRemove, itemsToRemove)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.allLists, allLists)&&(identical(other.fetchedSingleList, fetchedSingleList) || other.fetchedSingleList == fetchedSingleList)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.itemsPagination, itemsPagination) || other.itemsPagination == itemsPagination)&&(identical(other.isLoadingMoreItems, isLoadingMoreItems) || other.isLoadingMoreItems == isLoadingMoreItems)&&(identical(other.editedList, editedList) || other.editedList == editedList)&&(identical(other.editedListToSave, editedListToSave) || other.editedListToSave == editedListToSave)&&(identical(other.isSavingEditedList, isSavingEditedList) || other.isSavingEditedList == isSavingEditedList)&&(identical(other.isSavingFailure, isSavingFailure) || other.isSavingFailure == isSavingFailure)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isAddingFailure, isAddingFailure) || other.isAddingFailure == isAddingFailure)&&(identical(other.pendingList, pendingList) || other.pendingList == pendingList)&&(identical(other.deletingSlug, deletingSlug) || other.deletingSlug == deletingSlug)&&(identical(other.isDeleteFailure, isDeleteFailure) || other.isDeleteFailure == isDeleteFailure)&&(identical(other.isRenaming, isRenaming) || other.isRenaming == isRenaming)&&(identical(other.isRenamingFailure, isRenamingFailure) || other.isRenamingFailure == isRenamingFailure)&&(identical(other.isDuplicateFailure, isDuplicateFailure) || other.isDuplicateFailure == isDuplicateFailure)&&(identical(other.itemToRemoveFromList, itemToRemoveFromList) || other.itemToRemoveFromList == itemToRemoveFromList)&&(identical(other.isRemovingItemFailure, isRemovingItemFailure) || other.isRemovingItemFailure == isRemovingItemFailure));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(itemsToAdd),const DeepCollectionEquality().hash(itemsToRemove),isSuccess,isLoading,isLoadingMore,const DeepCollectionEquality().hash(allLists),fetchedSingleList,pagination,itemsPagination,isLoadingMoreItems,editedList,editedListToSave,isSavingEditedList,isSavingFailure,isAdding,isAddingFailure,pendingList,deletingSlug,isDeleteFailure,isRenaming,isRenamingFailure,isDuplicateFailure,itemToRemoveFromList,isRemovingItemFailure]);

@override
String toString() {
  return 'ListCreatorState(itemsToAdd: $itemsToAdd, itemsToRemove: $itemsToRemove, isSuccess: $isSuccess, isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, fetchedSingleList: $fetchedSingleList, pagination: $pagination, itemsPagination: $itemsPagination, isLoadingMoreItems: $isLoadingMoreItems, editedList: $editedList, editedListToSave: $editedListToSave, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isAdding: $isAdding, isAddingFailure: $isAddingFailure, pendingList: $pendingList, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRenaming: $isRenaming, isRenamingFailure: $isRenamingFailure, isDuplicateFailure: $isDuplicateFailure, itemToRemoveFromList: $itemToRemoveFromList, isRemovingItemFailure: $isRemovingItemFailure)';
}


}

/// @nodoc
abstract mixin class $ListCreatorStateCopyWith<$Res>  {
  factory $ListCreatorStateCopyWith(ListCreatorState value, $Res Function(ListCreatorState) _then) = _$ListCreatorStateCopyWithImpl;
@useResult
$Res call({
 List<ListModel> itemsToAdd, List<ItemToRemove> itemsToRemove, bool? isSuccess, bool isLoading, bool isLoadingMore, List<ListModel> allLists, ListModel? fetchedSingleList, ApiResponsePagination pagination, ApiResponsePagination itemsPagination, bool isLoadingMoreItems, ListModel? editedList, ListModel? editedListToSave, bool isSavingEditedList, bool isSavingFailure, bool isAdding, bool isAddingFailure, ListModel? pendingList, String? deletingSlug, bool isDeleteFailure, bool isRenaming, bool isRenamingFailure, bool isDuplicateFailure, (String, String)? itemToRemoveFromList, bool isRemovingItemFailure
});


$ListModelCopyWith<$Res>? get fetchedSingleList;$ApiResponsePaginationCopyWith<$Res> get pagination;$ApiResponsePaginationCopyWith<$Res> get itemsPagination;$ListModelCopyWith<$Res>? get editedList;$ListModelCopyWith<$Res>? get editedListToSave;$ListModelCopyWith<$Res>? get pendingList;

}
/// @nodoc
class _$ListCreatorStateCopyWithImpl<$Res>
    implements $ListCreatorStateCopyWith<$Res> {
  _$ListCreatorStateCopyWithImpl(this._self, this._then);

  final ListCreatorState _self;
  final $Res Function(ListCreatorState) _then;

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemsToAdd = null,Object? itemsToRemove = null,Object? isSuccess = freezed,Object? isLoading = null,Object? isLoadingMore = null,Object? allLists = null,Object? fetchedSingleList = freezed,Object? pagination = null,Object? itemsPagination = null,Object? isLoadingMoreItems = null,Object? editedList = freezed,Object? editedListToSave = freezed,Object? isSavingEditedList = null,Object? isSavingFailure = null,Object? isAdding = null,Object? isAddingFailure = null,Object? pendingList = freezed,Object? deletingSlug = freezed,Object? isDeleteFailure = null,Object? isRenaming = null,Object? isRenamingFailure = null,Object? isDuplicateFailure = null,Object? itemToRemoveFromList = freezed,Object? isRemovingItemFailure = null,}) {
  return _then(_self.copyWith(
itemsToAdd: null == itemsToAdd ? _self.itemsToAdd : itemsToAdd // ignore: cast_nullable_to_non_nullable
as List<ListModel>,itemsToRemove: null == itemsToRemove ? _self.itemsToRemove : itemsToRemove // ignore: cast_nullable_to_non_nullable
as List<ItemToRemove>,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,allLists: null == allLists ? _self.allLists : allLists // ignore: cast_nullable_to_non_nullable
as List<ListModel>,fetchedSingleList: freezed == fetchedSingleList ? _self.fetchedSingleList : fetchedSingleList // ignore: cast_nullable_to_non_nullable
as ListModel?,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,itemsPagination: null == itemsPagination ? _self.itemsPagination : itemsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoadingMoreItems: null == isLoadingMoreItems ? _self.isLoadingMoreItems : isLoadingMoreItems // ignore: cast_nullable_to_non_nullable
as bool,editedList: freezed == editedList ? _self.editedList : editedList // ignore: cast_nullable_to_non_nullable
as ListModel?,editedListToSave: freezed == editedListToSave ? _self.editedListToSave : editedListToSave // ignore: cast_nullable_to_non_nullable
as ListModel?,isSavingEditedList: null == isSavingEditedList ? _self.isSavingEditedList : isSavingEditedList // ignore: cast_nullable_to_non_nullable
as bool,isSavingFailure: null == isSavingFailure ? _self.isSavingFailure : isSavingFailure // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isAddingFailure: null == isAddingFailure ? _self.isAddingFailure : isAddingFailure // ignore: cast_nullable_to_non_nullable
as bool,pendingList: freezed == pendingList ? _self.pendingList : pendingList // ignore: cast_nullable_to_non_nullable
as ListModel?,deletingSlug: freezed == deletingSlug ? _self.deletingSlug : deletingSlug // ignore: cast_nullable_to_non_nullable
as String?,isDeleteFailure: null == isDeleteFailure ? _self.isDeleteFailure : isDeleteFailure // ignore: cast_nullable_to_non_nullable
as bool,isRenaming: null == isRenaming ? _self.isRenaming : isRenaming // ignore: cast_nullable_to_non_nullable
as bool,isRenamingFailure: null == isRenamingFailure ? _self.isRenamingFailure : isRenamingFailure // ignore: cast_nullable_to_non_nullable
as bool,isDuplicateFailure: null == isDuplicateFailure ? _self.isDuplicateFailure : isDuplicateFailure // ignore: cast_nullable_to_non_nullable
as bool,itemToRemoveFromList: freezed == itemToRemoveFromList ? _self.itemToRemoveFromList : itemToRemoveFromList // ignore: cast_nullable_to_non_nullable
as (String, String)?,isRemovingItemFailure: null == isRemovingItemFailure ? _self.isRemovingItemFailure : isRemovingItemFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get fetchedSingleList {
    if (_self.fetchedSingleList == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.fetchedSingleList!, (value) {
    return _then(_self.copyWith(fetchedSingleList: value));
  });
}/// Create a copy of ListCreatorState
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
$ApiResponsePaginationCopyWith<$Res> get itemsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.itemsPagination, (value) {
    return _then(_self.copyWith(itemsPagination: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get editedList {
    if (_self.editedList == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.editedList!, (value) {
    return _then(_self.copyWith(editedList: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get editedListToSave {
    if (_self.editedListToSave == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.editedListToSave!, (value) {
    return _then(_self.copyWith(editedListToSave: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get pendingList {
    if (_self.pendingList == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.pendingList!, (value) {
    return _then(_self.copyWith(pendingList: value));
  });
}
}


/// @nodoc


class _ListCreatorState implements ListCreatorState {
  const _ListCreatorState({final  List<ListModel> itemsToAdd = const [], final  List<ItemToRemove> itemsToRemove = const [], this.isSuccess, this.isLoading = false, this.isLoadingMore = false, final  List<ListModel> allLists = const [], this.fetchedSingleList, this.pagination = const ApiResponsePagination(), this.itemsPagination = const ApiResponsePagination(), this.isLoadingMoreItems = false, this.editedList, this.editedListToSave, this.isSavingEditedList = false, this.isSavingFailure = false, this.isAdding = false, this.isAddingFailure = false, this.pendingList, this.deletingSlug, this.isDeleteFailure = false, this.isRenaming = false, this.isRenamingFailure = false, this.isDuplicateFailure = false, this.itemToRemoveFromList, this.isRemovingItemFailure = false}): _itemsToAdd = itemsToAdd,_itemsToRemove = itemsToRemove,_allLists = allLists;
  

 final  List<ListModel> _itemsToAdd;
@override@JsonKey() List<ListModel> get itemsToAdd {
  if (_itemsToAdd is EqualUnmodifiableListView) return _itemsToAdd;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemsToAdd);
}

// (List slug, item slug)
 final  List<ItemToRemove> _itemsToRemove;
// (List slug, item slug)
@override@JsonKey() List<ItemToRemove> get itemsToRemove {
  if (_itemsToRemove is EqualUnmodifiableListView) return _itemsToRemove;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemsToRemove);
}

@override final  bool? isSuccess;
// Existing lists from the db
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
 final  List<ListModel> _allLists;
@override@JsonKey() List<ListModel> get allLists {
  if (_allLists is EqualUnmodifiableListView) return _allLists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allLists);
}

@override final  ListModel? fetchedSingleList;
@override@JsonKey() final  ApiResponsePagination pagination;
// Pagination for items within a single list
@override@JsonKey() final  ApiResponsePagination itemsPagination;
@override@JsonKey() final  bool isLoadingMoreItems;
// Editing list
@override final  ListModel? editedList;
@override final  ListModel? editedListToSave;
@override@JsonKey() final  bool isSavingEditedList;
@override@JsonKey() final  bool isSavingFailure;
// Adding list
@override@JsonKey() final  bool isAdding;
@override@JsonKey() final  bool isAddingFailure;
@override final  ListModel? pendingList;
// Deleting list
@override final  String? deletingSlug;
@override@JsonKey() final  bool isDeleteFailure;
// Renaming list
@override@JsonKey() final  bool isRenaming;
@override@JsonKey() final  bool isRenamingFailure;
@override@JsonKey() final  bool isDuplicateFailure;
// Deleting item from list
// List slug, item slug
@override final  (String, String)? itemToRemoveFromList;
@override@JsonKey() final  bool isRemovingItemFailure;

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListCreatorStateCopyWith<_ListCreatorState> get copyWith => __$ListCreatorStateCopyWithImpl<_ListCreatorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListCreatorState&&const DeepCollectionEquality().equals(other._itemsToAdd, _itemsToAdd)&&const DeepCollectionEquality().equals(other._itemsToRemove, _itemsToRemove)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._allLists, _allLists)&&(identical(other.fetchedSingleList, fetchedSingleList) || other.fetchedSingleList == fetchedSingleList)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.itemsPagination, itemsPagination) || other.itemsPagination == itemsPagination)&&(identical(other.isLoadingMoreItems, isLoadingMoreItems) || other.isLoadingMoreItems == isLoadingMoreItems)&&(identical(other.editedList, editedList) || other.editedList == editedList)&&(identical(other.editedListToSave, editedListToSave) || other.editedListToSave == editedListToSave)&&(identical(other.isSavingEditedList, isSavingEditedList) || other.isSavingEditedList == isSavingEditedList)&&(identical(other.isSavingFailure, isSavingFailure) || other.isSavingFailure == isSavingFailure)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isAddingFailure, isAddingFailure) || other.isAddingFailure == isAddingFailure)&&(identical(other.pendingList, pendingList) || other.pendingList == pendingList)&&(identical(other.deletingSlug, deletingSlug) || other.deletingSlug == deletingSlug)&&(identical(other.isDeleteFailure, isDeleteFailure) || other.isDeleteFailure == isDeleteFailure)&&(identical(other.isRenaming, isRenaming) || other.isRenaming == isRenaming)&&(identical(other.isRenamingFailure, isRenamingFailure) || other.isRenamingFailure == isRenamingFailure)&&(identical(other.isDuplicateFailure, isDuplicateFailure) || other.isDuplicateFailure == isDuplicateFailure)&&(identical(other.itemToRemoveFromList, itemToRemoveFromList) || other.itemToRemoveFromList == itemToRemoveFromList)&&(identical(other.isRemovingItemFailure, isRemovingItemFailure) || other.isRemovingItemFailure == isRemovingItemFailure));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_itemsToAdd),const DeepCollectionEquality().hash(_itemsToRemove),isSuccess,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_allLists),fetchedSingleList,pagination,itemsPagination,isLoadingMoreItems,editedList,editedListToSave,isSavingEditedList,isSavingFailure,isAdding,isAddingFailure,pendingList,deletingSlug,isDeleteFailure,isRenaming,isRenamingFailure,isDuplicateFailure,itemToRemoveFromList,isRemovingItemFailure]);

@override
String toString() {
  return 'ListCreatorState(itemsToAdd: $itemsToAdd, itemsToRemove: $itemsToRemove, isSuccess: $isSuccess, isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, fetchedSingleList: $fetchedSingleList, pagination: $pagination, itemsPagination: $itemsPagination, isLoadingMoreItems: $isLoadingMoreItems, editedList: $editedList, editedListToSave: $editedListToSave, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isAdding: $isAdding, isAddingFailure: $isAddingFailure, pendingList: $pendingList, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRenaming: $isRenaming, isRenamingFailure: $isRenamingFailure, isDuplicateFailure: $isDuplicateFailure, itemToRemoveFromList: $itemToRemoveFromList, isRemovingItemFailure: $isRemovingItemFailure)';
}


}

/// @nodoc
abstract mixin class _$ListCreatorStateCopyWith<$Res> implements $ListCreatorStateCopyWith<$Res> {
  factory _$ListCreatorStateCopyWith(_ListCreatorState value, $Res Function(_ListCreatorState) _then) = __$ListCreatorStateCopyWithImpl;
@override @useResult
$Res call({
 List<ListModel> itemsToAdd, List<ItemToRemove> itemsToRemove, bool? isSuccess, bool isLoading, bool isLoadingMore, List<ListModel> allLists, ListModel? fetchedSingleList, ApiResponsePagination pagination, ApiResponsePagination itemsPagination, bool isLoadingMoreItems, ListModel? editedList, ListModel? editedListToSave, bool isSavingEditedList, bool isSavingFailure, bool isAdding, bool isAddingFailure, ListModel? pendingList, String? deletingSlug, bool isDeleteFailure, bool isRenaming, bool isRenamingFailure, bool isDuplicateFailure, (String, String)? itemToRemoveFromList, bool isRemovingItemFailure
});


@override $ListModelCopyWith<$Res>? get fetchedSingleList;@override $ApiResponsePaginationCopyWith<$Res> get pagination;@override $ApiResponsePaginationCopyWith<$Res> get itemsPagination;@override $ListModelCopyWith<$Res>? get editedList;@override $ListModelCopyWith<$Res>? get editedListToSave;@override $ListModelCopyWith<$Res>? get pendingList;

}
/// @nodoc
class __$ListCreatorStateCopyWithImpl<$Res>
    implements _$ListCreatorStateCopyWith<$Res> {
  __$ListCreatorStateCopyWithImpl(this._self, this._then);

  final _ListCreatorState _self;
  final $Res Function(_ListCreatorState) _then;

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemsToAdd = null,Object? itemsToRemove = null,Object? isSuccess = freezed,Object? isLoading = null,Object? isLoadingMore = null,Object? allLists = null,Object? fetchedSingleList = freezed,Object? pagination = null,Object? itemsPagination = null,Object? isLoadingMoreItems = null,Object? editedList = freezed,Object? editedListToSave = freezed,Object? isSavingEditedList = null,Object? isSavingFailure = null,Object? isAdding = null,Object? isAddingFailure = null,Object? pendingList = freezed,Object? deletingSlug = freezed,Object? isDeleteFailure = null,Object? isRenaming = null,Object? isRenamingFailure = null,Object? isDuplicateFailure = null,Object? itemToRemoveFromList = freezed,Object? isRemovingItemFailure = null,}) {
  return _then(_ListCreatorState(
itemsToAdd: null == itemsToAdd ? _self._itemsToAdd : itemsToAdd // ignore: cast_nullable_to_non_nullable
as List<ListModel>,itemsToRemove: null == itemsToRemove ? _self._itemsToRemove : itemsToRemove // ignore: cast_nullable_to_non_nullable
as List<ItemToRemove>,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,allLists: null == allLists ? _self._allLists : allLists // ignore: cast_nullable_to_non_nullable
as List<ListModel>,fetchedSingleList: freezed == fetchedSingleList ? _self.fetchedSingleList : fetchedSingleList // ignore: cast_nullable_to_non_nullable
as ListModel?,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,itemsPagination: null == itemsPagination ? _self.itemsPagination : itemsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoadingMoreItems: null == isLoadingMoreItems ? _self.isLoadingMoreItems : isLoadingMoreItems // ignore: cast_nullable_to_non_nullable
as bool,editedList: freezed == editedList ? _self.editedList : editedList // ignore: cast_nullable_to_non_nullable
as ListModel?,editedListToSave: freezed == editedListToSave ? _self.editedListToSave : editedListToSave // ignore: cast_nullable_to_non_nullable
as ListModel?,isSavingEditedList: null == isSavingEditedList ? _self.isSavingEditedList : isSavingEditedList // ignore: cast_nullable_to_non_nullable
as bool,isSavingFailure: null == isSavingFailure ? _self.isSavingFailure : isSavingFailure // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isAddingFailure: null == isAddingFailure ? _self.isAddingFailure : isAddingFailure // ignore: cast_nullable_to_non_nullable
as bool,pendingList: freezed == pendingList ? _self.pendingList : pendingList // ignore: cast_nullable_to_non_nullable
as ListModel?,deletingSlug: freezed == deletingSlug ? _self.deletingSlug : deletingSlug // ignore: cast_nullable_to_non_nullable
as String?,isDeleteFailure: null == isDeleteFailure ? _self.isDeleteFailure : isDeleteFailure // ignore: cast_nullable_to_non_nullable
as bool,isRenaming: null == isRenaming ? _self.isRenaming : isRenaming // ignore: cast_nullable_to_non_nullable
as bool,isRenamingFailure: null == isRenamingFailure ? _self.isRenamingFailure : isRenamingFailure // ignore: cast_nullable_to_non_nullable
as bool,isDuplicateFailure: null == isDuplicateFailure ? _self.isDuplicateFailure : isDuplicateFailure // ignore: cast_nullable_to_non_nullable
as bool,itemToRemoveFromList: freezed == itemToRemoveFromList ? _self.itemToRemoveFromList : itemToRemoveFromList // ignore: cast_nullable_to_non_nullable
as (String, String)?,isRemovingItemFailure: null == isRemovingItemFailure ? _self.isRemovingItemFailure : isRemovingItemFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get fetchedSingleList {
    if (_self.fetchedSingleList == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.fetchedSingleList!, (value) {
    return _then(_self.copyWith(fetchedSingleList: value));
  });
}/// Create a copy of ListCreatorState
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
$ApiResponsePaginationCopyWith<$Res> get itemsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.itemsPagination, (value) {
    return _then(_self.copyWith(itemsPagination: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get editedList {
    if (_self.editedList == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.editedList!, (value) {
    return _then(_self.copyWith(editedList: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get editedListToSave {
    if (_self.editedListToSave == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.editedListToSave!, (value) {
    return _then(_self.copyWith(editedListToSave: value));
  });
}/// Create a copy of ListCreatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res>? get pendingList {
    if (_self.pendingList == null) {
    return null;
  }

  return $ListModelCopyWith<$Res>(_self.pendingList!, (value) {
    return _then(_self.copyWith(pendingList: value));
  });
}
}

// dart format on
