// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudiobookModel _$AudiobookModelFromJson(Map<String, dynamic> json) =>
    _AudiobookModel(
      parts:
          (json['parts'] as List<dynamic>?)
              ?.map((e) => AudioBookPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AudiobookModelToJson(_AudiobookModel instance) =>
    <String, dynamic>{'parts': instance.parts};

_AudioBookPart _$AudioBookPartFromJson(Map<String, dynamic> json) =>
    _AudioBookPart(
      name: json['name'] as String,
      artist: json['artist'] as String,
      director: json['director'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      duration: (json['duration'] as num).toDouble(),
      size: (json['size'] as num).toInt(),
      isOffline: json['isOffline'] as bool? ?? false,
    );

Map<String, dynamic> _$AudioBookPartToJson(_AudioBookPart instance) =>
    <String, dynamic>{
      'name': instance.name,
      'artist': instance.artist,
      'director': instance.director,
      'type': instance.type,
      'url': instance.url,
      'duration': instance.duration,
      'size': instance.size,
      'isOffline': instance.isOffline,
    };
