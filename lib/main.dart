import 'dart:convert';

import 'package:distributorsapp/backend/controllers/notification_service.dart';
import 'package:distributorsapp/backend/firebase/firebase_api.dart';
import 'package:distributorsapp/components/notif_screen.dart';
import 'package:distributorsapp/components/notification_message.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('received notification: $message');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBoktIUc-cipuLyDdcRhVsU070ZtrHVA04',
    appId: '1:33942190250:android:1d236e479564884e39b8d3',
    messagingSenderId: '33942190250',
    projectId: 'distributors-8f4e1',
  ));
  // await FirebaseApi().initNotification();
  await PushNotifications.init();
  await PushNotifications.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('background notification tapped');
      // navigatorKey.currentState!.pushNamed('/message', arguments: message);
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print('Got Message in foregound');
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print('launched from terminated state');
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    });
  }

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  // This widget is the root of your application.
  //updatedgit
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Filipay Distributor's App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      navigatorObservers: <NavigatorObserver>[observer],
      home: const LoginPage(),
      routes: {"/message": (context) => NotificationMessage()},
    );
  }
}
