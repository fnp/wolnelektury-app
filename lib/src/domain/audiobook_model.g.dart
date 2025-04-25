// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudiobookModelImpl _$$AudiobookModelImplFromJson(Map<String, dynamic> json) =>
    _$AudiobookModelImpl(
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => AudioBookPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AudiobookModelImplToJson(
        _$AudiobookModelImpl instance) =>
    <String, dynamic>{
      'parts': instance.parts,
    };

_$AudioBookPartImpl _$$AudioBookPartImplFromJson(Map<String, dynamic> json) =>
    _$AudioBookPartImpl(
      name: json['name'] as String,
      artist: json['artist'] as String,
      director: json['director'] as String,
      url: json['url'] as String,
      duration: (json['duration'] as num).toDouble(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$AudioBookPartImplToJson(_$AudioBookPartImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'artist': instance.artist,
      'director': instance.director,
      'url': instance.url,
      'duration': instance.duration,
      'size': instance.size,
    };
