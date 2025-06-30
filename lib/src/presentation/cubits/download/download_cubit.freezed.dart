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

 double get progress; String? get downloadingBookAudiobookSlug; String? get downloadingBookReaderSlug; bool get isAlreadyDownloadingAudiobookError; bool get isAlreadyDownloadingReaderError; bool get isGenericAudiobookError; bool get isGenericReaderError;
/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadStateCopyWith<DownloadState> get copyWith => _$DownloadStateCopyWithImpl<DownloadState>(this as DownloadState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadState&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.downloadingBookAudiobookSlug, downloadingBookAudiobookSlug) || other.downloadingBookAudiobookSlug == downloadingBookAudiobookSlug)&&(identical(other.downloadingBookReaderSlug, downloadingBookReaderSlug) || other.downloadingBookReaderSlug == downloadingBookReaderSlug)&&(identical(other.isAlreadyDownloadingAudiobookError, isAlreadyDownloadingAudiobookError) || other.isAlreadyDownloadingAudiobookError == isAlreadyDownloadingAudiobookError)&&(identical(other.isAlreadyDownloadingReaderError, isAlreadyDownloadingReaderError) || other.isAlreadyDownloadingReaderError == isAlreadyDownloadingReaderError)&&(identical(other.isGenericAudiobookError, isGenericAudiobookError) || other.isGenericAudiobookError == isGenericAudiobookError)&&(identical(other.isGenericReaderError, isGenericReaderError) || other.isGenericReaderError == isGenericReaderError));
}


@override
int get hashCode => Object.hash(runtimeType,progress,downloadingBookAudiobookSlug,downloadingBookReaderSlug,isAlreadyDownloadingAudiobookError,isAlreadyDownloadingReaderError,isGenericAudiobookError,isGenericReaderError);

@override
String toString() {
  return 'DownloadState(progress: $progress, downloadingBookAudiobookSlug: $downloadingBookAudiobookSlug, downloadingBookReaderSlug: $downloadingBookReaderSlug, isAlreadyDownloadingAudiobookError: $isAlreadyDownloadingAudiobookError, isAlreadyDownloadingReaderError: $isAlreadyDownloadingReaderError, isGenericAudiobookError: $isGenericAudiobookError, isGenericReaderError: $isGenericReaderError)';
}


}

/// @nodoc
abstract mixin class $DownloadStateCopyWith<$Res>  {
  factory $DownloadStateCopyWith(DownloadState value, $Res Function(DownloadState) _then) = _$DownloadStateCopyWithImpl;
@useResult
$Res call({
 double progress, String? downloadingBookAudiobookSlug, String? downloadingBookReaderSlug, bool isAlreadyDownloadingAudiobookError, bool isAlreadyDownloadingReaderError, bool isGenericAudiobookError, bool isGenericReaderError
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
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? downloadingBookAudiobookSlug = freezed,Object? downloadingBookReaderSlug = freezed,Object? isAlreadyDownloadingAudiobookError = null,Object? isAlreadyDownloadingReaderError = null,Object? isGenericAudiobookError = null,Object? isGenericReaderError = null,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,downloadingBookAudiobookSlug: freezed == downloadingBookAudiobookSlug ? _self.downloadingBookAudiobookSlug : downloadingBookAudiobookSlug // ignore: cast_nullable_to_non_nullable
as String?,downloadingBookReaderSlug: freezed == downloadingBookReaderSlug ? _self.downloadingBookReaderSlug : downloadingBookReaderSlug // ignore: cast_nullable_to_non_nullable
as String?,isAlreadyDownloadingAudiobookError: null == isAlreadyDownloadingAudiobookError ? _self.isAlreadyDownloadingAudiobookError : isAlreadyDownloadingAudiobookError // ignore: cast_nullable_to_non_nullable
as bool,isAlreadyDownloadingReaderError: null == isAlreadyDownloadingReaderError ? _self.isAlreadyDownloadingReaderError : isAlreadyDownloadingReaderError // ignore: cast_nullable_to_non_nullable
as bool,isGenericAudiobookError: null == isGenericAudiobookError ? _self.isGenericAudiobookError : isGenericAudiobookError // ignore: cast_nullable_to_non_nullable
as bool,isGenericReaderError: null == isGenericReaderError ? _self.isGenericReaderError : isGenericReaderError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _DownloadState implements DownloadState {
  const _DownloadState({this.progress = 0, this.downloadingBookAudiobookSlug, this.downloadingBookReaderSlug, this.isAlreadyDownloadingAudiobookError = false, this.isAlreadyDownloadingReaderError = false, this.isGenericAudiobookError = false, this.isGenericReaderError = false});
  

@override@JsonKey() final  double progress;
@override final  String? downloadingBookAudiobookSlug;
@override final  String? downloadingBookReaderSlug;
@override@JsonKey() final  bool isAlreadyDownloadingAudiobookError;
@override@JsonKey() final  bool isAlreadyDownloadingReaderError;
@override@JsonKey() final  bool isGenericAudiobookError;
@override@JsonKey() final  bool isGenericReaderError;

/// Create a copy of DownloadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadStateCopyWith<_DownloadState> get copyWith => __$DownloadStateCopyWithImpl<_DownloadState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadState&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.downloadingBookAudiobookSlug, downloadingBookAudiobookSlug) || other.downloadingBookAudiobookSlug == downloadingBookAudiobookSlug)&&(identical(other.downloadingBookReaderSlug, downloadingBookReaderSlug) || other.downloadingBookReaderSlug == downloadingBookReaderSlug)&&(identical(other.isAlreadyDownloadingAudiobookError, isAlreadyDownloadingAudiobookError) || other.isAlreadyDownloadingAudiobookError == isAlreadyDownloadingAudiobookError)&&(identical(other.isAlreadyDownloadingReaderError, isAlreadyDownloadingReaderError) || other.isAlreadyDownloadingReaderError == isAlreadyDownloadingReaderError)&&(identical(other.isGenericAudiobookError, isGenericAudiobookError) || other.isGenericAudiobookError == isGenericAudiobookError)&&(identical(other.isGenericReaderError, isGenericReaderError) || other.isGenericReaderError == isGenericReaderError));
}


@override
int get hashCode => Object.hash(runtimeType,progress,downloadingBookAudiobookSlug,downloadingBookReaderSlug,isAlreadyDownloadingAudiobookError,isAlreadyDownloadingReaderError,isGenericAudiobookError,isGenericReaderError);

@override
String toString() {
  return 'DownloadState(progress: $progress, downloadingBookAudiobookSlug: $downloadingBookAudiobookSlug, downloadingBookReaderSlug: $downloadingBookReaderSlug, isAlreadyDownloadingAudiobookError: $isAlreadyDownloadingAudiobookError, isAlreadyDownloadingReaderError: $isAlreadyDownloadingReaderError, isGenericAudiobookError: $isGenericAudiobookError, isGenericReaderError: $isGenericReaderError)';
}


}

/// @nodoc
abstract mixin class _$DownloadStateCopyWith<$Res> implements $DownloadStateCopyWith<$Res> {
  factory _$DownloadStateCopyWith(_DownloadState value, $Res Function(_DownloadState) _then) = __$DownloadStateCopyWithImpl;
@override @useResult
$Res call({
 double progress, String? downloadingBookAudiobookSlug, String? downloadingBookReaderSlug, bool isAlreadyDownloadingAudiobookError, bool isAlreadyDownloadingReaderError, bool isGenericAudiobookError, bool isGenericReaderError
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
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? downloadingBookAudiobookSlug = freezed,Object? downloadingBookReaderSlug = freezed,Object? isAlreadyDownloadingAudiobookError = null,Object? isAlreadyDownloadingReaderError = null,Object? isGenericAudiobookError = null,Object? isGenericReaderError = null,}) {
  return _then(_DownloadState(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,downloadingBookAudiobookSlug: freezed == downloadingBookAudiobookSlug ? _self.downloadingBookAudiobookSlug : downloadingBookAudiobookSlug // ignore: cast_nullable_to_non_nullable
as String?,downloadingBookReaderSlug: freezed == downloadingBookReaderSlug ? _self.downloadingBookReaderSlug : downloadingBookReaderSlug // ignore: cast_nullable_to_non_nullable
as String?,isAlreadyDownloadingAudiobookError: null == isAlreadyDownloadingAudiobookError ? _self.isAlreadyDownloadingAudiobookError : isAlreadyDownloadingAudiobookError // ignore: cast_nullable_to_non_nullable
as bool,isAlreadyDownloadingReaderError: null == isAlreadyDownloadingReaderError ? _self.isAlreadyDownloadingReaderError : isAlreadyDownloadingReaderError // ignore: cast_nullable_to_non_nullable
as bool,isGenericAudiobookError: null == isGenericAudiobookError ? _self.isGenericAudiobookError : isGenericAudiobookError // ignore: cast_nullable_to_non_nullable
as bool,isGenericReaderError: null == isGenericReaderError ? _self.isGenericReaderError : isGenericReaderError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
