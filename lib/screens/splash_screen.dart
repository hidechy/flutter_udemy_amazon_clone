import 'dart:async';

import 'package:flutter/material.dart';

import '../styles/styles.dart';

import 'home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  ///
  @override
  void initState() {
    super.initState();

    splashScreenTimer();
  }

  ///
  void splashScreenTimer() {
    Timer(const Duration(seconds: 4), () async {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DecoratedBox(
        decoration: pinkBackGround,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset('assets/images/welcome.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'iShop Users App.',
                style: TextStyle(fontSize: 30, letterSpacing: 3, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
