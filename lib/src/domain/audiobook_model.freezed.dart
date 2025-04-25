// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audiobook_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudiobookModel _$AudiobookModelFromJson(Map<String, dynamic> json) {
  return _AudiobookModel.fromJson(json);
}

/// @nodoc
mixin _$AudiobookModel {
  List<AudioBookPart> get parts => throw _privateConstructorUsedError;

  /// Serializes this AudiobookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudiobookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudiobookModelCopyWith<AudiobookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudiobookModelCopyWith<$Res> {
  factory $AudiobookModelCopyWith(
          AudiobookModel value, $Res Function(AudiobookModel) then) =
      _$AudiobookModelCopyWithImpl<$Res, AudiobookModel>;
  @useResult
  $Res call({List<AudioBookPart> parts});
}

/// @nodoc
class _$AudiobookModelCopyWithImpl<$Res, $Val extends AudiobookModel>
    implements $AudiobookModelCopyWith<$Res> {
  _$AudiobookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudiobookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parts = null,
  }) {
    return _then(_value.copyWith(
      parts: null == parts
          ? _value.parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<AudioBookPart>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudiobookModelImplCopyWith<$Res>
    implements $AudiobookModelCopyWith<$Res> {
  factory _$$AudiobookModelImplCopyWith(_$AudiobookModelImpl value,
          $Res Function(_$AudiobookModelImpl) then) =
      __$$AudiobookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AudioBookPart> parts});
}

/// @nodoc
class __$$AudiobookModelImplCopyWithImpl<$Res>
    extends _$AudiobookModelCopyWithImpl<$Res, _$AudiobookModelImpl>
    implements _$$AudiobookModelImplCopyWith<$Res> {
  __$$AudiobookModelImplCopyWithImpl(
      _$AudiobookModelImpl _value, $Res Function(_$AudiobookModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudiobookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parts = null,
  }) {
    return _then(_$AudiobookModelImpl(
      parts: null == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<AudioBookPart>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudiobookModelImpl implements _AudiobookModel {
  const _$AudiobookModelImpl({final List<AudioBookPart> parts = const []})
      : _parts = parts;

  factory _$AudiobookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudiobookModelImplFromJson(json);

  final List<AudioBookPart> _parts;
  @override
  @JsonKey()
  List<AudioBookPart> get parts {
    if (_parts is EqualUnmodifiableListView) return _parts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parts);
  }

  @override
  String toString() {
    return 'AudiobookModel(parts: $parts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudiobookModelImpl &&
            const DeepCollectionEquality().equals(other._parts, _parts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_parts));

  /// Create a copy of AudiobookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudiobookModelImplCopyWith<_$AudiobookModelImpl> get copyWith =>
      __$$AudiobookModelImplCopyWithImpl<_$AudiobookModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudiobookModelImplToJson(
      this,
    );
  }
}

abstract class _AudiobookModel implements AudiobookModel {
  const factory _AudiobookModel({final List<AudioBookPart> parts}) =
      _$AudiobookModelImpl;

  factory _AudiobookModel.fromJson(Map<String, dynamic> json) =
      _$AudiobookModelImpl.fromJson;

  @override
  List<AudioBookPart> get parts;

  /// Create a copy of AudiobookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudiobookModelImplCopyWith<_$AudiobookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AudioBookPart _$AudioBookPartFromJson(Map<String, dynamic> json) {
  return _AudioBookPart.fromJson(json);
}

/// @nodoc
mixin _$AudioBookPart {
  String get name => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get director => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  /// Serializes this AudioBookPart to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioBookPart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioBookPartCopyWith<AudioBookPart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioBookPartCopyWith<$Res> {
  factory $AudioBookPartCopyWith(
          AudioBookPart value, $Res Function(AudioBookPart) then) =
      _$AudioBookPartCopyWithImpl<$Res, AudioBookPart>;
  @useResult
  $Res call(
      {String name,
      String artist,
      String director,
      String url,
      double duration,
      int size});
}

/// @nodoc
class _$AudioBookPartCopyWithImpl<$Res, $Val extends AudioBookPart>
    implements $AudioBookPartCopyWith<$Res> {
  _$AudioBookPartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioBookPart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? artist = null,
    Object? director = null,
    Object? url = null,
    Object? duration = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      director: null == director
          ? _value.director
          : director // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioBookPartImplCopyWith<$Res>
    implements $AudioBookPartCopyWith<$Res> {
  factory _$$AudioBookPartImplCopyWith(
          _$AudioBookPartImpl value, $Res Function(_$AudioBookPartImpl) then) =
      __$$AudioBookPartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String artist,
      String director,
      String url,
      double duration,
      int size});
}

/// @nodoc
class __$$AudioBookPartImplCopyWithImpl<$Res>
    extends _$AudioBookPartCopyWithImpl<$Res, _$AudioBookPartImpl>
    implements _$$AudioBookPartImplCopyWith<$Res> {
  __$$AudioBookPartImplCopyWithImpl(
      _$AudioBookPartImpl _value, $Res Function(_$AudioBookPartImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioBookPart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? artist = null,
    Object? director = null,
    Object? url = null,
    Object? duration = null,
    Object? size = null,
  }) {
    return _then(_$AudioBookPartImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      director: null == director
          ? _value.director
          : director // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioBookPartImpl implements _AudioBookPart {
  const _$AudioBookPartImpl(
      {required this.name,
      required this.artist,
      required this.director,
      required this.url,
      required this.duration,
      required this.size});

  factory _$AudioBookPartImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioBookPartImplFromJson(json);

  @override
  final String name;
  @override
  final String artist;
  @override
  final String director;
  @override
  final String url;
  @override
  final double duration;
  @override
  final int size;

  @override
  String toString() {
    return 'AudioBookPart(name: $name, artist: $artist, director: $director, url: $url, duration: $duration, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioBookPartImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.director, director) ||
                other.director == director) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, artist, director, url, duration, size);

  /// Create a copy of AudioBookPart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioBookPartImplCopyWith<_$AudioBookPartImpl> get copyWith =>
      __$$AudioBookPartImplCopyWithImpl<_$AudioBookPartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioBookPartImplToJson(
      this,
    );
  }
}

abstract class _AudioBookPart implements AudioBookPart {
  const factory _AudioBookPart(
      {required final String name,
      required final String artist,
      required final String director,
      required final String url,
      required final double duration,
      required final int size}) = _$AudioBookPartImpl;

  factory _AudioBookPart.fromJson(Map<String, dynamic> json) =
      _$AudioBookPartImpl.fromJson;

  @override
  String get name;
  @override
  String get artist;
  @override
  String get director;
  @override
  String get url;
  @override
  double get duration;
  @override
  int get size;

  /// Create a copy of AudioBookPart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioBookPartImplCopyWith<_$AudioBookPartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
