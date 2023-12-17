import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zagoffer/screens/home_screen.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize(BuildContext context) {
    final InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notificationsPlugin.initialize(
      settings,
      onSelectNotification: (String? payLoad) async {
        Navigator.of(context).pushNamed(HomePage.routeName);
      },
    );
  }

// show notificatios when foreground
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().second;
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'zag_offer',
          'zag_offer_channel',
          'This is our channel',
          importance: Importance.high,
          priority: Priority.high,
        ),
      );
      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
