import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:routine/login.dart';
import 'package:routine/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging()
    ..requestNotificationPermissions()
    ..subscribeToTopic('daily_reminder');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.providerData.length == 1) {
              return snapshot.data.isEmailVerified
                  ? MyDashboardPage()
                  : LoginScreen();
            } else {
              return LoginScreen();
            }
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
