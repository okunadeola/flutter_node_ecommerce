// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<bool> initialize() async{
    bool answer = false;
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    await _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        answer = true;
      }
    });

    return answer;
  }

  static void display(RemoteMessage message) async {
    try {
      final data = message.notification;
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails('flutecom', 'flutecom channel',
              importance: Importance.max, priority: Priority.high));
      await _notificationsPlugin.show(
          id, data!.title, data.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      print(e.toString());
    }
  }
}
