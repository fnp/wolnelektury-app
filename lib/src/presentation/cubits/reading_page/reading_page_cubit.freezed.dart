// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReadingPageState {
  String? get currentSlug => throw _privateConstructorUsedError;
  double get textSizeFactor => throw _privateConstructorUsedError;
  ReaderFontType get fontType => throw _privateConstructorUsedError;
  bool get isJsonLoading => throw _privateConstructorUsedError;
  ReaderBookModel? get book => throw _privateConstructorUsedError; // Bookmarks
  (Success, bool)? get isBookmarkSuccess => throw _privateConstructorUsedError;
  BookmarkModel? get editingBookmark => throw _privateConstructorUsedError;
  List<BookmarkModel> get bookmarks =>
      throw _privateConstructorUsedError; // ParagraphSheet
  int? get selectedIndex => throw _privateConstructorUsedError;
  ReaderBookModelContent? get selectedParagraph =>
      throw _privateConstructorUsedError;
  bool get isAddingBookmark => throw _privateConstructorUsedError;

  /// Create a copy of ReadingPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadingPageStateCopyWith<ReadingPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingPageStateCopyWith<$Res> {
  factory $ReadingPageStateCopyWith(
          ReadingPageState value, $Res Function(ReadingPageState) then) =
      _$ReadingPageStateCopyWithImpl<$Res, ReadingPageState>;
  @useResult
  $Res call(
      {String? currentSlug,
      double textSizeFactor,
      ReaderFontType fontType,
      bool isJsonLoading,
      ReaderBookModel? book,
      (Success, bool)? isBookmarkSuccess,
      BookmarkModel? editingBookmark,
      List<BookmarkModel> bookmarks,
      int? selectedIndex,
      ReaderBookModelContent? selectedParagraph,
      bool isAddingBookmark});

  $BookmarkModelCopyWith<$Res>? get editingBookmark;
}

/// @nodoc
class _$ReadingPageStateCopyWithImpl<$Res, $Val extends ReadingPageState>
    implements $ReadingPageStateCopyWith<$Res> {
  _$ReadingPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadingPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSlug = freezed,
    Object? textSizeFactor = null,
    Object? fontType = null,
    Object? isJsonLoading = null,
    Object? book = freezed,
    Object? isBookmarkSuccess = freezed,
    Object? editingBookmark = freezed,
    Object? bookmarks = null,
    Object? selectedIndex = freezed,
    Object? selectedParagraph = freezed,
    Object? isAddingBookmark = null,
  }) {
    return _then(_value.copyWith(
      currentSlug: freezed == currentSlug
          ? _value.currentSlug
          : currentSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      textSizeFactor: null == textSizeFactor
          ? _value.textSizeFactor
          : textSizeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      fontType: null == fontType
          ? _value.fontType
          : fontType // ignore: cast_nullable_to_non_nullable
              as ReaderFontType,
      isJsonLoading: null == isJsonLoading
          ? _value.isJsonLoading
          : isJsonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as ReaderBookModel?,
      isBookmarkSuccess: freezed == isBookmarkSuccess
          ? _value.isBookmarkSuccess
          : isBookmarkSuccess // ignore: cast_nullable_to_non_nullable
              as (Success, bool)?,
      editingBookmark: freezed == editingBookmark
          ? _value.editingBookmark
          : editingBookmark // ignore: cast_nullable_to_non_nullable
              as BookmarkModel?,
      bookmarks: null == bookmarks
          ? _value.bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as List<BookmarkModel>,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedParagraph: freezed == selectedParagraph
          ? _value.selectedParagraph
          : selectedParagraph // ignore: cast_nullable_to_non_nullable
              as ReaderBookModelContent?,
      isAddingBookmark: null == isAddingBookmark
          ? _value.isAddingBookmark
          : isAddingBookmark // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ReadingPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookmarkModelCopyWith<$Res>? get editingBookmark {
    if (_value.editingBookmark == null) {
      return null;
    }

    return $BookmarkModelCopyWith<$Res>(_value.editingBookmark!, (value) {
      return _then(_value.copyWith(editingBookmark: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReadingPageStateImplCopyWith<$Res>
    implements $ReadingPageStateCopyWith<$Res> {
  factory _$$ReadingPageStateImplCopyWith(_$ReadingPageStateImpl value,
          $Res Function(_$ReadingPageStateImpl) then) =
      __$$ReadingPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? currentSlug,
      double textSizeFactor,
      ReaderFontType fontType,
      bool isJsonLoading,
      ReaderBookModel? book,
      (Success, bool)? isBookmarkSuccess,
      BookmarkModel? editingBookmark,
      List<BookmarkModel> bookmarks,
      int? selectedIndex,
      ReaderBookModelContent? selectedParagraph,
      bool isAddingBookmark});

  @override
  $BookmarkModelCopyWith<$Res>? get editingBookmark;
}

/// @nodoc
class __$$ReadingPageStateImplCopyWithImpl<$Res>
    extends _$ReadingPageStateCopyWithImpl<$Res, _$ReadingPageStateImpl>
    implements _$$ReadingPageStateImplCopyWith<$Res> {
  __$$ReadingPageStateImplCopyWithImpl(_$ReadingPageStateImpl _value,
      $Res Function(_$ReadingPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReadingPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSlug = freezed,
    Object? textSizeFactor = null,
    Object? fontType = null,
    Object? isJsonLoading = null,
    Object? book = freezed,
    Object? isBookmarkSuccess = freezed,
    Object? editingBookmark = freezed,
    Object? bookmarks = null,
    Object? selectedIndex = freezed,
    Object? selectedParagraph = freezed,
    Object? isAddingBookmark = null,
  }) {
    return _then(_$ReadingPageStateImpl(
      currentSlug: freezed == currentSlug
          ? _value.currentSlug
          : currentSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      textSizeFactor: null == textSizeFactor
          ? _value.textSizeFactor
          : textSizeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      fontType: null == fontType
          ? _value.fontType
          : fontType // ignore: cast_nullable_to_non_nullable
              as ReaderFontType,
      isJsonLoading: null == isJsonLoading
          ? _value.isJsonLoading
          : isJsonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as ReaderBookModel?,
      isBookmarkSuccess: freezed == isBookmarkSuccess
          ? _value.isBookmarkSuccess
          : isBookmarkSuccess // ignore: cast_nullable_to_non_nullable
              as (Success, bool)?,
      editingBookmark: freezed == editingBookmark
          ? _value.editingBookmark
          : editingBookmark // ignore: cast_nullable_to_non_nullable
              as BookmarkModel?,
      bookmarks: null == bookmarks
          ? _value._bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as List<BookmarkModel>,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedParagraph: freezed == selectedParagraph
          ? _value.selectedParagraph
          : selectedParagraph // ignore: cast_nullable_to_non_nullable
              as ReaderBookModelContent?,
      isAddingBookmark: null == isAddingBookmark
          ? _value.isAddingBookmark
          : isAddingBookmark // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ReadingPageStateImpl implements _ReadingPageState {
  const _$ReadingPageStateImpl(
      {this.currentSlug,
      this.textSizeFactor = 0.5,
      this.fontType = ReaderFontType.sans,
      this.isJsonLoading = false,
      this.book,
      this.isBookmarkSuccess,
      this.editingBookmark,
      final List<BookmarkModel> bookmarks = const [],
      this.selectedIndex,
      this.selectedParagraph,
      this.isAddingBookmark = false})
      : _bookmarks = bookmarks;

  @override
  final String? currentSlug;
  @override
  @JsonKey()
  final double textSizeFactor;
  @override
  @JsonKey()
  final ReaderFontType fontType;
  @override
  @JsonKey()
  final bool isJsonLoading;
  @override
  final ReaderBookModel? book;
// Bookmarks
  @override
  final (Success, bool)? isBookmarkSuccess;
  @override
  final BookmarkModel? editingBookmark;
  final List<BookmarkModel> _bookmarks;
  @override
  @JsonKey()
  List<BookmarkModel> get bookmarks {
    if (_bookmarks is EqualUnmodifiableListView) return _bookmarks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarks);
  }

// ParagraphSheet
  @override
  final int? selectedIndex;
  @override
  final ReaderBookModelContent? selectedParagraph;
  @override
  @JsonKey()
  final bool isAddingBookmark;

  @override
  String toString() {
    return 'ReadingPageState(currentSlug: $currentSlug, textSizeFactor: $textSizeFactor, fontType: $fontType, isJsonLoading: $isJsonLoading, book: $book, isBookmarkSuccess: $isBookmarkSuccess, editingBookmark: $editingBookmark, bookmarks: $bookmarks, selectedIndex: $selectedIndex, selectedParagraph: $selectedParagraph, isAddingBookmark: $isAddingBookmark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingPageStateImpl &&
            (identical(other.currentSlug, currentSlug) ||
                other.currentSlug == currentSlug) &&
            (identical(other.textSizeFactor, textSizeFactor) ||
                other.textSizeFactor == textSizeFactor) &&
            (identical(other.fontType, fontType) ||
                other.fontType == fontType) &&
            (identical(other.isJsonLoading, isJsonLoading) ||
                other.isJsonLoading == isJsonLoading) &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.isBookmarkSuccess, isBookmarkSuccess) ||
                other.isBookmarkSuccess == isBookmarkSuccess) &&
            (identical(other.editingBookmark, editingBookmark) ||
                other.editingBookmark == editingBookmark) &&
            const DeepCollectionEquality()
                .equals(other._bookmarks, _bookmarks) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.selectedParagraph, selectedParagraph) ||
                other.selectedParagraph == selectedParagraph) &&
            (identical(other.isAddingBookmark, isAddingBookmark) ||
                other.isAddingBookmark == isAddingBookmark));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentSlug,
      textSizeFactor,
      fontType,
      isJsonLoading,
      book,
      isBookmarkSuccess,
      editingBookmark,
      const DeepCollectionEquality().hash(_bookmarks),
      selectedIndex,
      selectedParagraph,
      isAddingBookmark);

  /// Create a copy of ReadingPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingPageStateImplCopyWith<_$ReadingPageStateImpl> get copyWith =>
      __$$ReadingPageStateImplCopyWithImpl<_$ReadingPageStateImpl>(
          this, _$identity);
}

abstract class _ReadingPageState implements ReadingPageState {
  const factory _ReadingPageState(
      {final String? currentSlug,
      final double textSizeFactor,
      final ReaderFontType fontType,
      final bool isJsonLoading,
      final ReaderBookModel? book,
      final (Success, bool)? isBookmarkSuccess,
      final BookmarkModel? editingBookmark,
      final List<BookmarkModel> bookmarks,
      final int? selectedIndex,
      final ReaderBookModelContent? selectedParagraph,
      final bool isAddingBookmark}) = _$ReadingPageStateImpl;

  @override
  String? get currentSlug;
  @override
  double get textSizeFactor;
  @override
  ReaderFontType get fontType;
  @override
  bool get isJsonLoading;
  @override
  ReaderBookModel? get book; // Bookmarks
  @override
  (Success, bool)? get isBookmarkSuccess;
  @override
  BookmarkModel? get editingBookmark;
  @override
  List<BookmarkModel> get bookmarks; // ParagraphSheet
  @override
  int? get selectedIndex;
  @override
  ReaderBookModelContent? get selectedParagraph;
  @override
  bool get isAddingBookmark;

  /// Create a copy of ReadingPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadingPageStateImplCopyWith<_$ReadingPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
