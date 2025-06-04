// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => _GenreModel(
  url: json['url'] as String?,
  name: json['name'] as String?,
  href: json['href'] as String?,
  slug: json['slug'] as String?,
);

Map<String, dynamic> _$GenreModelToJson(_GenreModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'href': instance.href,
      'slug': instance.slug,
    };
