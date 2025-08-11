// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HintModel _$HintModelFromJson(Map<String, dynamic> json) => _HintModel(
  type: $enumDecode(
    _$HintTypeEnumEnumMap,
    json['type'],
    unknownValue: HintTypeEnum.unknown,
  ),
  label: json['label'] as String,
  url: json['url'] as String?,
  img: json['img'] as String?,
  slug: json['slug'] as String?,
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$HintModelToJson(_HintModel instance) =>
    <String, dynamic>{
      'type': _$HintTypeEnumEnumMap[instance.type]!,
      'label': instance.label,
      'url': instance.url,
      'img': instance.img,
      'slug': instance.slug,
      'id': instance.id,
    };

const _$HintTypeEnumEnumMap = {
  HintTypeEnum.author: 'author',
  HintTypeEnum.genre: 'genre',
  HintTypeEnum.epoch: 'epoch',
  HintTypeEnum.kind: 'kind',
  HintTypeEnum.book: 'book',
  HintTypeEnum.unknown: 'unknown',
};
