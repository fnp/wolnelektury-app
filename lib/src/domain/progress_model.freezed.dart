// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressModel {

@JsonKey(name: 'book_slug') String get slug;@JsonKey(name: 'text_anchor') String? get textAnchor;@JsonKey(name: 'audio_timestamp') int? get audioTimestamp;
/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<ProgressModel> get copyWith => _$ProgressModelCopyWithImpl<ProgressModel>(this as ProgressModel, _$identity);

  /// Serializes this ProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressModel&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.textAnchor, textAnchor) || other.textAnchor == textAnchor)&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,textAnchor,audioTimestamp);

@override
String toString() {
  return 'ProgressModel(slug: $slug, textAnchor: $textAnchor, audioTimestamp: $audioTimestamp)';
}


}

/// @nodoc
abstract mixin class $ProgressModelCopyWith<$Res>  {
  factory $ProgressModelCopyWith(ProgressModel value, $Res Function(ProgressModel) _then) = _$ProgressModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'book_slug') String slug,@JsonKey(name: 'text_anchor') String? textAnchor,@JsonKey(name: 'audio_timestamp') int? audioTimestamp
});




}
/// @nodoc
class _$ProgressModelCopyWithImpl<$Res>
    implements $ProgressModelCopyWith<$Res> {
  _$ProgressModelCopyWithImpl(this._self, this._then);

  final ProgressModel _self;
  final $Res Function(ProgressModel) _then;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? textAnchor = freezed,Object? audioTimestamp = freezed,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,textAnchor: freezed == textAnchor ? _self.textAnchor : textAnchor // ignore: cast_nullable_to_non_nullable
as String?,audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProgressModel implements ProgressModel {
  const _ProgressModel({@JsonKey(name: 'book_slug') required this.slug, @JsonKey(name: 'text_anchor') this.textAnchor, @JsonKey(name: 'audio_timestamp') this.audioTimestamp});
  factory _ProgressModel.fromJson(Map<String, dynamic> json) => _$ProgressModelFromJson(json);

@override@JsonKey(name: 'book_slug') final  String slug;
@override@JsonKey(name: 'text_anchor') final  String? textAnchor;
@override@JsonKey(name: 'audio_timestamp') final  int? audioTimestamp;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressModelCopyWith<_ProgressModel> get copyWith => __$ProgressModelCopyWithImpl<_ProgressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressModel&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.textAnchor, textAnchor) || other.textAnchor == textAnchor)&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,textAnchor,audioTimestamp);

@override
String toString() {
  return 'ProgressModel(slug: $slug, textAnchor: $textAnchor, audioTimestamp: $audioTimestamp)';
}


}

/// @nodoc
abstract mixin class _$ProgressModelCopyWith<$Res> implements $ProgressModelCopyWith<$Res> {
  factory _$ProgressModelCopyWith(_ProgressModel value, $Res Function(_ProgressModel) _then) = __$ProgressModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'book_slug') String slug,@JsonKey(name: 'text_anchor') String? textAnchor,@JsonKey(name: 'audio_timestamp') int? audioTimestamp
});




}
/// @nodoc
class __$ProgressModelCopyWithImpl<$Res>
    implements _$ProgressModelCopyWith<$Res> {
  __$ProgressModelCopyWithImpl(this._self, this._then);

  final _ProgressModel _self;
  final $Res Function(_ProgressModel) _then;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? textAnchor = freezed,Object? audioTimestamp = freezed,}) {
  return _then(_ProgressModel(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,textAnchor: freezed == textAnchor ? _self.textAnchor : textAnchor // ignore: cast_nullable_to_non_nullable
as String?,audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
