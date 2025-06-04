// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) =>
    _BookmarkModel(
      slug: json['book'] as String,
      note: json['note'] as String,
      anchor: json['anchor'] as String,
      href: json['href'] as String,
    );

Map<String, dynamic> _$BookmarkModelToJson(_BookmarkModel instance) =>
    <String, dynamic>{
      'book': instance.slug,
      'note': instance.note,
      'anchor': instance.anchor,
      'href': instance.href,
    };
