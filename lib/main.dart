import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari17/tugas9_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 9 Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
      home: const Tugas9PageList(),
    );
  }
}
