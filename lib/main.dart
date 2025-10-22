import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari17/tugas9.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tugas9DrawerPage(),
    );
  }
}
