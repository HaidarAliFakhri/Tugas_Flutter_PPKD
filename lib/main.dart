import 'package:flutter/material.dart';

import 'package:haidar_ppkd/tugas/hari18/form_pendaftaran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPendaftaran(),
    );
  }
}
