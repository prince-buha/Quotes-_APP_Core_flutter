import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/Routes/Routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, Routes.qoutepage);
    });
    return Scaffold(
      backgroundColor: const Color(0xffFE9992),
      body: Column(
        children: [
          const SizedBox(height: 200),
          Center(
            child: Image.asset("lib/assets/splesh.gif"),
          ),
          const SizedBox(height: 50),
          const Text(
            " Quote_App ",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 3,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            " Welcome ",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 5,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
