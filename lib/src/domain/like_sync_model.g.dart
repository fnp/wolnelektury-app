// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_sync_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LikeSyncModel _$LikeSyncModelFromJson(Map<String, dynamic> json) =>
    _LikeSyncModel(
      slug: json['book_slug'] as String,
      deleted: json['deleted'] as bool? ?? false,
      favourite: json['favourite'] as bool? ?? true,
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LikeSyncModelToJson(_LikeSyncModel instance) =>
    <String, dynamic>{
      'book_slug': instance.slug,
      'deleted': instance.deleted,
      'favourite': instance.favourite,
      'timestamp': instance.timestamp,
    };
