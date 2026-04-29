// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListEditorState {

// This is original list that is being edited. It is used to compare with the edited list to determine if there are any changes.
 ListModel? get editedList;// This is the list that is being edited and will be saved. It is updated with every change in the editor.
 ListModel? get editedListToSave;// Elements to add
 List<ListItemModel> get itemsToAdd;// Elements to remove
 List<ListItemModel> get itemsToRemove; ListItemModel? get softRemovedItem; bool get isSavingEditedList; bool get isSavingFailure; bool get isSavingSuccess;// Book membership tracking
 String? get currentBookSlug; Set<String> get bookListMemberships; List<ListItemModel> get bookListMembershipItems; bool get isFetchingMemberships; bool get membershipsFetchFailure;
/// Create a copy of ListEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListEditorStateCopyWith<ListEditorState> get copyWith => _$ListEditorStateCopyWithImpl<ListEditorState>(this as ListEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListEditorState&&(identical(other.editedList, editedList) || other.editedList == editedList)&&(identical(other.editedListToSave, editedListToSave) || other.editedListToSave == editedListToSave)&&const DeepCollectionEquality().equals(other.itemsToAdd, itemsToAdd)&&const DeepCollectionEquality().equals(other.itemsToRemove, itemsToRemove)&&(identical(other.softRemovedItem, softRemovedItem) || other.softRemovedItem == softRemovedItem)&&(identical(other.isSavingEditedList, isSavingEditedList) || other.isSavingEditedList == isSavingEditedList)&&(identical(other.isSavingFailure, isSavingFailure) || other.isSavingFailure == isSavingFailure)&&(identical(other.isSavingSuccess, isSavingSuccess) || other.isSavingSuccess == isSavingSuccess)&&(identical(other.currentBookSlug, currentBookSlug) || other.currentBookSlug == currentBookSlug)&&const DeepCollectionEquality().equals(other.bookListMemberships, bookListMemberships)&&const DeepCollectionEquality().equals(other.bookListMembershipItems, bookListMembershipItems)&&(identical(other.isFetchingMemberships, isFetchingMemberships) || other.isFetchingMemberships == isFetchingMemberships)&&(identical(other.membershipsFetchFailure, membershipsFetchFailure) || other.membershipsFetchFailure == membershipsFetchFailure));
}


@override
int get hashCode => Object.hash(runtimeType,editedList,editedListToSave,const DeepCollectionEquality().hash(itemsToAdd),const DeepCollectionEquality().hash(itemsToRemove),softRemovedItem,isSavingEditedList,isSavingFailure,isSavingSuccess,currentBookSlug,const DeepCollectionEquality().hash(bookListMemberships),const DeepCollectionEquality().hash(bookListMembershipItems),isFetchingMemberships,membershipsFetchFailure);

@override
String toString() {
  return 'ListEditorState(editedList: $editedList, editedListToSave: $editedListToSave, itemsToAdd: $itemsToAdd, itemsToRemove: $itemsToRemove, softRemovedItem: $softRemovedItem, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isSavingSuccess: $isSavingSuccess, currentBookSlug: $currentBookSlug, bookListMemberships: $bookListMemberships, bookListMembershipItems: $bookListMembershipItems, isFetchingMemberships: $isFetchingMemberships, membershipsFetchFailure: $membershipsFetchFailure)';
}


}

/// @nodoc
abstract mixin class $ListEditorStateCopyWith<$Res>  {
  factory $ListEditorStateCopyWith(ListEditorState value, $Res Function(ListEditorState) _then) = _$ListEditorStateCopyWithImpl;
@useResult
$Res call({
 ListModel? editedList, ListModel? editedListToSave, List<ListItemModel> itemsToAdd, List<ListItemModel> itemsToRemove, ListItemModel? softRemovedItem, bool isSavingEditedList, bool isSavingFailure, bool isSavingSuccess, String? currentBookSlug, Set<String> bookListMemberships, List<ListItemModel> bookListMembershipItems, bool isFetchingMemberships, bool membershipsFetchFailure
});


$ListModelCopyWith<$Res>? get editedList;$ListModelCopyWith<$Res>? get editedListToSave;$ListItemModelCopyWith<$Res>? get softRemovedItem;

}
/// @nodoc
class _$ListEditorStateCopyWithImpl<$Res>
    implements $ListEditorStateCopyWith<$Res> {
  _$ListEditorStateCopyWithImpl(this._self, this._then);

  final ListEditorState _self;
  final $Res Function(ListEditorState) _then;

/// Create a copy of ListEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? editedList = freezed,Object? editedListToSave = freezed,Object? itemsToAdd = null,Object? itemsToRemove = null,Object? softRemovedItem = freezed,Object? isSavingEditedList = null,Object? isSavingFailure = null,Object? isSavingSuccess = null,Object? currentBookSlug = freezed,Object? bookListMemberships = null,Object? bookListMembershipItems = null,Object? isFetchingMemberships = null,Object? membershipsFetchFailure = null,}) {
  return _then(_self.copyWith(
editedList: freezed == editedList ? _self.editedList : editedList // ignore: cast_nullable_to_non_nullable
as ListModel?,editedListToSave: freezed == editedListToSave ? _self.editedListToSave : editedListToSave // ignore: cast_nullable_to_non_nullable
as ListModel?,itemsToAdd: null == itemsToAdd ? _self.itemsToAdd : itemsToAdd // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,itemsToRemove: null == itemsToRemove ? _self.itemsToRemove : itemsToRemove // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,softRemovedItem: freezed == softRemovedItem ? _self.softRemovedItem : softRemovedItem // ignore: cast_nullable_to_non_nullable
as ListItemModel?,isSavingEditedList: null == isSavingEditedList ? _self.isSavingEditedList : isSavingEditedList // ignore: cast_nullable_to_non_nullable
as bool,isSavingFailure: null == isSavingFailure ? _self.isSavingFailure : isSavingFailure // ignore: cast_nullable_to_non_nullable
as bool,isSavingSuccess: null == isSavingSuccess ? _self.isSavingSuccess : isSavingSuccess // ignore: cast_nullable_to_non_nullable
as bool,currentBookSlug: freezed == currentBookSlug ? _self.currentBookSlug : currentBookSlug // ignore: cast_nullable_to_non_nullable
as String?,bookListMemberships: null == bookListMemberships ? _self.bookListMemberships : bookListMemberships // ignore: cast_nullable_to_non_nullable
as Set<String>,bookListMembershipItems: null == bookListMembershipItems ? _self.bookListMembershipItems : bookListMembershipItems // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,isFetchingMemberships: null == isFetchingMemberships ? _self.isFetchingMemberships : isFetchingMemberships // ignore: cast_nullable_to_non_nullable
as bool,membershipsFetchFailure: null == membershipsFetchFailure ? _self.membershipsFetchFailure : membershipsFetchFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ListEditorState
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
}/// Create a copy of ListEditorState
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
}/// Create a copy of ListEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListItemModelCopyWith<$Res>? get softRemovedItem {
    if (_self.softRemovedItem == null) {
    return null;
  }

  return $ListItemModelCopyWith<$Res>(_self.softRemovedItem!, (value) {
    return _then(_self.copyWith(softRemovedItem: value));
  });
}
}


/// @nodoc


class _ListEditorState implements ListEditorState {
  const _ListEditorState({this.editedList, this.editedListToSave, final  List<ListItemModel> itemsToAdd = const [], final  List<ListItemModel> itemsToRemove = const [], this.softRemovedItem, this.isSavingEditedList = false, this.isSavingFailure = false, this.isSavingSuccess = false, this.currentBookSlug, final  Set<String> bookListMemberships = const {}, final  List<ListItemModel> bookListMembershipItems = const [], this.isFetchingMemberships = false, this.membershipsFetchFailure = false}): _itemsToAdd = itemsToAdd,_itemsToRemove = itemsToRemove,_bookListMemberships = bookListMemberships,_bookListMembershipItems = bookListMembershipItems;
  

// This is original list that is being edited. It is used to compare with the edited list to determine if there are any changes.
@override final  ListModel? editedList;
// This is the list that is being edited and will be saved. It is updated with every change in the editor.
@override final  ListModel? editedListToSave;
// Elements to add
 final  List<ListItemModel> _itemsToAdd;
// Elements to add
@override@JsonKey() List<ListItemModel> get itemsToAdd {
  if (_itemsToAdd is EqualUnmodifiableListView) return _itemsToAdd;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemsToAdd);
}

// Elements to remove
 final  List<ListItemModel> _itemsToRemove;
// Elements to remove
@override@JsonKey() List<ListItemModel> get itemsToRemove {
  if (_itemsToRemove is EqualUnmodifiableListView) return _itemsToRemove;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemsToRemove);
}

@override final  ListItemModel? softRemovedItem;
@override@JsonKey() final  bool isSavingEditedList;
@override@JsonKey() final  bool isSavingFailure;
@override@JsonKey() final  bool isSavingSuccess;
// Book membership tracking
@override final  String? currentBookSlug;
 final  Set<String> _bookListMemberships;
@override@JsonKey() Set<String> get bookListMemberships {
  if (_bookListMemberships is EqualUnmodifiableSetView) return _bookListMemberships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_bookListMemberships);
}

 final  List<ListItemModel> _bookListMembershipItems;
@override@JsonKey() List<ListItemModel> get bookListMembershipItems {
  if (_bookListMembershipItems is EqualUnmodifiableListView) return _bookListMembershipItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookListMembershipItems);
}

@override@JsonKey() final  bool isFetchingMemberships;
@override@JsonKey() final  bool membershipsFetchFailure;

/// Create a copy of ListEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListEditorStateCopyWith<_ListEditorState> get copyWith => __$ListEditorStateCopyWithImpl<_ListEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListEditorState&&(identical(other.editedList, editedList) || other.editedList == editedList)&&(identical(other.editedListToSave, editedListToSave) || other.editedListToSave == editedListToSave)&&const DeepCollectionEquality().equals(other._itemsToAdd, _itemsToAdd)&&const DeepCollectionEquality().equals(other._itemsToRemove, _itemsToRemove)&&(identical(other.softRemovedItem, softRemovedItem) || other.softRemovedItem == softRemovedItem)&&(identical(other.isSavingEditedList, isSavingEditedList) || other.isSavingEditedList == isSavingEditedList)&&(identical(other.isSavingFailure, isSavingFailure) || other.isSavingFailure == isSavingFailure)&&(identical(other.isSavingSuccess, isSavingSuccess) || other.isSavingSuccess == isSavingSuccess)&&(identical(other.currentBookSlug, currentBookSlug) || other.currentBookSlug == currentBookSlug)&&const DeepCollectionEquality().equals(other._bookListMemberships, _bookListMemberships)&&const DeepCollectionEquality().equals(other._bookListMembershipItems, _bookListMembershipItems)&&(identical(other.isFetchingMemberships, isFetchingMemberships) || other.isFetchingMemberships == isFetchingMemberships)&&(identical(other.membershipsFetchFailure, membershipsFetchFailure) || other.membershipsFetchFailure == membershipsFetchFailure));
}


@override
int get hashCode => Object.hash(runtimeType,editedList,editedListToSave,const DeepCollectionEquality().hash(_itemsToAdd),const DeepCollectionEquality().hash(_itemsToRemove),softRemovedItem,isSavingEditedList,isSavingFailure,isSavingSuccess,currentBookSlug,const DeepCollectionEquality().hash(_bookListMemberships),const DeepCollectionEquality().hash(_bookListMembershipItems),isFetchingMemberships,membershipsFetchFailure);

@override
String toString() {
  return 'ListEditorState(editedList: $editedList, editedListToSave: $editedListToSave, itemsToAdd: $itemsToAdd, itemsToRemove: $itemsToRemove, softRemovedItem: $softRemovedItem, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isSavingSuccess: $isSavingSuccess, currentBookSlug: $currentBookSlug, bookListMemberships: $bookListMemberships, bookListMembershipItems: $bookListMembershipItems, isFetchingMemberships: $isFetchingMemberships, membershipsFetchFailure: $membershipsFetchFailure)';
}


}

/// @nodoc
abstract mixin class _$ListEditorStateCopyWith<$Res> implements $ListEditorStateCopyWith<$Res> {
  factory _$ListEditorStateCopyWith(_ListEditorState value, $Res Function(_ListEditorState) _then) = __$ListEditorStateCopyWithImpl;
@override @useResult
$Res call({
 ListModel? editedList, ListModel? editedListToSave, List<ListItemModel> itemsToAdd, List<ListItemModel> itemsToRemove, ListItemModel? softRemovedItem, bool isSavingEditedList, bool isSavingFailure, bool isSavingSuccess, String? currentBookSlug, Set<String> bookListMemberships, List<ListItemModel> bookListMembershipItems, bool isFetchingMemberships, bool membershipsFetchFailure
});


@override $ListModelCopyWith<$Res>? get editedList;@override $ListModelCopyWith<$Res>? get editedListToSave;@override $ListItemModelCopyWith<$Res>? get softRemovedItem;

}
/// @nodoc
class __$ListEditorStateCopyWithImpl<$Res>
    implements _$ListEditorStateCopyWith<$Res> {
  __$ListEditorStateCopyWithImpl(this._self, this._then);

  final _ListEditorState _self;
  final $Res Function(_ListEditorState) _then;

/// Create a copy of ListEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? editedList = freezed,Object? editedListToSave = freezed,Object? itemsToAdd = null,Object? itemsToRemove = null,Object? softRemovedItem = freezed,Object? isSavingEditedList = null,Object? isSavingFailure = null,Object? isSavingSuccess = null,Object? currentBookSlug = freezed,Object? bookListMemberships = null,Object? bookListMembershipItems = null,Object? isFetchingMemberships = null,Object? membershipsFetchFailure = null,}) {
  return _then(_ListEditorState(
editedList: freezed == editedList ? _self.editedList : editedList // ignore: cast_nullable_to_non_nullable
as ListModel?,editedListToSave: freezed == editedListToSave ? _self.editedListToSave : editedListToSave // ignore: cast_nullable_to_non_nullable
as ListModel?,itemsToAdd: null == itemsToAdd ? _self._itemsToAdd : itemsToAdd // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,itemsToRemove: null == itemsToRemove ? _self._itemsToRemove : itemsToRemove // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,softRemovedItem: freezed == softRemovedItem ? _self.softRemovedItem : softRemovedItem // ignore: cast_nullable_to_non_nullable
as ListItemModel?,isSavingEditedList: null == isSavingEditedList ? _self.isSavingEditedList : isSavingEditedList // ignore: cast_nullable_to_non_nullable
as bool,isSavingFailure: null == isSavingFailure ? _self.isSavingFailure : isSavingFailure // ignore: cast_nullable_to_non_nullable
as bool,isSavingSuccess: null == isSavingSuccess ? _self.isSavingSuccess : isSavingSuccess // ignore: cast_nullable_to_non_nullable
as bool,currentBookSlug: freezed == currentBookSlug ? _self.currentBookSlug : currentBookSlug // ignore: cast_nullable_to_non_nullable
as String?,bookListMemberships: null == bookListMemberships ? _self._bookListMemberships : bookListMemberships // ignore: cast_nullable_to_non_nullable
as Set<String>,bookListMembershipItems: null == bookListMembershipItems ? _self._bookListMembershipItems : bookListMembershipItems // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,isFetchingMemberships: null == isFetchingMemberships ? _self.isFetchingMemberships : isFetchingMemberships // ignore: cast_nullable_to_non_nullable
as bool,membershipsFetchFailure: null == membershipsFetchFailure ? _self.membershipsFetchFailure : membershipsFetchFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ListEditorState
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
}/// Create a copy of ListEditorState
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
}/// Create a copy of ListEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListItemModelCopyWith<$Res>? get softRemovedItem {
    if (_self.softRemovedItem == null) {
    return null;
  }

  return $ListItemModelCopyWith<$Res>(_self.softRemovedItem!, (value) {
    return _then(_self.copyWith(softRemovedItem: value));
  });
}
}

// dart format on
