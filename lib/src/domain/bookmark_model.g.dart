// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkModelImpl _$$BookmarkModelImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkModelImpl(
      slug: json['book'] as String,
      note: json['note'] as String,
      anchor: json['anchor'] as String,
      href: json['href'] as String,
    );

Map<String, dynamic> _$$BookmarkModelImplToJson(_$BookmarkModelImpl instance) =>
    <String, dynamic>{
      'book': instance.slug,
      'note': instance.note,
      'anchor': instance.anchor,
      'href': instance.href,
    };
