


import 'package:flutter/material.dart';
import 'package:easy_firebase_push_notification/easy_firebase_push_notification2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyFirebasePush().initialize(
    onBackground: _onBackground,
    onMessage: _onMessage,
    onMessageOpenedApp: _onMessageOpenedApp,
  );

  runApp(const MyApp());
}

void _onBackground(RemoteMessage message) {
  print("🔵 Background Message: ${message.notification?.title}");
}

void _onMessage(RemoteMessage message) {
  print("🟢 Foreground Message: ${message.notification?.title}");
}

void _onMessageOpenedApp(RemoteMessage message) {
  print("🟠 App Opened from Notification: ${message.notification?.title}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy FCM Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _token = 'Fetching...';

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  void _fetchToken() async {
    final token = await EasyFirebasePush().getToken();
    setState(() {
      _token = token;
    });
    print('📱 FCM Token: $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Push Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectableText('FCM Token:\n$_token'),
      ),
    );
  }
}
