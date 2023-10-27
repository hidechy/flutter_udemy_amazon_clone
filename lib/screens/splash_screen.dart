import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_udemy_amazon_clone2/screens/home_screen.dart';

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
    Timer(Duration(seconds: 4), () async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset('assets/images/welcome.png'),
              ),
              SizedBox(height: 20),
              Text(
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
