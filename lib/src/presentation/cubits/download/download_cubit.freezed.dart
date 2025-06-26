// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DownloadState {

 double get progress; String? get downloadingBookSlug; bool get isAlreadyDownloadingError; bool get isGenericError;
/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadStateCopyWith<DownloadState> get copyWith => _$DownloadStateCopyWithImpl<DownloadState>(this as DownloadState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadState&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.downloadingBookSlug, downloadingBookSlug) || other.downloadingBookSlug == downloadingBookSlug)&&(identical(other.isAlreadyDownloadingError, isAlreadyDownloadingError) || other.isAlreadyDownloadingError == isAlreadyDownloadingError)&&(identical(other.isGenericError, isGenericError) || other.isGenericError == isGenericError));
}


@override
int get hashCode => Object.hash(runtimeType,progress,downloadingBookSlug,isAlreadyDownloadingError,isGenericError);

@override
String toString() {
  return 'DownloadState(progress: $progress, downloadingBookSlug: $downloadingBookSlug, isAlreadyDownloadingError: $isAlreadyDownloadingError, isGenericError: $isGenericError)';
}


}

/// @nodoc
abstract mixin class $DownloadStateCopyWith<$Res>  {
  factory $DownloadStateCopyWith(DownloadState value, $Res Function(DownloadState) _then) = _$DownloadStateCopyWithImpl;
@useResult
$Res call({
 double progress, String? downloadingBookSlug, bool isAlreadyDownloadingError, bool isGenericError
});




}
/// @nodoc
class _$DownloadStateCopyWithImpl<$Res>
    implements $DownloadStateCopyWith<$Res> {
  _$DownloadStateCopyWithImpl(this._self, this._then);

  final DownloadState _self;
  final $Res Function(DownloadState) _then;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? downloadingBookSlug = freezed,Object? isAlreadyDownloadingError = null,Object? isGenericError = null,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,downloadingBookSlug: freezed == downloadingBookSlug ? _self.downloadingBookSlug : downloadingBookSlug // ignore: cast_nullable_to_non_nullable
as String?,isAlreadyDownloadingError: null == isAlreadyDownloadingError ? _self.isAlreadyDownloadingError : isAlreadyDownloadingError // ignore: cast_nullable_to_non_nullable
as bool,isGenericError: null == isGenericError ? _self.isGenericError : isGenericError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _DownloadState implements DownloadState {
  const _DownloadState({this.progress = 0, this.downloadingBookSlug, this.isAlreadyDownloadingError = false, this.isGenericError = false});
  

@override@JsonKey() final  double progress;
@override final  String? downloadingBookSlug;
@override@JsonKey() final  bool isAlreadyDownloadingError;
@override@JsonKey() final  bool isGenericError;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadStateCopyWith<_DownloadState> get copyWith => __$DownloadStateCopyWithImpl<_DownloadState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadState&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.downloadingBookSlug, downloadingBookSlug) || other.downloadingBookSlug == downloadingBookSlug)&&(identical(other.isAlreadyDownloadingError, isAlreadyDownloadingError) || other.isAlreadyDownloadingError == isAlreadyDownloadingError)&&(identical(other.isGenericError, isGenericError) || other.isGenericError == isGenericError));
}


@override
int get hashCode => Object.hash(runtimeType,progress,downloadingBookSlug,isAlreadyDownloadingError,isGenericError);

@override
String toString() {
  return 'DownloadState(progress: $progress, downloadingBookSlug: $downloadingBookSlug, isAlreadyDownloadingError: $isAlreadyDownloadingError, isGenericError: $isGenericError)';
}


}

/// @nodoc
abstract mixin class _$DownloadStateCopyWith<$Res> implements $DownloadStateCopyWith<$Res> {
  factory _$DownloadStateCopyWith(_DownloadState value, $Res Function(_DownloadState) _then) = __$DownloadStateCopyWithImpl;
@override @useResult
$Res call({
 double progress, String? downloadingBookSlug, bool isAlreadyDownloadingError, bool isGenericError
});




}
/// @nodoc
class __$DownloadStateCopyWithImpl<$Res>
    implements _$DownloadStateCopyWith<$Res> {
  __$DownloadStateCopyWithImpl(this._self, this._then);

  final _DownloadState _self;
  final $Res Function(_DownloadState) _then;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? downloadingBookSlug = freezed,Object? isAlreadyDownloadingError = null,Object? isGenericError = null,}) {
  return _then(_DownloadState(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,downloadingBookSlug: freezed == downloadingBookSlug ? _self.downloadingBookSlug : downloadingBookSlug // ignore: cast_nullable_to_non_nullable
as String?,isAlreadyDownloadingError: null == isAlreadyDownloadingError ? _self.isAlreadyDownloadingError : isAlreadyDownloadingError // ignore: cast_nullable_to_non_nullable
as bool,isGenericError: null == isGenericError ? _self.isGenericError : isGenericError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
