// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lists_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListsState implements DiagnosticableTreeMixin {

// Existing lists from the db
 bool get isLoading; bool get isLoadingMore; List<ListModel> get allLists; ListModel? get fetchedSingleList; ApiResponsePagination get pagination;// Pagination for items within a single list
 ApiResponsePagination get itemsPagination; bool get isLoadingMoreItems;// Adding list
 bool get isAdding; bool get isAddingFailure; ListModel? get pendingList;// Deleting list
 String? get deletingSlug; bool get isDeleteFailure;// Renaming list
 bool get isRenaming; bool get isRenamingFailure; bool get isDuplicateFailure;// Deleting item from list
// List slug, item slug
 ListItemModel? get softDeletedItem; bool get isRemovingItemFailure;
/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListsStateCopyWith<ListsState> get copyWith => _$ListsStateCopyWithImpl<ListsState>(this as ListsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ListsState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))..add(DiagnosticsProperty('allLists', allLists))..add(DiagnosticsProperty('fetchedSingleList', fetchedSingleList))..add(DiagnosticsProperty('pagination', pagination))..add(DiagnosticsProperty('itemsPagination', itemsPagination))..add(DiagnosticsProperty('isLoadingMoreItems', isLoadingMoreItems))..add(DiagnosticsProperty('isAdding', isAdding))..add(DiagnosticsProperty('isAddingFailure', isAddingFailure))..add(DiagnosticsProperty('pendingList', pendingList))..add(DiagnosticsProperty('deletingSlug', deletingSlug))..add(DiagnosticsProperty('isDeleteFailure', isDeleteFailure))..add(DiagnosticsProperty('isRenaming', isRenaming))..add(DiagnosticsProperty('isRenamingFailure', isRenamingFailure))..add(DiagnosticsProperty('isDuplicateFailure', isDuplicateFailure))..add(DiagnosticsProperty('softDeletedItem', softDeletedItem))..add(DiagnosticsProperty('isRemovingItemFailure', isRemovingItemFailure));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.allLists, allLists)&&(identical(other.fetchedSingleList, fetchedSingleList) || other.fetchedSingleList == fetchedSingleList)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.itemsPagination, itemsPagination) || other.itemsPagination == itemsPagination)&&(identical(other.isLoadingMoreItems, isLoadingMoreItems) || other.isLoadingMoreItems == isLoadingMoreItems)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isAddingFailure, isAddingFailure) || other.isAddingFailure == isAddingFailure)&&(identical(other.pendingList, pendingList) || other.pendingList == pendingList)&&(identical(other.deletingSlug, deletingSlug) || other.deletingSlug == deletingSlug)&&(identical(other.isDeleteFailure, isDeleteFailure) || other.isDeleteFailure == isDeleteFailure)&&(identical(other.isRenaming, isRenaming) || other.isRenaming == isRenaming)&&(identical(other.isRenamingFailure, isRenamingFailure) || other.isRenamingFailure == isRenamingFailure)&&(identical(other.isDuplicateFailure, isDuplicateFailure) || other.isDuplicateFailure == isDuplicateFailure)&&(identical(other.softDeletedItem, softDeletedItem) || other.softDeletedItem == softDeletedItem)&&(identical(other.isRemovingItemFailure, isRemovingItemFailure) || other.isRemovingItemFailure == isRemovingItemFailure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(allLists),fetchedSingleList,pagination,itemsPagination,isLoadingMoreItems,isAdding,isAddingFailure,pendingList,deletingSlug,isDeleteFailure,isRenaming,isRenamingFailure,isDuplicateFailure,softDeletedItem,isRemovingItemFailure);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ListsState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, fetchedSingleList: $fetchedSingleList, pagination: $pagination, itemsPagination: $itemsPagination, isLoadingMoreItems: $isLoadingMoreItems, isAdding: $isAdding, isAddingFailure: $isAddingFailure, pendingList: $pendingList, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRenaming: $isRenaming, isRenamingFailure: $isRenamingFailure, isDuplicateFailure: $isDuplicateFailure, softDeletedItem: $softDeletedItem, isRemovingItemFailure: $isRemovingItemFailure)';
}


}

/// @nodoc
abstract mixin class $ListsStateCopyWith<$Res>  {
  factory $ListsStateCopyWith(ListsState value, $Res Function(ListsState) _then) = _$ListsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<ListModel> allLists, ListModel? fetchedSingleList, ApiResponsePagination pagination, ApiResponsePagination itemsPagination, bool isLoadingMoreItems, bool isAdding, bool isAddingFailure, ListModel? pendingList, String? deletingSlug, bool isDeleteFailure, bool isRenaming, bool isRenamingFailure, bool isDuplicateFailure, ListItemModel? softDeletedItem, bool isRemovingItemFailure
});


$ListModelCopyWith<$Res>? get fetchedSingleList;$ApiResponsePaginationCopyWith<$Res> get pagination;$ApiResponsePaginationCopyWith<$Res> get itemsPagination;$ListModelCopyWith<$Res>? get pendingList;$ListItemModelCopyWith<$Res>? get softDeletedItem;

}
/// @nodoc
class _$ListsStateCopyWithImpl<$Res>
    implements $ListsStateCopyWith<$Res> {
  _$ListsStateCopyWithImpl(this._self, this._then);

  final ListsState _self;
  final $Res Function(ListsState) _then;

/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? allLists = null,Object? fetchedSingleList = freezed,Object? pagination = null,Object? itemsPagination = null,Object? isLoadingMoreItems = null,Object? isAdding = null,Object? isAddingFailure = null,Object? pendingList = freezed,Object? deletingSlug = freezed,Object? isDeleteFailure = null,Object? isRenaming = null,Object? isRenamingFailure = null,Object? isDuplicateFailure = null,Object? softDeletedItem = freezed,Object? isRemovingItemFailure = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,allLists: null == allLists ? _self.allLists : allLists // ignore: cast_nullable_to_non_nullable
as List<ListModel>,fetchedSingleList: freezed == fetchedSingleList ? _self.fetchedSingleList : fetchedSingleList // ignore: cast_nullable_to_non_nullable
as ListModel?,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,itemsPagination: null == itemsPagination ? _self.itemsPagination : itemsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoadingMoreItems: null == isLoadingMoreItems ? _self.isLoadingMoreItems : isLoadingMoreItems // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isAddingFailure: null == isAddingFailure ? _self.isAddingFailure : isAddingFailure // ignore: cast_nullable_to_non_nullable
as bool,pendingList: freezed == pendingList ? _self.pendingList : pendingList // ignore: cast_nullable_to_non_nullable
as ListModel?,deletingSlug: freezed == deletingSlug ? _self.deletingSlug : deletingSlug // ignore: cast_nullable_to_non_nullable
as String?,isDeleteFailure: null == isDeleteFailure ? _self.isDeleteFailure : isDeleteFailure // ignore: cast_nullable_to_non_nullable
as bool,isRenaming: null == isRenaming ? _self.isRenaming : isRenaming // ignore: cast_nullable_to_non_nullable
as bool,isRenamingFailure: null == isRenamingFailure ? _self.isRenamingFailure : isRenamingFailure // ignore: cast_nullable_to_non_nullable
as bool,isDuplicateFailure: null == isDuplicateFailure ? _self.isDuplicateFailure : isDuplicateFailure // ignore: cast_nullable_to_non_nullable
as bool,softDeletedItem: freezed == softDeletedItem ? _self.softDeletedItem : softDeletedItem // ignore: cast_nullable_to_non_nullable
as ListItemModel?,isRemovingItemFailure: null == isRemovingItemFailure ? _self.isRemovingItemFailure : isRemovingItemFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ListsState
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
}/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get itemsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.itemsPagination, (value) {
    return _then(_self.copyWith(itemsPagination: value));
  });
}/// Create a copy of ListsState
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
}/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListItemModelCopyWith<$Res>? get softDeletedItem {
    if (_self.softDeletedItem == null) {
    return null;
  }

  return $ListItemModelCopyWith<$Res>(_self.softDeletedItem!, (value) {
    return _then(_self.copyWith(softDeletedItem: value));
  });
}
}


/// @nodoc


class _ListsState with DiagnosticableTreeMixin implements ListsState {
  const _ListsState({this.isLoading = false, this.isLoadingMore = false, final  List<ListModel> allLists = const [], this.fetchedSingleList, this.pagination = const ApiResponsePagination(), this.itemsPagination = const ApiResponsePagination(), this.isLoadingMoreItems = false, this.isAdding = false, this.isAddingFailure = false, this.pendingList, this.deletingSlug, this.isDeleteFailure = false, this.isRenaming = false, this.isRenamingFailure = false, this.isDuplicateFailure = false, this.softDeletedItem, this.isRemovingItemFailure = false}): _allLists = allLists;
  

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
@override final  ListItemModel? softDeletedItem;
@override@JsonKey() final  bool isRemovingItemFailure;

/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListsStateCopyWith<_ListsState> get copyWith => __$ListsStateCopyWithImpl<_ListsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ListsState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))..add(DiagnosticsProperty('allLists', allLists))..add(DiagnosticsProperty('fetchedSingleList', fetchedSingleList))..add(DiagnosticsProperty('pagination', pagination))..add(DiagnosticsProperty('itemsPagination', itemsPagination))..add(DiagnosticsProperty('isLoadingMoreItems', isLoadingMoreItems))..add(DiagnosticsProperty('isAdding', isAdding))..add(DiagnosticsProperty('isAddingFailure', isAddingFailure))..add(DiagnosticsProperty('pendingList', pendingList))..add(DiagnosticsProperty('deletingSlug', deletingSlug))..add(DiagnosticsProperty('isDeleteFailure', isDeleteFailure))..add(DiagnosticsProperty('isRenaming', isRenaming))..add(DiagnosticsProperty('isRenamingFailure', isRenamingFailure))..add(DiagnosticsProperty('isDuplicateFailure', isDuplicateFailure))..add(DiagnosticsProperty('softDeletedItem', softDeletedItem))..add(DiagnosticsProperty('isRemovingItemFailure', isRemovingItemFailure));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._allLists, _allLists)&&(identical(other.fetchedSingleList, fetchedSingleList) || other.fetchedSingleList == fetchedSingleList)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.itemsPagination, itemsPagination) || other.itemsPagination == itemsPagination)&&(identical(other.isLoadingMoreItems, isLoadingMoreItems) || other.isLoadingMoreItems == isLoadingMoreItems)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isAddingFailure, isAddingFailure) || other.isAddingFailure == isAddingFailure)&&(identical(other.pendingList, pendingList) || other.pendingList == pendingList)&&(identical(other.deletingSlug, deletingSlug) || other.deletingSlug == deletingSlug)&&(identical(other.isDeleteFailure, isDeleteFailure) || other.isDeleteFailure == isDeleteFailure)&&(identical(other.isRenaming, isRenaming) || other.isRenaming == isRenaming)&&(identical(other.isRenamingFailure, isRenamingFailure) || other.isRenamingFailure == isRenamingFailure)&&(identical(other.isDuplicateFailure, isDuplicateFailure) || other.isDuplicateFailure == isDuplicateFailure)&&(identical(other.softDeletedItem, softDeletedItem) || other.softDeletedItem == softDeletedItem)&&(identical(other.isRemovingItemFailure, isRemovingItemFailure) || other.isRemovingItemFailure == isRemovingItemFailure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_allLists),fetchedSingleList,pagination,itemsPagination,isLoadingMoreItems,isAdding,isAddingFailure,pendingList,deletingSlug,isDeleteFailure,isRenaming,isRenamingFailure,isDuplicateFailure,softDeletedItem,isRemovingItemFailure);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ListsState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, fetchedSingleList: $fetchedSingleList, pagination: $pagination, itemsPagination: $itemsPagination, isLoadingMoreItems: $isLoadingMoreItems, isAdding: $isAdding, isAddingFailure: $isAddingFailure, pendingList: $pendingList, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRenaming: $isRenaming, isRenamingFailure: $isRenamingFailure, isDuplicateFailure: $isDuplicateFailure, softDeletedItem: $softDeletedItem, isRemovingItemFailure: $isRemovingItemFailure)';
}


}

/// @nodoc
abstract mixin class _$ListsStateCopyWith<$Res> implements $ListsStateCopyWith<$Res> {
  factory _$ListsStateCopyWith(_ListsState value, $Res Function(_ListsState) _then) = __$ListsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<ListModel> allLists, ListModel? fetchedSingleList, ApiResponsePagination pagination, ApiResponsePagination itemsPagination, bool isLoadingMoreItems, bool isAdding, bool isAddingFailure, ListModel? pendingList, String? deletingSlug, bool isDeleteFailure, bool isRenaming, bool isRenamingFailure, bool isDuplicateFailure, ListItemModel? softDeletedItem, bool isRemovingItemFailure
});


@override $ListModelCopyWith<$Res>? get fetchedSingleList;@override $ApiResponsePaginationCopyWith<$Res> get pagination;@override $ApiResponsePaginationCopyWith<$Res> get itemsPagination;@override $ListModelCopyWith<$Res>? get pendingList;@override $ListItemModelCopyWith<$Res>? get softDeletedItem;

}
/// @nodoc
class __$ListsStateCopyWithImpl<$Res>
    implements _$ListsStateCopyWith<$Res> {
  __$ListsStateCopyWithImpl(this._self, this._then);

  final _ListsState _self;
  final $Res Function(_ListsState) _then;

/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? allLists = null,Object? fetchedSingleList = freezed,Object? pagination = null,Object? itemsPagination = null,Object? isLoadingMoreItems = null,Object? isAdding = null,Object? isAddingFailure = null,Object? pendingList = freezed,Object? deletingSlug = freezed,Object? isDeleteFailure = null,Object? isRenaming = null,Object? isRenamingFailure = null,Object? isDuplicateFailure = null,Object? softDeletedItem = freezed,Object? isRemovingItemFailure = null,}) {
  return _then(_ListsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,allLists: null == allLists ? _self._allLists : allLists // ignore: cast_nullable_to_non_nullable
as List<ListModel>,fetchedSingleList: freezed == fetchedSingleList ? _self.fetchedSingleList : fetchedSingleList // ignore: cast_nullable_to_non_nullable
as ListModel?,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,itemsPagination: null == itemsPagination ? _self.itemsPagination : itemsPagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,isLoadingMoreItems: null == isLoadingMoreItems ? _self.isLoadingMoreItems : isLoadingMoreItems // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isAddingFailure: null == isAddingFailure ? _self.isAddingFailure : isAddingFailure // ignore: cast_nullable_to_non_nullable
as bool,pendingList: freezed == pendingList ? _self.pendingList : pendingList // ignore: cast_nullable_to_non_nullable
as ListModel?,deletingSlug: freezed == deletingSlug ? _self.deletingSlug : deletingSlug // ignore: cast_nullable_to_non_nullable
as String?,isDeleteFailure: null == isDeleteFailure ? _self.isDeleteFailure : isDeleteFailure // ignore: cast_nullable_to_non_nullable
as bool,isRenaming: null == isRenaming ? _self.isRenaming : isRenaming // ignore: cast_nullable_to_non_nullable
as bool,isRenamingFailure: null == isRenamingFailure ? _self.isRenamingFailure : isRenamingFailure // ignore: cast_nullable_to_non_nullable
as bool,isDuplicateFailure: null == isDuplicateFailure ? _self.isDuplicateFailure : isDuplicateFailure // ignore: cast_nullable_to_non_nullable
as bool,softDeletedItem: freezed == softDeletedItem ? _self.softDeletedItem : softDeletedItem // ignore: cast_nullable_to_non_nullable
as ListItemModel?,isRemovingItemFailure: null == isRemovingItemFailure ? _self.isRemovingItemFailure : isRemovingItemFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ListsState
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
}/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get itemsPagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.itemsPagination, (value) {
    return _then(_self.copyWith(itemsPagination: value));
  });
}/// Create a copy of ListsState
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
}/// Create a copy of ListsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListItemModelCopyWith<$Res>? get softDeletedItem {
    if (_self.softDeletedItem == null) {
    return null;
  }

  return $ListItemModelCopyWith<$Res>(_self.softDeletedItem!, (value) {
    return _then(_self.copyWith(softDeletedItem: value));
  });
}
}

// dart format on
