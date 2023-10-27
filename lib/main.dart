import 'package:flutter/material.dart';
import 'package:test_udemy_amazon_clone2/screens/splash_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple, brightness: Brightness.dark),
      home: MySplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
