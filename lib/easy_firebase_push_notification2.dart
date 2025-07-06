



/// A Calculator.
///
///
///
///





library easy_firebase_push_notification.dart;

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

// class EasyFirebasePush {
//   static final EasyFirebasePush _instance = EasyFirebasePush._internal();
//
//   factory EasyFirebasePush() {
//     return _instance;
//   }
//
//   EasyFirebasePush._internal();
//
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//   Future<void> initialize({
//     required Function(RemoteMessage) onBackground,
//     Function(RemoteMessage)? onMessage,
//     Function(RemoteMessage)? onMessageOpenedApp,
//   }) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//
//     // Background handler
//     FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//       await Firebase.initializeApp();
//       onBackground(message);
//     });
//
//     await _initLocalNotifications();
//
//     await _messaging.requestPermission();
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (onMessage != null) onMessage(message);
//       _showLocalNotification(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (onMessageOpenedApp != null) onMessageOpenedApp(message);
//     });
//   }
//
//   Future<void> _initLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: androidSettings);
//
//     await _localNotificationsPlugin.initialize(settings);
//   }
//
//   void _showLocalNotification(RemoteMessage message) {
//     final notification = message.notification;
//     final android = message.notification?.android;
//
//     if (notification != null && android != null && Platform.isAndroid) {
//       final details = NotificationDetails(
//         android: AndroidNotificationDetails(
//           'easy_fcm_channel',
//           'Easy FCM',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       );
//
//       _localNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         details,
//       );
//     }
//   }
//
//   Future<String?> getToken() => _messaging.getToken();
// }


// library easy_firebase_push_notification.dart;
//
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
//
// final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

class EasyFirebasePush {
  static final EasyFirebasePush _instance = EasyFirebasePush._internal();

  factory EasyFirebasePush() {
    return _instance;
  }

  EasyFirebasePush._internal();

  FirebaseMessaging? _messaging;

  Future<void> initialize({
    required Function(RemoteMessage) onBackground,
    Function(RemoteMessage)? onMessage,
    Function(RemoteMessage)? onMessageOpenedApp,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // Initialize messaging after Firebase.initializeApp()
    _messaging = FirebaseMessaging.instance;

    // Background handler
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      await Firebase.initializeApp();
      onBackground(message);
    });

    await _initLocalNotifications();

    await _messaging!.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (onMessage != null) onMessage(message);
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (onMessageOpenedApp != null) onMessageOpenedApp(message);
    });
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await _localNotificationsPlugin.initialize(settings);
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null && Platform.isAndroid) {
      final details = NotificationDetails(
        android: AndroidNotificationDetails(
          'easy_fcm_channel',
          'Easy FCM',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        details,
      );
    }
  }

  Future<String?> getToken() async {
    if (_messaging == null) {
      return null;
    }
    return await _messaging!.getToken();
  }
}

