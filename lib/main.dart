import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Screens/welcome_page.dart';
import 'Screens/login_page.dart';
import 'Screens/verify_page.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  void changeTheme(bool isDark) {
    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رفقة',
      theme: ThemeData(
        fontFamily: 'Arial',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Arial',
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => MainHomePage(
              onThemeChanged: changeTheme,
            ),
        '/add-trip': (context) => const AddTripPage(),
        '/login': (context) => const LoginPage(),
        '/verify': (context) => const VerifyPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/main-home': (context) => MainHomePage(
              onThemeChanged: changeTheme,
            ),
      },
    );
  }
}
