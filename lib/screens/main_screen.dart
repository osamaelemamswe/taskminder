import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskminder/screens/home_screen.dart';
import 'package:taskminder/screens/onboarding_screen.dart';
import 'package:taskminder/screens/splash_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
