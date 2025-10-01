// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epoch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EpochModel _$EpochModelFromJson(Map<String, dynamic> json) => _EpochModel(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  name: json['name'] as String?,
  href: json['href'] as String?,
  slug: json['slug'] as String?,
);

Map<String, dynamic> _$EpochModelToJson(_EpochModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'href': instance.href,
      'slug': instance.slug,
    };
