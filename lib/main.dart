import 'package:flutter/material.dart';
//import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/screens/homepage.dart';
import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/screens/splash_screen.dart';
import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store App',
      theme: AppTheme.lightTheme,

      home: const SplashScreenFakeStore(),
    );
  }
}
