import 'package:flutter/material.dart';

import 'tugas/tugas4.dart'; // ubah sni

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Flutter',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Tugas4Page(), //ubah sni
    );
  }
}
