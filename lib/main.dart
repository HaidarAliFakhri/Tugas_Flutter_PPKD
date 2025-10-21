import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:haidar_ppkd/tugas/hari16/tugas8.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 7 & 8',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Tugas8Page(), 
      locale: const Locale('id', 'ID'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
