import 'package:flutter/material.dart';

import 'Screens/welcome_page.dart';
import 'Screens/home_page.dart';
import 'Screens/add_trip_page.dart';

void main() {
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
      },
    );
  }
}
