import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/notification_service/notification_payload/notification_payload.dart';
import 'package:wolnelektury/src/application/notification_service/notifications_service.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'notification_cubit.freezed.dart';
part 'notification_state.dart';

class NotificationCubit extends SafeCubit<NotificationState> {
  final NotificationService notificationService;
  StreamSubscription? _notificationPayloadSubscription;

  NotificationCubit(this.notificationService)
    : super(const NotificationState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    // Listen for notification events and handle them
    _notificationPayloadSubscription = notificationService
        .notificationPayloadStream
        .listen(onNotificationEvent);

    // Check if app was opened from notification
    final initialPayload = await notificationService.getInitialMessage();
    if (initialPayload != null) {
      onNotificationEvent(initialPayload);
    }
  }

  // Handle notification events based on their payload
  void onNotificationEvent(NotificationPayload? notificationPayload) {
    if (notificationPayload == null) {
      return;
    }
    switch (notificationPayload.type) {
      case NotificationType.book:
        if (notificationPayload.itemId != null) {
          router.goNamed(
            bookPageConfig.name,
            pathParameters: {'slug': notificationPayload.itemId!},
          );
        }
        break;
      case NotificationType.app:
        // Handle app-level notifications if needed
        break;
    }
  }

  @override
  Future<void> close() {
    _notificationPayloadSubscription?.cancel();
    notificationService.close();
    return super.close();
  }
}
