// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProgressState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  List<ProgressModel> get progresses => throw _privateConstructorUsedError;
  ApiResponsePagination get pagination => throw _privateConstructorUsedError;

  /// Create a copy of ProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressStateCopyWith<ProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStateCopyWith<$Res> {
  factory $ProgressStateCopyWith(
          ProgressState value, $Res Function(ProgressState) then) =
      _$ProgressStateCopyWithImpl<$Res, ProgressState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<ProgressModel> progresses,
      ApiResponsePagination pagination});

  $ApiResponsePaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ProgressStateCopyWithImpl<$Res, $Val extends ProgressState>
    implements $ProgressStateCopyWith<$Res> {
  _$ProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? progresses = null,
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
      progresses: null == progresses
          ? _value.progresses
          : progresses // ignore: cast_nullable_to_non_nullable
              as List<ProgressModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
    ) as $Val);
  }

  /// Create a copy of ProgressState
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
abstract class _$$ProgressStateImplCopyWith<$Res>
    implements $ProgressStateCopyWith<$Res> {
  factory _$$ProgressStateImplCopyWith(
          _$ProgressStateImpl value, $Res Function(_$ProgressStateImpl) then) =
      __$$ProgressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<ProgressModel> progresses,
      ApiResponsePagination pagination});

  @override
  $ApiResponsePaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ProgressStateImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$ProgressStateImpl>
    implements _$$ProgressStateImplCopyWith<$Res> {
  __$$ProgressStateImplCopyWithImpl(
      _$ProgressStateImpl _value, $Res Function(_$ProgressStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? progresses = null,
    Object? pagination = null,
  }) {
    return _then(_$ProgressStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      progresses: null == progresses
          ? _value._progresses
          : progresses // ignore: cast_nullable_to_non_nullable
              as List<ProgressModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
    ));
  }
}

/// @nodoc

class _$ProgressStateImpl implements _ProgressState {
  const _$ProgressStateImpl(
      {this.isLoading = false,
      this.isLoadingMore = false,
      final List<ProgressModel> progresses = const [],
      this.pagination = const ApiResponsePagination()})
      : _progresses = progresses;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  final List<ProgressModel> _progresses;
  @override
  @JsonKey()
  List<ProgressModel> get progresses {
    if (_progresses is EqualUnmodifiableListView) return _progresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progresses);
  }

  @override
  @JsonKey()
  final ApiResponsePagination pagination;

  @override
  String toString() {
    return 'ProgressState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, progresses: $progresses, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality()
                .equals(other._progresses, _progresses) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isLoadingMore,
      const DeepCollectionEquality().hash(_progresses), pagination);

  /// Create a copy of ProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressStateImplCopyWith<_$ProgressStateImpl> get copyWith =>
      __$$ProgressStateImplCopyWithImpl<_$ProgressStateImpl>(this, _$identity);
}

abstract class _ProgressState implements ProgressState {
  const factory _ProgressState(
      {final bool isLoading,
      final bool isLoadingMore,
      final List<ProgressModel> progresses,
      final ApiResponsePagination pagination}) = _$ProgressStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  List<ProgressModel> get progresses;
  @override
  ApiResponsePagination get pagination;

  /// Create a copy of ProgressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressStateImplCopyWith<_$ProgressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
