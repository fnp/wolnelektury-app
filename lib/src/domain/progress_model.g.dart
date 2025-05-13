// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgressModelImpl _$$ProgressModelImplFromJson(Map<String, dynamic> json) =>
    _$ProgressModelImpl(
      book: json['book'] as String?,
      slug: json['slug'] as String?,
      lastMode: json['last_mode'] as String?,
      textPercent: (json['text_percent'] as num?)?.toDouble(),
      textAnchor: json['text_anchor'] as String?,
      audioPercent: (json['audio_percent'] as num?)?.toDouble(),
      audioTimestamp: (json['audio_timestamp'] as num?)?.toDouble(),
      implicitTextPercent: (json['implicit_text_percent'] as num?)?.toDouble(),
      implicitTextAnchor: json['implicit_text_anchor'] as String?,
      implicitAudioPercent:
          (json['implicit_audio_percent'] as num?)?.toDouble(),
      implicitAudioTimestamp:
          (json['implicit_audio_timestamp'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProgressModelImplToJson(_$ProgressModelImpl instance) =>
    <String, dynamic>{
      'book': instance.book,
      'slug': instance.slug,
      'last_mode': instance.lastMode,
      'text_percent': instance.textPercent,
      'text_anchor': instance.textAnchor,
      'audio_percent': instance.audioPercent,
      'audio_timestamp': instance.audioTimestamp,
      'implicit_text_percent': instance.implicitTextPercent,
      'implicit_text_anchor': instance.implicitTextAnchor,
      'implicit_audio_percent': instance.implicitAudioPercent,
      'implicit_audio_timestamp': instance.implicitAudioTimestamp,
    };

_$TextProgressModelImpl _$$TextProgressModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TextProgressModelImpl(
      textPercent: (json['text_percent'] as num?)?.toDouble(),
      textAnchor: json['text_anchor'] as String?,
    );

Map<String, dynamic> _$$TextProgressModelImplToJson(
        _$TextProgressModelImpl instance) =>
    <String, dynamic>{
      'text_percent': instance.textPercent,
      'text_anchor': instance.textAnchor,
    };

_$AudioProgressModelImpl _$$AudioProgressModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AudioProgressModelImpl(
      audioTimestamp: (json['audio_timestamp'] as num?)?.toInt(),
      audioPercent: (json['audio_percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AudioProgressModelImplToJson(
        _$AudioProgressModelImpl instance) =>
    <String, dynamic>{
      'audio_timestamp': instance.audioTimestamp,
      'audio_percent': instance.audioPercent,
    };
