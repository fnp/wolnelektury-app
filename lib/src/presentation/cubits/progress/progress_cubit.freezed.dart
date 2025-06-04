// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgressState {

 bool get isLoading; bool get isLoadingMore; List<ProgressModel> get progresses; ApiResponsePagination get pagination;
/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressStateCopyWith<ProgressState> get copyWith => _$ProgressStateCopyWithImpl<ProgressState>(this as ProgressState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.progresses, progresses)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(progresses),pagination);

@override
String toString() {
  return 'ProgressState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, progresses: $progresses, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $ProgressStateCopyWith<$Res>  {
  factory $ProgressStateCopyWith(ProgressState value, $Res Function(ProgressState) _then) = _$ProgressStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<ProgressModel> progresses, ApiResponsePagination pagination
});


$ApiResponsePaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class _$ProgressStateCopyWithImpl<$Res>
    implements $ProgressStateCopyWith<$Res> {
  _$ProgressStateCopyWithImpl(this._self, this._then);

  final ProgressState _self;
  final $Res Function(ProgressState) _then;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? progresses = null,Object? pagination = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,progresses: null == progresses ? _self.progresses : progresses // ignore: cast_nullable_to_non_nullable
as List<ProgressModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,
  ));
}
/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// @nodoc


class _ProgressState implements ProgressState {
  const _ProgressState({this.isLoading = false, this.isLoadingMore = false, final  List<ProgressModel> progresses = const [], this.pagination = const ApiResponsePagination()}): _progresses = progresses;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
 final  List<ProgressModel> _progresses;
@override@JsonKey() List<ProgressModel> get progresses {
  if (_progresses is EqualUnmodifiableListView) return _progresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_progresses);
}

@override@JsonKey() final  ApiResponsePagination pagination;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressStateCopyWith<_ProgressState> get copyWith => __$ProgressStateCopyWithImpl<_ProgressState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._progresses, _progresses)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_progresses),pagination);

@override
String toString() {
  return 'ProgressState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, progresses: $progresses, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$ProgressStateCopyWith<$Res> implements $ProgressStateCopyWith<$Res> {
  factory _$ProgressStateCopyWith(_ProgressState value, $Res Function(_ProgressState) _then) = __$ProgressStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<ProgressModel> progresses, ApiResponsePagination pagination
});


@override $ApiResponsePaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class __$ProgressStateCopyWithImpl<$Res>
    implements _$ProgressStateCopyWith<$Res> {
  __$ProgressStateCopyWithImpl(this._self, this._then);

  final _ProgressState _self;
  final $Res Function(_ProgressState) _then;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? progresses = null,Object? pagination = null,}) {
  return _then(_ProgressState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,progresses: null == progresses ? _self._progresses : progresses // ignore: cast_nullable_to_non_nullable
as List<ProgressModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ApiResponsePagination,
  ));
}

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiResponsePaginationCopyWith<$Res> get pagination {
  
  return $ApiResponsePaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

// dart format on
