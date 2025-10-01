// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kind_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KindModel _$KindModelFromJson(Map<String, dynamic> json) => _KindModel(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  name: json['name'] as String?,
  href: json['href'] as String?,
  slug: json['slug'] as String?,
);

Map<String, dynamic> _$KindModelToJson(_KindModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'href': instance.href,
      'slug': instance.slug,
    };
