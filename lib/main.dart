import 'package:flutter/material.dart';
// import 'package:testproject/screens/login_screen.dart';
// import 'package:testproject/screens/signup_screen.dart';
import 'package:testproject/screens/home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:testproject/screens/Bottom_Navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testproject/screens/All_Notifications.dart';

void main() {
  runApp(const MyApp());

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      '',
      [
        NotificationChannel(
          channelKey: 'scheduled',
          channelName: 'Scheduled Notifications',
          channelDescription: 'Channel for scheduled notifications',
          defaultColor: const Color.fromARGB(255, 0, 0, 0),
          ledColor: const Color.fromARGB(255, 0, 0, 0),
          playSound: true,
          enableVibration: true,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    print('User: $user');
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: BottomNavigation(),
        ),
      ),
      initialRoute: '/bottom',
      routes: {
        // SecondPage.routeName: (context) => const SecondPage(),
        // LoginScreen.routeName: (context) => const LoginScreen(),
        // Signup.routeName: (context) => const Signup(),
        HomePage.routeName: (context) => const HomePage(),
        BottomNavigation.routeName: (context) => const BottomNavigation(),
        AllNotifications.routeName: (context) => const AllNotifications(),
      },
    );
  }
}
