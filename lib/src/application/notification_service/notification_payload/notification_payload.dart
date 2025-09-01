import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_payload.freezed.dart';
part 'notification_payload.g.dart';

enum NotificationType {
  // Navigates to the book details page by passing the book slug as itemId
  @JsonValue('book')
  book,
  // Navigates to the app main page
  @JsonValue('app')
  app,
}

@freezed
sealed class NotificationPayload with _$NotificationPayload {
  const factory NotificationPayload({
    required NotificationType type,
    String? itemId,
  }) = _NotificationPayload;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadFromJson(json);
}
