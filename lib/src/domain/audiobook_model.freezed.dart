// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audiobook_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudiobookModel {

 List<AudioBookPart> get parts;
/// Create a copy of AudiobookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudiobookModelCopyWith<AudiobookModel> get copyWith => _$AudiobookModelCopyWithImpl<AudiobookModel>(this as AudiobookModel, _$identity);

  /// Serializes this AudiobookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudiobookModel&&const DeepCollectionEquality().equals(other.parts, parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(parts));

@override
String toString() {
  return 'AudiobookModel(parts: $parts)';
}


}

/// @nodoc
abstract mixin class $AudiobookModelCopyWith<$Res>  {
  factory $AudiobookModelCopyWith(AudiobookModel value, $Res Function(AudiobookModel) _then) = _$AudiobookModelCopyWithImpl;
@useResult
$Res call({
 List<AudioBookPart> parts
});




}
/// @nodoc
class _$AudiobookModelCopyWithImpl<$Res>
    implements $AudiobookModelCopyWith<$Res> {
  _$AudiobookModelCopyWithImpl(this._self, this._then);

  final AudiobookModel _self;
  final $Res Function(AudiobookModel) _then;

/// Create a copy of AudiobookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? parts = null,}) {
  return _then(_self.copyWith(
parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<AudioBookPart>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AudiobookModel implements AudiobookModel {
  const _AudiobookModel({final  List<AudioBookPart> parts = const []}): _parts = parts;
  factory _AudiobookModel.fromJson(Map<String, dynamic> json) => _$AudiobookModelFromJson(json);

 final  List<AudioBookPart> _parts;
@override@JsonKey() List<AudioBookPart> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}


/// Create a copy of AudiobookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudiobookModelCopyWith<_AudiobookModel> get copyWith => __$AudiobookModelCopyWithImpl<_AudiobookModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudiobookModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudiobookModel&&const DeepCollectionEquality().equals(other._parts, _parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_parts));

@override
String toString() {
  return 'AudiobookModel(parts: $parts)';
}


}

/// @nodoc
abstract mixin class _$AudiobookModelCopyWith<$Res> implements $AudiobookModelCopyWith<$Res> {
  factory _$AudiobookModelCopyWith(_AudiobookModel value, $Res Function(_AudiobookModel) _then) = __$AudiobookModelCopyWithImpl;
@override @useResult
$Res call({
 List<AudioBookPart> parts
});




}
/// @nodoc
class __$AudiobookModelCopyWithImpl<$Res>
    implements _$AudiobookModelCopyWith<$Res> {
  __$AudiobookModelCopyWithImpl(this._self, this._then);

  final _AudiobookModel _self;
  final $Res Function(_AudiobookModel) _then;

/// Create a copy of AudiobookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? parts = null,}) {
  return _then(_AudiobookModel(
parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<AudioBookPart>,
  ));
}


}


/// @nodoc
mixin _$AudioBookPart {

 String get name; String get artist; String get director; String get url; double get duration; int get size;
/// Create a copy of AudioBookPart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioBookPartCopyWith<AudioBookPart> get copyWith => _$AudioBookPartCopyWithImpl<AudioBookPart>(this as AudioBookPart, _$identity);

  /// Serializes this AudioBookPart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioBookPart&&(identical(other.name, name) || other.name == name)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.director, director) || other.director == director)&&(identical(other.url, url) || other.url == url)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,artist,director,url,duration,size);

@override
String toString() {
  return 'AudioBookPart(name: $name, artist: $artist, director: $director, url: $url, duration: $duration, size: $size)';
}


}

/// @nodoc
abstract mixin class $AudioBookPartCopyWith<$Res>  {
  factory $AudioBookPartCopyWith(AudioBookPart value, $Res Function(AudioBookPart) _then) = _$AudioBookPartCopyWithImpl;
@useResult
$Res call({
 String name, String artist, String director, String url, double duration, int size
});




}
/// @nodoc
class _$AudioBookPartCopyWithImpl<$Res>
    implements $AudioBookPartCopyWith<$Res> {
  _$AudioBookPartCopyWithImpl(this._self, this._then);

  final AudioBookPart _self;
  final $Res Function(AudioBookPart) _then;

/// Create a copy of AudioBookPart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? artist = null,Object? director = null,Object? url = null,Object? duration = null,Object? size = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AudioBookPart implements AudioBookPart {
  const _AudioBookPart({required this.name, required this.artist, required this.director, required this.url, required this.duration, required this.size});
  factory _AudioBookPart.fromJson(Map<String, dynamic> json) => _$AudioBookPartFromJson(json);

@override final  String name;
@override final  String artist;
@override final  String director;
@override final  String url;
@override final  double duration;
@override final  int size;

/// Create a copy of AudioBookPart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioBookPartCopyWith<_AudioBookPart> get copyWith => __$AudioBookPartCopyWithImpl<_AudioBookPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioBookPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioBookPart&&(identical(other.name, name) || other.name == name)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.director, director) || other.director == director)&&(identical(other.url, url) || other.url == url)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,artist,director,url,duration,size);

@override
String toString() {
  return 'AudioBookPart(name: $name, artist: $artist, director: $director, url: $url, duration: $duration, size: $size)';
}


}

/// @nodoc
abstract mixin class _$AudioBookPartCopyWith<$Res> implements $AudioBookPartCopyWith<$Res> {
  factory _$AudioBookPartCopyWith(_AudioBookPart value, $Res Function(_AudioBookPart) _then) = __$AudioBookPartCopyWithImpl;
@override @useResult
$Res call({
 String name, String artist, String director, String url, double duration, int size
});




}
/// @nodoc
class __$AudioBookPartCopyWithImpl<$Res>
    implements _$AudioBookPartCopyWith<$Res> {
  __$AudioBookPartCopyWithImpl(this._self, this._then);

  final _AudioBookPart _self;
  final $Res Function(_AudioBookPart) _then;

/// Create a copy of AudioBookPart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? artist = null,Object? director = null,Object? url = null,Object? duration = null,Object? size = null,}) {
  return _then(_AudioBookPart(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
