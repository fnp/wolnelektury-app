// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookmarksState {

//
 bool get isLoading; bool get isLoadingMore; SuccessState? get isBookmarkSuccess;//
 BookmarkModel? get editingBookmark; BookmarkModel? get bookmarkToDelete;//
 List<BookmarkModel> get bookmarks;//
 bool get listenerNotifier;
/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookmarksStateCopyWith<BookmarksState> get copyWith => _$BookmarksStateCopyWithImpl<BookmarksState>(this as BookmarksState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isBookmarkSuccess, isBookmarkSuccess) || other.isBookmarkSuccess == isBookmarkSuccess)&&(identical(other.editingBookmark, editingBookmark) || other.editingBookmark == editingBookmark)&&(identical(other.bookmarkToDelete, bookmarkToDelete) || other.bookmarkToDelete == bookmarkToDelete)&&const DeepCollectionEquality().equals(other.bookmarks, bookmarks)&&(identical(other.listenerNotifier, listenerNotifier) || other.listenerNotifier == listenerNotifier));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,isBookmarkSuccess,editingBookmark,bookmarkToDelete,const DeepCollectionEquality().hash(bookmarks),listenerNotifier);

@override
String toString() {
  return 'BookmarksState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isBookmarkSuccess: $isBookmarkSuccess, editingBookmark: $editingBookmark, bookmarkToDelete: $bookmarkToDelete, bookmarks: $bookmarks, listenerNotifier: $listenerNotifier)';
}


}

/// @nodoc
abstract mixin class $BookmarksStateCopyWith<$Res>  {
  factory $BookmarksStateCopyWith(BookmarksState value, $Res Function(BookmarksState) _then) = _$BookmarksStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, SuccessState? isBookmarkSuccess, BookmarkModel? editingBookmark, BookmarkModel? bookmarkToDelete, List<BookmarkModel> bookmarks, bool listenerNotifier
});


$BookmarkModelCopyWith<$Res>? get editingBookmark;$BookmarkModelCopyWith<$Res>? get bookmarkToDelete;

}
/// @nodoc
class _$BookmarksStateCopyWithImpl<$Res>
    implements $BookmarksStateCopyWith<$Res> {
  _$BookmarksStateCopyWithImpl(this._self, this._then);

  final BookmarksState _self;
  final $Res Function(BookmarksState) _then;

/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isBookmarkSuccess = freezed,Object? editingBookmark = freezed,Object? bookmarkToDelete = freezed,Object? bookmarks = null,Object? listenerNotifier = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isBookmarkSuccess: freezed == isBookmarkSuccess ? _self.isBookmarkSuccess : isBookmarkSuccess // ignore: cast_nullable_to_non_nullable
as SuccessState?,editingBookmark: freezed == editingBookmark ? _self.editingBookmark : editingBookmark // ignore: cast_nullable_to_non_nullable
as BookmarkModel?,bookmarkToDelete: freezed == bookmarkToDelete ? _self.bookmarkToDelete : bookmarkToDelete // ignore: cast_nullable_to_non_nullable
as BookmarkModel?,bookmarks: null == bookmarks ? _self.bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<BookmarkModel>,listenerNotifier: null == listenerNotifier ? _self.listenerNotifier : listenerNotifier // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookmarkModelCopyWith<$Res>? get editingBookmark {
    if (_self.editingBookmark == null) {
    return null;
  }

  return $BookmarkModelCopyWith<$Res>(_self.editingBookmark!, (value) {
    return _then(_self.copyWith(editingBookmark: value));
  });
}/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookmarkModelCopyWith<$Res>? get bookmarkToDelete {
    if (_self.bookmarkToDelete == null) {
    return null;
  }

  return $BookmarkModelCopyWith<$Res>(_self.bookmarkToDelete!, (value) {
    return _then(_self.copyWith(bookmarkToDelete: value));
  });
}
}


/// @nodoc


class _BookmarksState implements BookmarksState {
  const _BookmarksState({this.isLoading = false, this.isLoadingMore = false, this.isBookmarkSuccess, this.editingBookmark, this.bookmarkToDelete, final  List<BookmarkModel> bookmarks = const [], this.listenerNotifier = false}): _bookmarks = bookmarks;
  

//
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override final  SuccessState? isBookmarkSuccess;
//
@override final  BookmarkModel? editingBookmark;
@override final  BookmarkModel? bookmarkToDelete;
//
 final  List<BookmarkModel> _bookmarks;
//
@override@JsonKey() List<BookmarkModel> get bookmarks {
  if (_bookmarks is EqualUnmodifiableListView) return _bookmarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookmarks);
}

//
@override@JsonKey() final  bool listenerNotifier;

/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookmarksStateCopyWith<_BookmarksState> get copyWith => __$BookmarksStateCopyWithImpl<_BookmarksState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookmarksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isBookmarkSuccess, isBookmarkSuccess) || other.isBookmarkSuccess == isBookmarkSuccess)&&(identical(other.editingBookmark, editingBookmark) || other.editingBookmark == editingBookmark)&&(identical(other.bookmarkToDelete, bookmarkToDelete) || other.bookmarkToDelete == bookmarkToDelete)&&const DeepCollectionEquality().equals(other._bookmarks, _bookmarks)&&(identical(other.listenerNotifier, listenerNotifier) || other.listenerNotifier == listenerNotifier));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,isBookmarkSuccess,editingBookmark,bookmarkToDelete,const DeepCollectionEquality().hash(_bookmarks),listenerNotifier);

@override
String toString() {
  return 'BookmarksState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isBookmarkSuccess: $isBookmarkSuccess, editingBookmark: $editingBookmark, bookmarkToDelete: $bookmarkToDelete, bookmarks: $bookmarks, listenerNotifier: $listenerNotifier)';
}


}

/// @nodoc
abstract mixin class _$BookmarksStateCopyWith<$Res> implements $BookmarksStateCopyWith<$Res> {
  factory _$BookmarksStateCopyWith(_BookmarksState value, $Res Function(_BookmarksState) _then) = __$BookmarksStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, SuccessState? isBookmarkSuccess, BookmarkModel? editingBookmark, BookmarkModel? bookmarkToDelete, List<BookmarkModel> bookmarks, bool listenerNotifier
});


@override $BookmarkModelCopyWith<$Res>? get editingBookmark;@override $BookmarkModelCopyWith<$Res>? get bookmarkToDelete;

}
/// @nodoc
class __$BookmarksStateCopyWithImpl<$Res>
    implements _$BookmarksStateCopyWith<$Res> {
  __$BookmarksStateCopyWithImpl(this._self, this._then);

  final _BookmarksState _self;
  final $Res Function(_BookmarksState) _then;

/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isBookmarkSuccess = freezed,Object? editingBookmark = freezed,Object? bookmarkToDelete = freezed,Object? bookmarks = null,Object? listenerNotifier = null,}) {
  return _then(_BookmarksState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isBookmarkSuccess: freezed == isBookmarkSuccess ? _self.isBookmarkSuccess : isBookmarkSuccess // ignore: cast_nullable_to_non_nullable
as SuccessState?,editingBookmark: freezed == editingBookmark ? _self.editingBookmark : editingBookmark // ignore: cast_nullable_to_non_nullable
as BookmarkModel?,bookmarkToDelete: freezed == bookmarkToDelete ? _self.bookmarkToDelete : bookmarkToDelete // ignore: cast_nullable_to_non_nullable
as BookmarkModel?,bookmarks: null == bookmarks ? _self._bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<BookmarkModel>,listenerNotifier: null == listenerNotifier ? _self.listenerNotifier : listenerNotifier // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookmarkModelCopyWith<$Res>? get editingBookmark {
    if (_self.editingBookmark == null) {
    return null;
  }

  return $BookmarkModelCopyWith<$Res>(_self.editingBookmark!, (value) {
    return _then(_self.copyWith(editingBookmark: value));
  });
}/// Create a copy of BookmarksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookmarkModelCopyWith<$Res>? get bookmarkToDelete {
    if (_self.bookmarkToDelete == null) {
    return null;
  }

  return $BookmarkModelCopyWith<$Res>(_self.bookmarkToDelete!, (value) {
    return _then(_self.copyWith(bookmarkToDelete: value));
  });
}
}

// dart format on
