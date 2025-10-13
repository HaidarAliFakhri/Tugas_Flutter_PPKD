import 'package:flutter/material.dart';
//import 'package:haidar_ppkd/tugas/tugas1.dart';
import 'package:haidar_ppkd/tugas/tugas2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Lengkap',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ProfilLengkapPage(),
    );
  }
}
