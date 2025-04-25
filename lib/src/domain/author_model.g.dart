// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorModelImpl _$$AuthorModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthorModelImpl(
      url: json['url'] as String?,
      name: json['name'] as String?,
      href: json['href'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$$AuthorModelImplToJson(_$AuthorModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'href': instance.href,
      'slug': instance.slug,
    };
