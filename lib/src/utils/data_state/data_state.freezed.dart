// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DataState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DataState<$T>()';
}


}

/// @nodoc
class $DataStateCopyWith<T,$Res>  {
$DataStateCopyWith(DataState<T> _, $Res Function(DataState<T>) __);
}


/// @nodoc


class DataStateSuccess<T> implements DataState<T> {
  const DataStateSuccess({required this.data, this.pagination});
  

 final  T data;
 final  ApiResponsePagination? pagination;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataStateSuccessCopyWith<T, DataStateSuccess<T>> get copyWith => _$DataStateSuccessCopyWithImpl<T, DataStateSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataStateSuccess<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),pagination);

@override
String toString() {
  return 'DataState<$T>.success(data: $data, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $DataStateSuccessCopyWith<T,$Res> implements $DataStateCopyWith<T, $Res> {
  factory $DataStateSuccessCopyWith(DataStateSuccess<T> value, $Res Function(DataStateSuccess<T>) _then) = _$DataStateSuccessCopyWithImpl;
@useResult
$Res call({
 T data, ApiResponsePagination? pagination
});


$ApiResponsePaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$DataStateSuccessCopyWithImpl<T,$Res>
    implements $DataStateSuccessCopyWith<T, $Res> {
  _$DataStateSuccessCopyWithImpl(this._self, this._then);

  final DataStateSuccess<T> _self;
  final $Res Function(DataStateSuccess<T>) _then;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? pagination = freezed,}) {
  return _then(DataStateSuccess<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination?,
  ));
}

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

/// @nodoc


class DataStateFailure<T> implements DataState<T> {
  const DataStateFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataStateFailureCopyWith<T, DataStateFailure<T>> get copyWith => _$DataStateFailureCopyWithImpl<T, DataStateFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataStateFailure<T>&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'DataState<$T>.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DataStateFailureCopyWith<T,$Res> implements $DataStateCopyWith<T, $Res> {
  factory $DataStateFailureCopyWith(DataStateFailure<T> value, $Res Function(DataStateFailure<T>) _then) = _$DataStateFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$DataStateFailureCopyWithImpl<T,$Res>
    implements $DataStateFailureCopyWith<T, $Res> {
  _$DataStateFailureCopyWithImpl(this._self, this._then);

  final DataStateFailure<T> _self;
  final $Res Function(DataStateFailure<T>) _then;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(DataStateFailure<T>(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
