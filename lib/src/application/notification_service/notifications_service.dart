import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:wolnelektury/src/application/notification_service/notification_payload/notification_payload.dart';

class NotificationService {
  NotificationService();
  final notificationPayloadStream =
      BehaviorSubject<NotificationPayload?>.seeded(null);

  StreamSubscription? _notificationOpenedSubscription;

  void initialize() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    _notificationOpenedSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen((event) {
          try {
            final payload = NotificationPayload.fromJson(event.data);
            notificationPayloadStream.add(payload);
          } catch (e) {
            if (kDebugMode) {
              print('Cant read the notification payload');
            }
          }
        });
  }

  static Future<String?> getNotificationToken() async {
    final id = await FirebaseMessaging.instance.getToken();
    return id;
  }

  Future<NotificationPayload?> getInitialMessage() async {
    final payload = await FirebaseMessaging.instance.getInitialMessage();
    if (payload == null) {
      return null;
    }
    try {
      final parsedPayload = NotificationPayload.fromJson(payload.data);
      return parsedPayload;
    } catch (_) {
      return null;
    }
  }

  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();

    if (kDebugMode) {
      print('Handling a background message: ${message.notification}');
    }
  }

  void close() {
    notificationPayloadStream.close();
    _notificationOpenedSubscription?.cancel();
  }
}
