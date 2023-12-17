import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/notifications/local_notif_service.dart';

class PushNotificationManager {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  void init() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print(settings);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    firebaseMessaging.getToken().then((token) async {
      String firebaseToken = token.toString();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('firebase_token', firebaseToken);
      print(firebaseToken);
    });

    // get the App from terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });
    // Foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });
    // background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });
  }
}

//background notifications a Top-level function.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print(message.notification!.title);
    print(message.notification!.body);
  }
}
