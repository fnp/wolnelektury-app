// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPayload _$NotificationPayloadFromJson(Map<String, dynamic> json) =>
    _NotificationPayload(
      type: $enumDecode(
        _$NotificationTypeEnumMap,
        json['type'],
        unknownValue: NotificationType.app,
      ),
      itemId: json['itemId'] as String?,
    );

Map<String, dynamic> _$NotificationPayloadToJson(
  _NotificationPayload instance,
) => <String, dynamic>{
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'itemId': instance.itemId,
};

const _$NotificationTypeEnumMap = {
  NotificationType.book: 'book',
  NotificationType.app: 'app',
  NotificationType.author: 'author',
  NotificationType.settings: 'settings',
};
