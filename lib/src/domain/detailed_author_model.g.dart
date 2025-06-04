// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DetailedAuthorModel _$DetailedAuthorModelFromJson(Map<String, dynamic> json) =>
    _DetailedAuthorModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$DetailedAuthorModelToJson(
  _DetailedAuthorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'description': instance.description,
  'photo': instance.photo,
};
