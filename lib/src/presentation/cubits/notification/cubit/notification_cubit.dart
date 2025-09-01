import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/notification_service/notification_payload/notification_payload.dart';
import 'package:wolnelektury/src/application/notification_service/notifications_service.dart';
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
    //todo tutaj handlować powiadomienia i przekierowywać przy uzyciu routera
  }

  @override
  Future<void> close() {
    _notificationPayloadSubscription?.cancel();
    notificationService.close();
    return super.close();
  }
}
