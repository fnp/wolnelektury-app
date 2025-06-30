// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OfflineState {

 bool get isLoading; List<OfflineBookModel> get audiobooks; List<OfflineBookModel> get readers;
/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineStateCopyWith<OfflineState> get copyWith => _$OfflineStateCopyWithImpl<OfflineState>(this as OfflineState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.audiobooks, audiobooks)&&const DeepCollectionEquality().equals(other.readers, readers));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(audiobooks),const DeepCollectionEquality().hash(readers));

@override
String toString() {
  return 'OfflineState(isLoading: $isLoading, audiobooks: $audiobooks, readers: $readers)';
}


}

/// @nodoc
abstract mixin class $OfflineStateCopyWith<$Res>  {
  factory $OfflineStateCopyWith(OfflineState value, $Res Function(OfflineState) _then) = _$OfflineStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<OfflineBookModel> audiobooks, List<OfflineBookModel> readers
});




}
/// @nodoc
class _$OfflineStateCopyWithImpl<$Res>
    implements $OfflineStateCopyWith<$Res> {
  _$OfflineStateCopyWithImpl(this._self, this._then);

  final OfflineState _self;
  final $Res Function(OfflineState) _then;

/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? audiobooks = null,Object? readers = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,audiobooks: null == audiobooks ? _self.audiobooks : audiobooks // ignore: cast_nullable_to_non_nullable
as List<OfflineBookModel>,readers: null == readers ? _self.readers : readers // ignore: cast_nullable_to_non_nullable
as List<OfflineBookModel>,
  ));
}

}


/// @nodoc


class _OfflineState implements OfflineState {
  const _OfflineState({this.isLoading = false, final  List<OfflineBookModel> audiobooks = const [], final  List<OfflineBookModel> readers = const []}): _audiobooks = audiobooks,_readers = readers;
  

@override@JsonKey() final  bool isLoading;
 final  List<OfflineBookModel> _audiobooks;
@override@JsonKey() List<OfflineBookModel> get audiobooks {
  if (_audiobooks is EqualUnmodifiableListView) return _audiobooks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audiobooks);
}

 final  List<OfflineBookModel> _readers;
@override@JsonKey() List<OfflineBookModel> get readers {
  if (_readers is EqualUnmodifiableListView) return _readers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readers);
}


/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineStateCopyWith<_OfflineState> get copyWith => __$OfflineStateCopyWithImpl<_OfflineState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._audiobooks, _audiobooks)&&const DeepCollectionEquality().equals(other._readers, _readers));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_audiobooks),const DeepCollectionEquality().hash(_readers));

@override
String toString() {
  return 'OfflineState(isLoading: $isLoading, audiobooks: $audiobooks, readers: $readers)';
}


}

/// @nodoc
abstract mixin class _$OfflineStateCopyWith<$Res> implements $OfflineStateCopyWith<$Res> {
  factory _$OfflineStateCopyWith(_OfflineState value, $Res Function(_OfflineState) _then) = __$OfflineStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<OfflineBookModel> audiobooks, List<OfflineBookModel> readers
});




}
/// @nodoc
class __$OfflineStateCopyWithImpl<$Res>
    implements _$OfflineStateCopyWith<$Res> {
  __$OfflineStateCopyWithImpl(this._self, this._then);

  final _OfflineState _self;
  final $Res Function(_OfflineState) _then;

/// Create a copy of OfflineState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? audiobooks = null,Object? readers = null,}) {
  return _then(_OfflineState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,audiobooks: null == audiobooks ? _self._audiobooks : audiobooks // ignore: cast_nullable_to_non_nullable
as List<OfflineBookModel>,readers: null == readers ? _self._readers : readers // ignore: cast_nullable_to_non_nullable
as List<OfflineBookModel>,
  ));
}


}

// dart format on
