import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacementNamed(context, Routes.homePage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff454452),
      body: Center(
        child: Image.network(
            "https://icon-library.com/images/weather-icon-gif/weather-icon-gif-14.jpg"),
      ),
    );
  }
}
