import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari16/tugas8.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
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
      home: const Tugas8Page(),
      //ubah sni
    );
  }
}
