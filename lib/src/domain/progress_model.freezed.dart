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

 String? get book;@JsonKey(name: 'book_slug') String? get slug;@JsonKey(name: 'last_mode') String? get lastMode;@JsonKey(name: 'text_percent') double? get textPercent;@JsonKey(name: 'text_anchor') String? get textAnchor;@JsonKey(name: 'audio_percent') double? get audioPercent;@JsonKey(name: 'audio_timestamp') double? get audioTimestamp;@JsonKey(name: 'implicit_text_percent') double? get implicitTextPercent;@JsonKey(name: 'implicit_text_anchor') String? get implicitTextAnchor;@JsonKey(name: 'implicit_audio_percent') double? get implicitAudioPercent;@JsonKey(name: 'implicit_audio_timestamp') double? get implicitAudioTimestamp;
/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<ProgressModel> get copyWith => _$ProgressModelCopyWithImpl<ProgressModel>(this as ProgressModel, _$identity);

  /// Serializes this ProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressModel&&(identical(other.book, book) || other.book == book)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.lastMode, lastMode) || other.lastMode == lastMode)&&(identical(other.textPercent, textPercent) || other.textPercent == textPercent)&&(identical(other.textAnchor, textAnchor) || other.textAnchor == textAnchor)&&(identical(other.audioPercent, audioPercent) || other.audioPercent == audioPercent)&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp)&&(identical(other.implicitTextPercent, implicitTextPercent) || other.implicitTextPercent == implicitTextPercent)&&(identical(other.implicitTextAnchor, implicitTextAnchor) || other.implicitTextAnchor == implicitTextAnchor)&&(identical(other.implicitAudioPercent, implicitAudioPercent) || other.implicitAudioPercent == implicitAudioPercent)&&(identical(other.implicitAudioTimestamp, implicitAudioTimestamp) || other.implicitAudioTimestamp == implicitAudioTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,slug,lastMode,textPercent,textAnchor,audioPercent,audioTimestamp,implicitTextPercent,implicitTextAnchor,implicitAudioPercent,implicitAudioTimestamp);

@override
String toString() {
  return 'ProgressModel(book: $book, slug: $slug, lastMode: $lastMode, textPercent: $textPercent, textAnchor: $textAnchor, audioPercent: $audioPercent, audioTimestamp: $audioTimestamp, implicitTextPercent: $implicitTextPercent, implicitTextAnchor: $implicitTextAnchor, implicitAudioPercent: $implicitAudioPercent, implicitAudioTimestamp: $implicitAudioTimestamp)';
}


}

/// @nodoc
abstract mixin class $ProgressModelCopyWith<$Res>  {
  factory $ProgressModelCopyWith(ProgressModel value, $Res Function(ProgressModel) _then) = _$ProgressModelCopyWithImpl;
@useResult
$Res call({
 String? book,@JsonKey(name: 'book_slug') String? slug,@JsonKey(name: 'last_mode') String? lastMode,@JsonKey(name: 'text_percent') double? textPercent,@JsonKey(name: 'text_anchor') String? textAnchor,@JsonKey(name: 'audio_percent') double? audioPercent,@JsonKey(name: 'audio_timestamp') double? audioTimestamp,@JsonKey(name: 'implicit_text_percent') double? implicitTextPercent,@JsonKey(name: 'implicit_text_anchor') String? implicitTextAnchor,@JsonKey(name: 'implicit_audio_percent') double? implicitAudioPercent,@JsonKey(name: 'implicit_audio_timestamp') double? implicitAudioTimestamp
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
@pragma('vm:prefer-inline') @override $Res call({Object? book = freezed,Object? slug = freezed,Object? lastMode = freezed,Object? textPercent = freezed,Object? textAnchor = freezed,Object? audioPercent = freezed,Object? audioTimestamp = freezed,Object? implicitTextPercent = freezed,Object? implicitTextAnchor = freezed,Object? implicitAudioPercent = freezed,Object? implicitAudioTimestamp = freezed,}) {
  return _then(_self.copyWith(
book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,lastMode: freezed == lastMode ? _self.lastMode : lastMode // ignore: cast_nullable_to_non_nullable
as String?,textPercent: freezed == textPercent ? _self.textPercent : textPercent // ignore: cast_nullable_to_non_nullable
as double?,textAnchor: freezed == textAnchor ? _self.textAnchor : textAnchor // ignore: cast_nullable_to_non_nullable
as String?,audioPercent: freezed == audioPercent ? _self.audioPercent : audioPercent // ignore: cast_nullable_to_non_nullable
as double?,audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as double?,implicitTextPercent: freezed == implicitTextPercent ? _self.implicitTextPercent : implicitTextPercent // ignore: cast_nullable_to_non_nullable
as double?,implicitTextAnchor: freezed == implicitTextAnchor ? _self.implicitTextAnchor : implicitTextAnchor // ignore: cast_nullable_to_non_nullable
as String?,implicitAudioPercent: freezed == implicitAudioPercent ? _self.implicitAudioPercent : implicitAudioPercent // ignore: cast_nullable_to_non_nullable
as double?,implicitAudioTimestamp: freezed == implicitAudioTimestamp ? _self.implicitAudioTimestamp : implicitAudioTimestamp // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProgressModel implements ProgressModel {
  const _ProgressModel({this.book, @JsonKey(name: 'book_slug') this.slug, @JsonKey(name: 'last_mode') this.lastMode, @JsonKey(name: 'text_percent') this.textPercent, @JsonKey(name: 'text_anchor') this.textAnchor, @JsonKey(name: 'audio_percent') this.audioPercent, @JsonKey(name: 'audio_timestamp') this.audioTimestamp, @JsonKey(name: 'implicit_text_percent') this.implicitTextPercent, @JsonKey(name: 'implicit_text_anchor') this.implicitTextAnchor, @JsonKey(name: 'implicit_audio_percent') this.implicitAudioPercent, @JsonKey(name: 'implicit_audio_timestamp') this.implicitAudioTimestamp});
  factory _ProgressModel.fromJson(Map<String, dynamic> json) => _$ProgressModelFromJson(json);

@override final  String? book;
@override@JsonKey(name: 'book_slug') final  String? slug;
@override@JsonKey(name: 'last_mode') final  String? lastMode;
@override@JsonKey(name: 'text_percent') final  double? textPercent;
@override@JsonKey(name: 'text_anchor') final  String? textAnchor;
@override@JsonKey(name: 'audio_percent') final  double? audioPercent;
@override@JsonKey(name: 'audio_timestamp') final  double? audioTimestamp;
@override@JsonKey(name: 'implicit_text_percent') final  double? implicitTextPercent;
@override@JsonKey(name: 'implicit_text_anchor') final  String? implicitTextAnchor;
@override@JsonKey(name: 'implicit_audio_percent') final  double? implicitAudioPercent;
@override@JsonKey(name: 'implicit_audio_timestamp') final  double? implicitAudioTimestamp;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressModel&&(identical(other.book, book) || other.book == book)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.lastMode, lastMode) || other.lastMode == lastMode)&&(identical(other.textPercent, textPercent) || other.textPercent == textPercent)&&(identical(other.textAnchor, textAnchor) || other.textAnchor == textAnchor)&&(identical(other.audioPercent, audioPercent) || other.audioPercent == audioPercent)&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp)&&(identical(other.implicitTextPercent, implicitTextPercent) || other.implicitTextPercent == implicitTextPercent)&&(identical(other.implicitTextAnchor, implicitTextAnchor) || other.implicitTextAnchor == implicitTextAnchor)&&(identical(other.implicitAudioPercent, implicitAudioPercent) || other.implicitAudioPercent == implicitAudioPercent)&&(identical(other.implicitAudioTimestamp, implicitAudioTimestamp) || other.implicitAudioTimestamp == implicitAudioTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,slug,lastMode,textPercent,textAnchor,audioPercent,audioTimestamp,implicitTextPercent,implicitTextAnchor,implicitAudioPercent,implicitAudioTimestamp);

@override
String toString() {
  return 'ProgressModel(book: $book, slug: $slug, lastMode: $lastMode, textPercent: $textPercent, textAnchor: $textAnchor, audioPercent: $audioPercent, audioTimestamp: $audioTimestamp, implicitTextPercent: $implicitTextPercent, implicitTextAnchor: $implicitTextAnchor, implicitAudioPercent: $implicitAudioPercent, implicitAudioTimestamp: $implicitAudioTimestamp)';
}


}

/// @nodoc
abstract mixin class _$ProgressModelCopyWith<$Res> implements $ProgressModelCopyWith<$Res> {
  factory _$ProgressModelCopyWith(_ProgressModel value, $Res Function(_ProgressModel) _then) = __$ProgressModelCopyWithImpl;
@override @useResult
$Res call({
 String? book,@JsonKey(name: 'book_slug') String? slug,@JsonKey(name: 'last_mode') String? lastMode,@JsonKey(name: 'text_percent') double? textPercent,@JsonKey(name: 'text_anchor') String? textAnchor,@JsonKey(name: 'audio_percent') double? audioPercent,@JsonKey(name: 'audio_timestamp') double? audioTimestamp,@JsonKey(name: 'implicit_text_percent') double? implicitTextPercent,@JsonKey(name: 'implicit_text_anchor') String? implicitTextAnchor,@JsonKey(name: 'implicit_audio_percent') double? implicitAudioPercent,@JsonKey(name: 'implicit_audio_timestamp') double? implicitAudioTimestamp
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
@override @pragma('vm:prefer-inline') $Res call({Object? book = freezed,Object? slug = freezed,Object? lastMode = freezed,Object? textPercent = freezed,Object? textAnchor = freezed,Object? audioPercent = freezed,Object? audioTimestamp = freezed,Object? implicitTextPercent = freezed,Object? implicitTextAnchor = freezed,Object? implicitAudioPercent = freezed,Object? implicitAudioTimestamp = freezed,}) {
  return _then(_ProgressModel(
book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,lastMode: freezed == lastMode ? _self.lastMode : lastMode // ignore: cast_nullable_to_non_nullable
as String?,textPercent: freezed == textPercent ? _self.textPercent : textPercent // ignore: cast_nullable_to_non_nullable
as double?,textAnchor: freezed == textAnchor ? _self.textAnchor : textAnchor // ignore: cast_nullable_to_non_nullable
as String?,audioPercent: freezed == audioPercent ? _self.audioPercent : audioPercent // ignore: cast_nullable_to_non_nullable
as double?,audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as double?,implicitTextPercent: freezed == implicitTextPercent ? _self.implicitTextPercent : implicitTextPercent // ignore: cast_nullable_to_non_nullable
as double?,implicitTextAnchor: freezed == implicitTextAnchor ? _self.implicitTextAnchor : implicitTextAnchor // ignore: cast_nullable_to_non_nullable
as String?,implicitAudioPercent: freezed == implicitAudioPercent ? _self.implicitAudioPercent : implicitAudioPercent // ignore: cast_nullable_to_non_nullable
as double?,implicitAudioTimestamp: freezed == implicitAudioTimestamp ? _self.implicitAudioTimestamp : implicitAudioTimestamp // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$TextProgressModel {

@JsonKey(name: 'text_percent') double? get textPercent;@JsonKey(name: 'text_anchor') String? get textAnchor;
/// Create a copy of TextProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextProgressModelCopyWith<TextProgressModel> get copyWith => _$TextProgressModelCopyWithImpl<TextProgressModel>(this as TextProgressModel, _$identity);

  /// Serializes this TextProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextProgressModel&&(identical(other.textPercent, textPercent) || other.textPercent == textPercent)&&(identical(other.textAnchor, textAnchor) || other.textAnchor == textAnchor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textPercent,textAnchor);

@override
String toString() {
  return 'TextProgressModel(textPercent: $textPercent, textAnchor: $textAnchor)';
}


}

/// @nodoc
abstract mixin class $TextProgressModelCopyWith<$Res>  {
  factory $TextProgressModelCopyWith(TextProgressModel value, $Res Function(TextProgressModel) _then) = _$TextProgressModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'text_percent') double? textPercent,@JsonKey(name: 'text_anchor') String? textAnchor
});




}
/// @nodoc
class _$TextProgressModelCopyWithImpl<$Res>
    implements $TextProgressModelCopyWith<$Res> {
  _$TextProgressModelCopyWithImpl(this._self, this._then);

  final TextProgressModel _self;
  final $Res Function(TextProgressModel) _then;

/// Create a copy of TextProgressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textPercent = freezed,Object? textAnchor = freezed,}) {
  return _then(_self.copyWith(
textPercent: freezed == textPercent ? _self.textPercent : textPercent // ignore: cast_nullable_to_non_nullable
as double?,textAnchor: freezed == textAnchor ? _self.textAnchor : textAnchor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TextProgressModel implements TextProgressModel {
  const _TextProgressModel({@JsonKey(name: 'text_percent') this.textPercent, @JsonKey(name: 'text_anchor') this.textAnchor});
  factory _TextProgressModel.fromJson(Map<String, dynamic> json) => _$TextProgressModelFromJson(json);

@override@JsonKey(name: 'text_percent') final  double? textPercent;
@override@JsonKey(name: 'text_anchor') final  String? textAnchor;

/// Create a copy of TextProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextProgressModelCopyWith<_TextProgressModel> get copyWith => __$TextProgressModelCopyWithImpl<_TextProgressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextProgressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextProgressModel&&(identical(other.textPercent, textPercent) || other.textPercent == textPercent)&&(identical(other.textAnchor, textAnchor) || other.textAnchor == textAnchor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textPercent,textAnchor);

@override
String toString() {
  return 'TextProgressModel(textPercent: $textPercent, textAnchor: $textAnchor)';
}


}

/// @nodoc
abstract mixin class _$TextProgressModelCopyWith<$Res> implements $TextProgressModelCopyWith<$Res> {
  factory _$TextProgressModelCopyWith(_TextProgressModel value, $Res Function(_TextProgressModel) _then) = __$TextProgressModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'text_percent') double? textPercent,@JsonKey(name: 'text_anchor') String? textAnchor
});




}
/// @nodoc
class __$TextProgressModelCopyWithImpl<$Res>
    implements _$TextProgressModelCopyWith<$Res> {
  __$TextProgressModelCopyWithImpl(this._self, this._then);

  final _TextProgressModel _self;
  final $Res Function(_TextProgressModel) _then;

/// Create a copy of TextProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textPercent = freezed,Object? textAnchor = freezed,}) {
  return _then(_TextProgressModel(
textPercent: freezed == textPercent ? _self.textPercent : textPercent // ignore: cast_nullable_to_non_nullable
as double?,textAnchor: freezed == textAnchor ? _self.textAnchor : textAnchor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AudioProgressModel {

@JsonKey(name: 'audio_timestamp') int? get audioTimestamp;@JsonKey(name: 'audio_percent') double? get audioPercent;
/// Create a copy of AudioProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioProgressModelCopyWith<AudioProgressModel> get copyWith => _$AudioProgressModelCopyWithImpl<AudioProgressModel>(this as AudioProgressModel, _$identity);

  /// Serializes this AudioProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioProgressModel&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp)&&(identical(other.audioPercent, audioPercent) || other.audioPercent == audioPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioTimestamp,audioPercent);

@override
String toString() {
  return 'AudioProgressModel(audioTimestamp: $audioTimestamp, audioPercent: $audioPercent)';
}


}

/// @nodoc
abstract mixin class $AudioProgressModelCopyWith<$Res>  {
  factory $AudioProgressModelCopyWith(AudioProgressModel value, $Res Function(AudioProgressModel) _then) = _$AudioProgressModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'audio_timestamp') int? audioTimestamp,@JsonKey(name: 'audio_percent') double? audioPercent
});




}
/// @nodoc
class _$AudioProgressModelCopyWithImpl<$Res>
    implements $AudioProgressModelCopyWith<$Res> {
  _$AudioProgressModelCopyWithImpl(this._self, this._then);

  final AudioProgressModel _self;
  final $Res Function(AudioProgressModel) _then;

/// Create a copy of AudioProgressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? audioTimestamp = freezed,Object? audioPercent = freezed,}) {
  return _then(_self.copyWith(
audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as int?,audioPercent: freezed == audioPercent ? _self.audioPercent : audioPercent // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AudioProgressModel implements AudioProgressModel {
  const _AudioProgressModel({@JsonKey(name: 'audio_timestamp') this.audioTimestamp, @JsonKey(name: 'audio_percent') this.audioPercent});
  factory _AudioProgressModel.fromJson(Map<String, dynamic> json) => _$AudioProgressModelFromJson(json);

@override@JsonKey(name: 'audio_timestamp') final  int? audioTimestamp;
@override@JsonKey(name: 'audio_percent') final  double? audioPercent;

/// Create a copy of AudioProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioProgressModelCopyWith<_AudioProgressModel> get copyWith => __$AudioProgressModelCopyWithImpl<_AudioProgressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioProgressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioProgressModel&&(identical(other.audioTimestamp, audioTimestamp) || other.audioTimestamp == audioTimestamp)&&(identical(other.audioPercent, audioPercent) || other.audioPercent == audioPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioTimestamp,audioPercent);

@override
String toString() {
  return 'AudioProgressModel(audioTimestamp: $audioTimestamp, audioPercent: $audioPercent)';
}


}

/// @nodoc
abstract mixin class _$AudioProgressModelCopyWith<$Res> implements $AudioProgressModelCopyWith<$Res> {
  factory _$AudioProgressModelCopyWith(_AudioProgressModel value, $Res Function(_AudioProgressModel) _then) = __$AudioProgressModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'audio_timestamp') int? audioTimestamp,@JsonKey(name: 'audio_percent') double? audioPercent
});




}
/// @nodoc
class __$AudioProgressModelCopyWithImpl<$Res>
    implements _$AudioProgressModelCopyWith<$Res> {
  __$AudioProgressModelCopyWithImpl(this._self, this._then);

  final _AudioProgressModel _self;
  final $Res Function(_AudioProgressModel) _then;

/// Create a copy of AudioProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? audioTimestamp = freezed,Object? audioPercent = freezed,}) {
  return _then(_AudioProgressModel(
audioTimestamp: freezed == audioTimestamp ? _self.audioTimestamp : audioTimestamp // ignore: cast_nullable_to_non_nullable
as int?,audioPercent: freezed == audioPercent ? _self.audioPercent : audioPercent // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
