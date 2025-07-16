// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncModelProgress _$SyncModelProgressFromJson(Map<String, dynamic> json) =>
    SyncModelProgress(
      id: json['id'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      type: $enumDecode(_$SyncTypeEnumMap, json['type']),
      object: ProgressModel.fromJson(json['object'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SyncModelProgressToJson(SyncModelProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'type': _$SyncTypeEnumMap[instance.type]!,
      'object': instance.object,
    };

const _$SyncTypeEnumMap = {
  SyncType.progress: 'progress',
  SyncType.userList: 'user-list',
};

SyncModelUserList _$SyncModelUserListFromJson(Map<String, dynamic> json) =>
    SyncModelUserList(
      id: json['id'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      type: $enumDecode(_$SyncTypeEnumMap, json['type']),
      object: json['object'],
    );

Map<String, dynamic> _$SyncModelUserListToJson(SyncModelUserList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'type': _$SyncTypeEnumMap[instance.type]!,
      'object': instance.object,
    };
