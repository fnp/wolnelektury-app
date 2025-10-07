import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_payload.freezed.dart';
part 'notification_payload.g.dart';

enum NotificationType {
  /// Navigates to the book details page by passing the book slug as itemId
  book,

  /// Navigates to the app main page
  app,

  /// Navigates to the author details page by passing the author slug as itemId
  author,

  /// Navigates to the settings page
  settings,
}

@freezed
sealed class NotificationPayload with _$NotificationPayload {
  const factory NotificationPayload({
    @JsonKey(unknownEnumValue: NotificationType.app)
    required NotificationType type,
    String? itemId,
  }) = _NotificationPayload;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadFromJson(json);
}
