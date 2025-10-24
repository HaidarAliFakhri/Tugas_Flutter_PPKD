import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/tugas11/splash_screen/splash_screen_haitime.dart';

void main() {
  runApp(const HaiTimeApp());
}

class HaiTimeApp extends StatelessWidget {
  const HaiTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HaiTime',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
      ),
      home: const SplashScreenDayHaiTime(),
    );
  }
}
