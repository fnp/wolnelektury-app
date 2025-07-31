// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) =>
    _BookmarkModel(
      location: json['location'] as String,
      slug: json['book'] as String,
      note: json['note'] as String,
      anchor: json['anchor'] as String,
      href: json['href'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$BookmarkModelToJson(_BookmarkModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'book': instance.slug,
      'note': instance.note,
      'anchor': instance.anchor,
      'href': instance.href,
      'timestamp': instance.timestamp,
      'isDeleted': instance.isDeleted,
    };
