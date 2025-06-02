// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_creator_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListCreatorState {
  List<BookListModel> get booksToAdd =>
      throw _privateConstructorUsedError; // (List slug, book slug)
  List<(String, String, String)> get booksToRemove =>
      throw _privateConstructorUsedError;
  bool? get isSuccess =>
      throw _privateConstructorUsedError; // Existing lists from the db
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  List<BookListModel> get allLists => throw _privateConstructorUsedError;
  ApiResponsePagination get pagination =>
      throw _privateConstructorUsedError; // Editing list
  BookListModel? get editedList => throw _privateConstructorUsedError;
  BookListModel? get editedListToSave => throw _privateConstructorUsedError;
  bool get isSavingEditedList => throw _privateConstructorUsedError;
  bool get isSavingFailure => throw _privateConstructorUsedError; // Adding list
  bool get isAdding => throw _privateConstructorUsedError;
  bool get isAddingFailure =>
      throw _privateConstructorUsedError; // Deleting list
  String? get deletingSlug => throw _privateConstructorUsedError;
  bool get isDeleteFailure =>
      throw _privateConstructorUsedError; //  Deleting book from list
  bool get isRemovingBookFailure => throw _privateConstructorUsedError;

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListCreatorStateCopyWith<ListCreatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListCreatorStateCopyWith<$Res> {
  factory $ListCreatorStateCopyWith(
          ListCreatorState value, $Res Function(ListCreatorState) then) =
      _$ListCreatorStateCopyWithImpl<$Res, ListCreatorState>;
  @useResult
  $Res call(
      {List<BookListModel> booksToAdd,
      List<(String, String, String)> booksToRemove,
      bool? isSuccess,
      bool isLoading,
      bool isLoadingMore,
      List<BookListModel> allLists,
      ApiResponsePagination pagination,
      BookListModel? editedList,
      BookListModel? editedListToSave,
      bool isSavingEditedList,
      bool isSavingFailure,
      bool isAdding,
      bool isAddingFailure,
      String? deletingSlug,
      bool isDeleteFailure,
      bool isRemovingBookFailure});

  $ApiResponsePaginationCopyWith<$Res> get pagination;
  $BookListModelCopyWith<$Res>? get editedList;
  $BookListModelCopyWith<$Res>? get editedListToSave;
}

/// @nodoc
class _$ListCreatorStateCopyWithImpl<$Res, $Val extends ListCreatorState>
    implements $ListCreatorStateCopyWith<$Res> {
  _$ListCreatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? booksToAdd = null,
    Object? booksToRemove = null,
    Object? isSuccess = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? allLists = null,
    Object? pagination = null,
    Object? editedList = freezed,
    Object? editedListToSave = freezed,
    Object? isSavingEditedList = null,
    Object? isSavingFailure = null,
    Object? isAdding = null,
    Object? isAddingFailure = null,
    Object? deletingSlug = freezed,
    Object? isDeleteFailure = null,
    Object? isRemovingBookFailure = null,
  }) {
    return _then(_value.copyWith(
      booksToAdd: null == booksToAdd
          ? _value.booksToAdd
          : booksToAdd // ignore: cast_nullable_to_non_nullable
              as List<BookListModel>,
      booksToRemove: null == booksToRemove
          ? _value.booksToRemove
          : booksToRemove // ignore: cast_nullable_to_non_nullable
              as List<(String, String, String)>,
      isSuccess: freezed == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      allLists: null == allLists
          ? _value.allLists
          : allLists // ignore: cast_nullable_to_non_nullable
              as List<BookListModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      editedList: freezed == editedList
          ? _value.editedList
          : editedList // ignore: cast_nullable_to_non_nullable
              as BookListModel?,
      editedListToSave: freezed == editedListToSave
          ? _value.editedListToSave
          : editedListToSave // ignore: cast_nullable_to_non_nullable
              as BookListModel?,
      isSavingEditedList: null == isSavingEditedList
          ? _value.isSavingEditedList
          : isSavingEditedList // ignore: cast_nullable_to_non_nullable
              as bool,
      isSavingFailure: null == isSavingFailure
          ? _value.isSavingFailure
          : isSavingFailure // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdding: null == isAdding
          ? _value.isAdding
          : isAdding // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddingFailure: null == isAddingFailure
          ? _value.isAddingFailure
          : isAddingFailure // ignore: cast_nullable_to_non_nullable
              as bool,
      deletingSlug: freezed == deletingSlug
          ? _value.deletingSlug
          : deletingSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleteFailure: null == isDeleteFailure
          ? _value.isDeleteFailure
          : isDeleteFailure // ignore: cast_nullable_to_non_nullable
              as bool,
      isRemovingBookFailure: null == isRemovingBookFailure
          ? _value.isRemovingBookFailure
          : isRemovingBookFailure // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponsePaginationCopyWith<$Res> get pagination {
    return $ApiResponsePaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookListModelCopyWith<$Res>? get editedList {
    if (_value.editedList == null) {
      return null;
    }

    return $BookListModelCopyWith<$Res>(_value.editedList!, (value) {
      return _then(_value.copyWith(editedList: value) as $Val);
    });
  }

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookListModelCopyWith<$Res>? get editedListToSave {
    if (_value.editedListToSave == null) {
      return null;
    }

    return $BookListModelCopyWith<$Res>(_value.editedListToSave!, (value) {
      return _then(_value.copyWith(editedListToSave: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ListCreatorStateImplCopyWith<$Res>
    implements $ListCreatorStateCopyWith<$Res> {
  factory _$$ListCreatorStateImplCopyWith(_$ListCreatorStateImpl value,
          $Res Function(_$ListCreatorStateImpl) then) =
      __$$ListCreatorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BookListModel> booksToAdd,
      List<(String, String, String)> booksToRemove,
      bool? isSuccess,
      bool isLoading,
      bool isLoadingMore,
      List<BookListModel> allLists,
      ApiResponsePagination pagination,
      BookListModel? editedList,
      BookListModel? editedListToSave,
      bool isSavingEditedList,
      bool isSavingFailure,
      bool isAdding,
      bool isAddingFailure,
      String? deletingSlug,
      bool isDeleteFailure,
      bool isRemovingBookFailure});

  @override
  $ApiResponsePaginationCopyWith<$Res> get pagination;
  @override
  $BookListModelCopyWith<$Res>? get editedList;
  @override
  $BookListModelCopyWith<$Res>? get editedListToSave;
}

/// @nodoc
class __$$ListCreatorStateImplCopyWithImpl<$Res>
    extends _$ListCreatorStateCopyWithImpl<$Res, _$ListCreatorStateImpl>
    implements _$$ListCreatorStateImplCopyWith<$Res> {
  __$$ListCreatorStateImplCopyWithImpl(_$ListCreatorStateImpl _value,
      $Res Function(_$ListCreatorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? booksToAdd = null,
    Object? booksToRemove = null,
    Object? isSuccess = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? allLists = null,
    Object? pagination = null,
    Object? editedList = freezed,
    Object? editedListToSave = freezed,
    Object? isSavingEditedList = null,
    Object? isSavingFailure = null,
    Object? isAdding = null,
    Object? isAddingFailure = null,
    Object? deletingSlug = freezed,
    Object? isDeleteFailure = null,
    Object? isRemovingBookFailure = null,
  }) {
    return _then(_$ListCreatorStateImpl(
      booksToAdd: null == booksToAdd
          ? _value._booksToAdd
          : booksToAdd // ignore: cast_nullable_to_non_nullable
              as List<BookListModel>,
      booksToRemove: null == booksToRemove
          ? _value._booksToRemove
          : booksToRemove // ignore: cast_nullable_to_non_nullable
              as List<(String, String, String)>,
      isSuccess: freezed == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      allLists: null == allLists
          ? _value._allLists
          : allLists // ignore: cast_nullable_to_non_nullable
              as List<BookListModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      editedList: freezed == editedList
          ? _value.editedList
          : editedList // ignore: cast_nullable_to_non_nullable
              as BookListModel?,
      editedListToSave: freezed == editedListToSave
          ? _value.editedListToSave
          : editedListToSave // ignore: cast_nullable_to_non_nullable
              as BookListModel?,
      isSavingEditedList: null == isSavingEditedList
          ? _value.isSavingEditedList
          : isSavingEditedList // ignore: cast_nullable_to_non_nullable
              as bool,
      isSavingFailure: null == isSavingFailure
          ? _value.isSavingFailure
          : isSavingFailure // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdding: null == isAdding
          ? _value.isAdding
          : isAdding // ignore: cast_nullable_to_non_nullable
              as bool,
      isAddingFailure: null == isAddingFailure
          ? _value.isAddingFailure
          : isAddingFailure // ignore: cast_nullable_to_non_nullable
              as bool,
      deletingSlug: freezed == deletingSlug
          ? _value.deletingSlug
          : deletingSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleteFailure: null == isDeleteFailure
          ? _value.isDeleteFailure
          : isDeleteFailure // ignore: cast_nullable_to_non_nullable
              as bool,
      isRemovingBookFailure: null == isRemovingBookFailure
          ? _value.isRemovingBookFailure
          : isRemovingBookFailure // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ListCreatorStateImpl implements _ListCreatorState {
  const _$ListCreatorStateImpl(
      {final List<BookListModel> booksToAdd = const [],
      final List<(String, String, String)> booksToRemove = const [],
      this.isSuccess,
      this.isLoading = false,
      this.isLoadingMore = false,
      final List<BookListModel> allLists = const [],
      this.pagination = const ApiResponsePagination(),
      this.editedList,
      this.editedListToSave,
      this.isSavingEditedList = false,
      this.isSavingFailure = false,
      this.isAdding = false,
      this.isAddingFailure = false,
      this.deletingSlug,
      this.isDeleteFailure = false,
      this.isRemovingBookFailure = false})
      : _booksToAdd = booksToAdd,
        _booksToRemove = booksToRemove,
        _allLists = allLists;

  final List<BookListModel> _booksToAdd;
  @override
  @JsonKey()
  List<BookListModel> get booksToAdd {
    if (_booksToAdd is EqualUnmodifiableListView) return _booksToAdd;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_booksToAdd);
  }

// (List slug, book slug)
  final List<(String, String, String)> _booksToRemove;
// (List slug, book slug)
  @override
  @JsonKey()
  List<(String, String, String)> get booksToRemove {
    if (_booksToRemove is EqualUnmodifiableListView) return _booksToRemove;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_booksToRemove);
  }

  @override
  final bool? isSuccess;
// Existing lists from the db
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  final List<BookListModel> _allLists;
  @override
  @JsonKey()
  List<BookListModel> get allLists {
    if (_allLists is EqualUnmodifiableListView) return _allLists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allLists);
  }

  @override
  @JsonKey()
  final ApiResponsePagination pagination;
// Editing list
  @override
  final BookListModel? editedList;
  @override
  final BookListModel? editedListToSave;
  @override
  @JsonKey()
  final bool isSavingEditedList;
  @override
  @JsonKey()
  final bool isSavingFailure;
// Adding list
  @override
  @JsonKey()
  final bool isAdding;
  @override
  @JsonKey()
  final bool isAddingFailure;
// Deleting list
  @override
  final String? deletingSlug;
  @override
  @JsonKey()
  final bool isDeleteFailure;
//  Deleting book from list
  @override
  @JsonKey()
  final bool isRemovingBookFailure;

  @override
  String toString() {
    return 'ListCreatorState(booksToAdd: $booksToAdd, booksToRemove: $booksToRemove, isSuccess: $isSuccess, isLoading: $isLoading, isLoadingMore: $isLoadingMore, allLists: $allLists, pagination: $pagination, editedList: $editedList, editedListToSave: $editedListToSave, isSavingEditedList: $isSavingEditedList, isSavingFailure: $isSavingFailure, isAdding: $isAdding, isAddingFailure: $isAddingFailure, deletingSlug: $deletingSlug, isDeleteFailure: $isDeleteFailure, isRemovingBookFailure: $isRemovingBookFailure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListCreatorStateImpl &&
            const DeepCollectionEquality()
                .equals(other._booksToAdd, _booksToAdd) &&
            const DeepCollectionEquality()
                .equals(other._booksToRemove, _booksToRemove) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality().equals(other._allLists, _allLists) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.editedList, editedList) ||
                other.editedList == editedList) &&
            (identical(other.editedListToSave, editedListToSave) ||
                other.editedListToSave == editedListToSave) &&
            (identical(other.isSavingEditedList, isSavingEditedList) ||
                other.isSavingEditedList == isSavingEditedList) &&
            (identical(other.isSavingFailure, isSavingFailure) ||
                other.isSavingFailure == isSavingFailure) &&
            (identical(other.isAdding, isAdding) ||
                other.isAdding == isAdding) &&
            (identical(other.isAddingFailure, isAddingFailure) ||
                other.isAddingFailure == isAddingFailure) &&
            (identical(other.deletingSlug, deletingSlug) ||
                other.deletingSlug == deletingSlug) &&
            (identical(other.isDeleteFailure, isDeleteFailure) ||
                other.isDeleteFailure == isDeleteFailure) &&
            (identical(other.isRemovingBookFailure, isRemovingBookFailure) ||
                other.isRemovingBookFailure == isRemovingBookFailure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_booksToAdd),
      const DeepCollectionEquality().hash(_booksToRemove),
      isSuccess,
      isLoading,
      isLoadingMore,
      const DeepCollectionEquality().hash(_allLists),
      pagination,
      editedList,
      editedListToSave,
      isSavingEditedList,
      isSavingFailure,
      isAdding,
      isAddingFailure,
      deletingSlug,
      isDeleteFailure,
      isRemovingBookFailure);

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListCreatorStateImplCopyWith<_$ListCreatorStateImpl> get copyWith =>
      __$$ListCreatorStateImplCopyWithImpl<_$ListCreatorStateImpl>(
          this, _$identity);
}

abstract class _ListCreatorState implements ListCreatorState {
  const factory _ListCreatorState(
      {final List<BookListModel> booksToAdd,
      final List<(String, String, String)> booksToRemove,
      final bool? isSuccess,
      final bool isLoading,
      final bool isLoadingMore,
      final List<BookListModel> allLists,
      final ApiResponsePagination pagination,
      final BookListModel? editedList,
      final BookListModel? editedListToSave,
      final bool isSavingEditedList,
      final bool isSavingFailure,
      final bool isAdding,
      final bool isAddingFailure,
      final String? deletingSlug,
      final bool isDeleteFailure,
      final bool isRemovingBookFailure}) = _$ListCreatorStateImpl;

  @override
  List<BookListModel> get booksToAdd; // (List slug, book slug)
  @override
  List<(String, String, String)> get booksToRemove;
  @override
  bool? get isSuccess; // Existing lists from the db
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  List<BookListModel> get allLists;
  @override
  ApiResponsePagination get pagination; // Editing list
  @override
  BookListModel? get editedList;
  @override
  BookListModel? get editedListToSave;
  @override
  bool get isSavingEditedList;
  @override
  bool get isSavingFailure; // Adding list
  @override
  bool get isAdding;
  @override
  bool get isAddingFailure; // Deleting list
  @override
  String? get deletingSlug;
  @override
  bool get isDeleteFailure; //  Deleting book from list
  @override
  bool get isRemovingBookFailure;

  /// Create a copy of ListCreatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListCreatorStateImplCopyWith<_$ListCreatorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
