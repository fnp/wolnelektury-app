// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) =>
    _ProgressModel(
      slug: json['book_slug'] as String?,
      textAnchor: json['text_anchor'] as String?,
      audioTimestamp: (json['audio_timestamp'] as num?)?.toInt(),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProgressModelToJson(_ProgressModel instance) =>
    <String, dynamic>{
      'book_slug': instance.slug,
      'text_anchor': instance.textAnchor,
      'audio_timestamp': instance.audioTimestamp,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
