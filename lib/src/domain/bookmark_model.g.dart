// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) =>
    _BookmarkModel(
      location: json['location'] as String,
      slug: json['book'] as String,
      audioTimestamp: (json['audio_timestamp'] as num?)?.toInt(),
      anchor: json['anchor'] as String?,
      note: json['note'] as String,
      href: json['href'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$BookmarkModelToJson(_BookmarkModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'book': instance.slug,
      'audio_timestamp': instance.audioTimestamp,
      'anchor': instance.anchor,
      'note': instance.note,
      'href': instance.href,
      'timestamp': instance.timestamp,
      'isDeleted': instance.isDeleted,
    };
