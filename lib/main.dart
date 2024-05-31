import 'package:distributorsapp/backend/firebase/firebase_api.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  await FirebaseApi().initNotification();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorObservers: <NavigatorObserver>[observer],
      home: const LoginPage(),
    );
  }
}
