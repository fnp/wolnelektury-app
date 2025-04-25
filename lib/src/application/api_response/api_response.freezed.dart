// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResponse {
  List<Map<String, dynamic>>? get data =>
      throw _privateConstructorUsedError; // Pagination info
  int? get totalItems => throw _privateConstructorUsedError;
  ApiResponsePagination get paginationData =>
      throw _privateConstructorUsedError; // Errors part
  String? get error => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call(
      {List<Map<String, dynamic>>? data,
      int? totalItems,
      ApiResponsePagination paginationData,
      String? error,
      int? statusCode});

  $ApiResponsePaginationCopyWith<$Res> get paginationData;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalItems = freezed,
    Object? paginationData = null,
    Object? error = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      totalItems: freezed == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int?,
      paginationData: null == paginationData
          ? _value.paginationData
          : paginationData // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponsePaginationCopyWith<$Res> get paginationData {
    return $ApiResponsePaginationCopyWith<$Res>(_value.paginationData, (value) {
      return _then(_value.copyWith(paginationData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseImplCopyWith(
          _$ApiResponseImpl value, $Res Function(_$ApiResponseImpl) then) =
      __$$ApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Map<String, dynamic>>? data,
      int? totalItems,
      ApiResponsePagination paginationData,
      String? error,
      int? statusCode});

  @override
  $ApiResponsePaginationCopyWith<$Res> get paginationData;
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseImpl>
    implements _$$ApiResponseImplCopyWith<$Res> {
  __$$ApiResponseImplCopyWithImpl(
      _$ApiResponseImpl _value, $Res Function(_$ApiResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalItems = freezed,
    Object? paginationData = null,
    Object? error = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_$ApiResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      totalItems: freezed == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int?,
      paginationData: null == paginationData
          ? _value.paginationData
          : paginationData // ignore: cast_nullable_to_non_nullable
              as ApiResponsePagination,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ApiResponseImpl implements _ApiResponse {
  const _$ApiResponseImpl(
      {final List<Map<String, dynamic>>? data,
      this.totalItems,
      this.paginationData = const ApiResponsePagination(),
      this.error,
      this.statusCode})
      : _data = data;

  final List<Map<String, dynamic>>? _data;
  @override
  List<Map<String, dynamic>>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Pagination info
  @override
  final int? totalItems;
  @override
  @JsonKey()
  final ApiResponsePagination paginationData;
// Errors part
  @override
  final String? error;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'ApiResponse(data: $data, totalItems: $totalItems, paginationData: $paginationData, error: $error, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.paginationData, paginationData) ||
                other.paginationData == paginationData) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      totalItems,
      paginationData,
      error,
      statusCode);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<_$ApiResponseImpl>(this, _$identity);
}

abstract class _ApiResponse implements ApiResponse {
  const factory _ApiResponse(
      {final List<Map<String, dynamic>>? data,
      final int? totalItems,
      final ApiResponsePagination paginationData,
      final String? error,
      final int? statusCode}) = _$ApiResponseImpl;

  @override
  List<Map<String, dynamic>>? get data; // Pagination info
  @override
  int? get totalItems;
  @override
  ApiResponsePagination get paginationData; // Errors part
  @override
  String? get error;
  @override
  int? get statusCode;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiResponsePagination _$ApiResponsePaginationFromJson(
    Map<String, dynamic> json) {
  return _ApiResponsePagination.fromJson(json);
}

/// @nodoc
mixin _$ApiResponsePagination {
  String? get first => throw _privateConstructorUsedError;
  String? get last => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;

  /// Serializes this ApiResponsePagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponsePagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponsePaginationCopyWith<ApiResponsePagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponsePaginationCopyWith<$Res> {
  factory $ApiResponsePaginationCopyWith(ApiResponsePagination value,
          $Res Function(ApiResponsePagination) then) =
      _$ApiResponsePaginationCopyWithImpl<$Res, ApiResponsePagination>;
  @useResult
  $Res call({String? first, String? last, String? next, String? previous});
}

/// @nodoc
class _$ApiResponsePaginationCopyWithImpl<$Res,
        $Val extends ApiResponsePagination>
    implements $ApiResponsePaginationCopyWith<$Res> {
  _$ApiResponsePaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponsePagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? last = freezed,
    Object? next = freezed,
    Object? previous = freezed,
  }) {
    return _then(_value.copyWith(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as String?,
      last: freezed == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiResponsePaginationImplCopyWith<$Res>
    implements $ApiResponsePaginationCopyWith<$Res> {
  factory _$$ApiResponsePaginationImplCopyWith(
          _$ApiResponsePaginationImpl value,
          $Res Function(_$ApiResponsePaginationImpl) then) =
      __$$ApiResponsePaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? first, String? last, String? next, String? previous});
}

/// @nodoc
class __$$ApiResponsePaginationImplCopyWithImpl<$Res>
    extends _$ApiResponsePaginationCopyWithImpl<$Res,
        _$ApiResponsePaginationImpl>
    implements _$$ApiResponsePaginationImplCopyWith<$Res> {
  __$$ApiResponsePaginationImplCopyWithImpl(_$ApiResponsePaginationImpl _value,
      $Res Function(_$ApiResponsePaginationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiResponsePagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? last = freezed,
    Object? next = freezed,
    Object? previous = freezed,
  }) {
    return _then(_$ApiResponsePaginationImpl(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as String?,
      last: freezed == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponsePaginationImpl implements _ApiResponsePagination {
  const _$ApiResponsePaginationImpl(
      {this.first, this.last, this.next, this.previous});

  factory _$ApiResponsePaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponsePaginationImplFromJson(json);

  @override
  final String? first;
  @override
  final String? last;
  @override
  final String? next;
  @override
  final String? previous;

  @override
  String toString() {
    return 'ApiResponsePagination(first: $first, last: $last, next: $next, previous: $previous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponsePaginationImpl &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.last, last) || other.last == last) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first, last, next, previous);

  /// Create a copy of ApiResponsePagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponsePaginationImplCopyWith<_$ApiResponsePaginationImpl>
      get copyWith => __$$ApiResponsePaginationImplCopyWithImpl<
          _$ApiResponsePaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponsePaginationImplToJson(
      this,
    );
  }
}

abstract class _ApiResponsePagination implements ApiResponsePagination {
  const factory _ApiResponsePagination(
      {final String? first,
      final String? last,
      final String? next,
      final String? previous}) = _$ApiResponsePaginationImpl;

  factory _ApiResponsePagination.fromJson(Map<String, dynamic> json) =
      _$ApiResponsePaginationImpl.fromJson;

  @override
  String? get first;
  @override
  String? get last;
  @override
  String? get next;
  @override
  String? get previous;

  /// Create a copy of ApiResponsePagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponsePaginationImplCopyWith<_$ApiResponsePaginationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
