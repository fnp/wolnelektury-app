// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiResponse {

 List<Map<String, dynamic>>? get data;// Data that is not parsed into a model,
 List<String>? get simpleData;// Pagination info
 int? get totalItems; ApiResponsePagination get paginationData;// Errors part
 String? get error; int? get statusCode;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<ApiResponse> get copyWith => _$ApiResponseCopyWithImpl<ApiResponse>(this as ApiResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.simpleData, simpleData)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.paginationData, paginationData) || other.paginationData == paginationData)&&(identical(other.error, error) || other.error == error)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(simpleData),totalItems,paginationData,error,statusCode);

@override
String toString() {
  return 'ApiResponse(data: $data, simpleData: $simpleData, totalItems: $totalItems, paginationData: $paginationData, error: $error, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<$Res>  {
  factory $ApiResponseCopyWith(ApiResponse value, $Res Function(ApiResponse) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 List<Map<String, dynamic>>? data, List<String>? simpleData, int? totalItems, ApiResponsePagination paginationData, String? error, int? statusCode
});


$ApiResponsePaginationCopyWith<$Res> get paginationData;

}
/// @nodoc
class _$ApiResponseCopyWithImpl<$Res>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse _self;
  final $Res Function(ApiResponse) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? simpleData = freezed,Object? totalItems = freezed,Object? paginationData = null,Object? error = freezed,Object? statusCode = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,simpleData: freezed == simpleData ? _self.simpleData : simpleData // ignore: cast_nullable_to_non_nullable
as List<String>?,totalItems: freezed == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int?,paginationData: null == paginationData ? _self.paginationData : paginationData // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get paginationData {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.paginationData, (value) {
    return _then(_self.copyWith(paginationData: value));
  });
}
}


/// @nodoc


class _ApiResponse implements ApiResponse {
  const _ApiResponse({final  List<Map<String, dynamic>>? data, final  List<String>? simpleData, this.totalItems, this.paginationData = const ApiResponsePagination(), this.error, this.statusCode}): _data = data,_simpleData = simpleData;
  

 final  List<Map<String, dynamic>>? _data;
@override List<Map<String, dynamic>>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// Data that is not parsed into a model,
 final  List<String>? _simpleData;
// Data that is not parsed into a model,
@override List<String>? get simpleData {
  final value = _simpleData;
  if (value == null) return null;
  if (_simpleData is EqualUnmodifiableListView) return _simpleData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// Pagination info
@override final  int? totalItems;
@override@JsonKey() final  ApiResponsePagination paginationData;
// Errors part
@override final  String? error;
@override final  int? statusCode;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<_ApiResponse> get copyWith => __$ApiResponseCopyWithImpl<_ApiResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse&&const DeepCollectionEquality().equals(other._data, _data)&&const DeepCollectionEquality().equals(other._simpleData, _simpleData)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.paginationData, paginationData) || other.paginationData == paginationData)&&(identical(other.error, error) || other.error == error)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),const DeepCollectionEquality().hash(_simpleData),totalItems,paginationData,error,statusCode);

@override
String toString() {
  return 'ApiResponse(data: $data, simpleData: $simpleData, totalItems: $totalItems, paginationData: $paginationData, error: $error, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<$Res> implements $ApiResponseCopyWith<$Res> {
  factory _$ApiResponseCopyWith(_ApiResponse value, $Res Function(_ApiResponse) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Map<String, dynamic>>? data, List<String>? simpleData, int? totalItems, ApiResponsePagination paginationData, String? error, int? statusCode
});


@override $ApiResponsePaginationCopyWith<$Res> get paginationData;

}
/// @nodoc
class __$ApiResponseCopyWithImpl<$Res>
    implements _$ApiResponseCopyWith<$Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse _self;
  final $Res Function(_ApiResponse) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? simpleData = freezed,Object? totalItems = freezed,Object? paginationData = null,Object? error = freezed,Object? statusCode = freezed,}) {
  return _then(_ApiResponse(
data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,simpleData: freezed == simpleData ? _self._simpleData : simpleData // ignore: cast_nullable_to_non_nullable
as List<String>?,totalItems: freezed == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int?,paginationData: null == paginationData ? _self.paginationData : paginationData // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get paginationData {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.paginationData, (value) {
    return _then(_self.copyWith(paginationData: value));
  });
}
}


/// @nodoc
mixin _$ApiResponsePagination {

 String? get first; String? get last; String? get next; String? get previous;
/// Create a copy of ApiResponsePagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<ApiResponsePagination> get copyWith => _$ApiResponsePaginationCopyWithImpl<ApiResponsePagination>(this as ApiResponsePagination, _$identity);

  /// Serializes this ApiResponsePagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponsePagination&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,first,last,next,previous);

@override
String toString() {
  return 'ApiResponsePagination(first: $first, last: $last, next: $next, previous: $previous)';
}


}

/// @nodoc
abstract mixin class $ApiResponsePaginationCopyWith<$Res>  {
  factory $ApiResponsePaginationCopyWith(ApiResponsePagination value, $Res Function(ApiResponsePagination) _then) = _$ApiResponsePaginationCopyWithImpl;
@useResult
$Res call({
 String? first, String? last, String? next, String? previous
});




}
/// @nodoc
class _$ApiResponsePaginationCopyWithImpl<$Res>
    implements $ApiResponsePaginationCopyWith<$Res> {
  _$ApiResponsePaginationCopyWithImpl(this._self, this._then);

  final ApiResponsePagination _self;
  final $Res Function(ApiResponsePagination) _then;

/// Create a copy of ApiResponsePagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? first = freezed,Object? last = freezed,Object? next = freezed,Object? previous = freezed,}) {
  return _then(_self.copyWith(
first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as String?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ApiResponsePagination implements ApiResponsePagination {
  const _ApiResponsePagination({this.first, this.last, this.next, this.previous});
  factory _ApiResponsePagination.fromJson(Map<String, dynamic> json) => _$ApiResponsePaginationFromJson(json);

@override final  String? first;
@override final  String? last;
@override final  String? next;
@override final  String? previous;

/// Create a copy of ApiResponsePagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponsePaginationCopyWith<_ApiResponsePagination> get copyWith => __$ApiResponsePaginationCopyWithImpl<_ApiResponsePagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiResponsePaginationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponsePagination&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,first,last,next,previous);

@override
String toString() {
  return 'ApiResponsePagination(first: $first, last: $last, next: $next, previous: $previous)';
}


}

/// @nodoc
abstract mixin class _$ApiResponsePaginationCopyWith<$Res> implements $ApiResponsePaginationCopyWith<$Res> {
  factory _$ApiResponsePaginationCopyWith(_ApiResponsePagination value, $Res Function(_ApiResponsePagination) _then) = __$ApiResponsePaginationCopyWithImpl;
@override @useResult
$Res call({
 String? first, String? last, String? next, String? previous
});




}
/// @nodoc
class __$ApiResponsePaginationCopyWithImpl<$Res>
    implements _$ApiResponsePaginationCopyWith<$Res> {
  __$ApiResponsePaginationCopyWithImpl(this._self, this._then);

  final _ApiResponsePagination _self;
  final $Res Function(_ApiResponsePagination) _then;

/// Create a copy of ApiResponsePagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? first = freezed,Object? last = freezed,Object? next = freezed,Object? previous = freezed,}) {
  return _then(_ApiResponsePagination(
first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as String?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
