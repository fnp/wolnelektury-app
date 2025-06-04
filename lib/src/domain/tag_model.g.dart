// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TagModel _$TagModelFromJson(Map<String, dynamic> json) => _TagModel(
  id: (json['id'] as num).toInt(),
  category: json['category'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$TagModelToJson(_TagModel instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'name': instance.name,
};
