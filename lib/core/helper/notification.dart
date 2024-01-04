import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static Future<void> initialize(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user Permissed');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user Permission provistional');
    } else {
      print('user Permissed declined');
    }

    // Initialize Firebase Messaging
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Subscribe to Firebase Messaging onMessage event
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "onBackground: ${message.notification?.title}/${message.notification?.body}/"
          "${message.notification?.titleLocKey}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin);
    });

    // Subscribe to Firebase Messaging onMessageOpenedApp event
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("------------------onMessage----------------");
      print(
          "onBackground: ${message.notification?.title}/${message.notification?.body}/"
          "${message.notification?.titleLocKey}");
    });

    // Initialize FlutterLocalNotificationsPlugin
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var initializingSettings =
        InitializationSettings(android: androidInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializingSettings,
        onDidReceiveNotificationResponse: (NotificationResponse? payload) {
      try {
        if (payload != null) {}
      } catch (e) {
        print(e.toString());
      }
      return;
    });
  }

  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    // Create BigTextStyleInformation for notification content
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body!,
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatContentTitle: true,
    );

    // Create Android-specific notification details
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id_1', 'BettaStore',
            importance: Importance.high,
            styleInformation: bigTextStyleInformation,
            priority: Priority.high,
            playSound: true);

    // Create platform-specific notification details
    NotificationDetails platformSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show the notification using FlutterLocalNotificationsPlugin
    await fln.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformSpecifics,
    );
    FirebaseMessaging.onMessage.listen((event) {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "onBackground: ${message.notification?.title}/${message.notification?.body}/"
          "${message.notification?.titleLocKey}");
    });
  }

  static void sendPushNotification(
      String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAv2S7Nvk:APA91bFrfxdl60hhHs4_1xV8k_ps_jIGrpWo0xpxTG2G0vaaybW3qUsnxLAcm_FCorYn-PYRARqVQVvL7DhMS5ZuSY2uZBjv-syXqGjQz1WCJz6Wr4ceBrIjOQV9jnFPz-1_JO82_da7'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "body": body,
              "title": title,
              "android_channel_id": "BettaStore",
            },
            "to": token,
          }));
    } catch (e) {
      print("error here........................$e");
    }
  }
}
