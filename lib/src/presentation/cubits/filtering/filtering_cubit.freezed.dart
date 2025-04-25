// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filtering_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FilteringState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  List<TagModel> get tags => throw _privateConstructorUsedError;
  List<TagModel> get selectedTags => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  ApiResponsePagination get pagination => throw _privateConstructorUsedError;

  /// Create a copy of FilteringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilteringStateCopyWith<FilteringState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilteringStateCopyWith<$Res> {
  factory $FilteringStateCopyWith(
          FilteringState value, $Res Function(FilteringState) then) =
      _$FilteringStateCopyWithImpl<$Res, FilteringState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<TagModel> tags,
      List<TagModel> selectedTags,
      String? query,
      ApiResponsePagination pagination});

  $ApiResponsePaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$FilteringStateCopyWithImpl<$Res, $Val extends FilteringState>
    implements $FilteringStateCopyWith<$Res> {
  _$FilteringStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilteringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? tags = null,
    Object? selectedTags = null,
    Object? query = freezed,
    Object? pagination = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      selectedTags: null == selectedTags
          ? _value.selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
    ) as $Val);
  }

  /// Create a copy of FilteringState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponsePaginationCopyWith<$Res> get pagination {
    return $ApiResponsePaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilteringStateImplCopyWith<$Res>
    implements $FilteringStateCopyWith<$Res> {
  factory _$$FilteringStateImplCopyWith(_$FilteringStateImpl value,
          $Res Function(_$FilteringStateImpl) then) =
      __$$FilteringStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<TagModel> tags,
      List<TagModel> selectedTags,
      String? query,
      ApiResponsePagination pagination});

  @override
  $ApiResponsePaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$FilteringStateImplCopyWithImpl<$Res>
    extends _$FilteringStateCopyWithImpl<$Res, _$FilteringStateImpl>
    implements _$$FilteringStateImplCopyWith<$Res> {
  __$$FilteringStateImplCopyWithImpl(
      _$FilteringStateImpl _value, $Res Function(_$FilteringStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilteringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? tags = null,
    Object? selectedTags = null,
    Object? query = freezed,
    Object? pagination = null,
  }) {
    return _then(_$FilteringStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      selectedTags: null == selectedTags
          ? _value._selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
    ));
  }
}

/// @nodoc

class _$FilteringStateImpl implements _FilteringState {
  const _$FilteringStateImpl(
      {this.isLoading = false,
      this.isLoadingMore = false,
      final List<TagModel> tags = const [],
      final List<TagModel> selectedTags = const [],
      this.query,
      this.pagination = const ApiResponsePagination()})
      : _tags = tags,
        _selectedTags = selectedTags;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  final List<TagModel> _tags;
  @override
  @JsonKey()
  List<TagModel> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<TagModel> _selectedTags;
  @override
  @JsonKey()
  List<TagModel> get selectedTags {
    if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTags);
  }

  @override
  final String? query;
  @override
  @JsonKey()
  final ApiResponsePagination pagination;

  @override
  String toString() {
    return 'FilteringState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, tags: $tags, selectedTags: $selectedTags, query: $query, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilteringStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._selectedTags, _selectedTags) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoadingMore,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_selectedTags),
      query,
      pagination);

  /// Create a copy of FilteringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilteringStateImplCopyWith<_$FilteringStateImpl> get copyWith =>
      __$$FilteringStateImplCopyWithImpl<_$FilteringStateImpl>(
          this, _$identity);
}

abstract class _FilteringState implements FilteringState {
  const factory _FilteringState(
      {final bool isLoading,
      final bool isLoadingMore,
      final List<TagModel> tags,
      final List<TagModel> selectedTags,
      final String? query,
      final ApiResponsePagination pagination}) = _$FilteringStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  List<TagModel> get tags;
  @override
  List<TagModel> get selectedTags;
  @override
  String? get query;
  @override
  ApiResponsePagination get pagination;

  /// Create a copy of FilteringState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilteringStateImplCopyWith<_$FilteringStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
