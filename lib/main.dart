import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'Screens/welcome_page.dart';
import 'Screens/login_page.dart';
import 'Screens/verify_page.dart';
import 'Screens/home_page.dart';
import 'Screens/add_trip_page.dart';
import 'Screens/notifications_page.dart';
import 'Screens/main_home_page.dart';
import 'Screens/rafqa_ai_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رفقة',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => HomePage(
              tripName: 'عمرة رمضان',
            ),
        '/add-trip': (context) => const AddTripPage(),
        '/login': (context) => const LoginPage(),
        '/verify': (context) => const VerifyPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/main-home': (context) => const MainHomePage(),
      },
    );
  }
}
