import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';

class FcmApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  initNotifacation() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print(fcmToken);
    FirebaseMessaging.onBackgroundMessage(handleBackground);
  }
}

Future<void> handleBackground(RemoteMessage message) async {
  print("title:${message.notification?.title}");

  print("title:${message.notification?.body}");
}
