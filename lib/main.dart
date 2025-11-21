import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haidar_ppkd/firebase_options.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/pages/editprofile_page.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/pages/login_page.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/pages/profile_page.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/pages/register_page.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/pages/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hai Time App",
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      // Splash pertama kali jalan
      initialRoute: "/splash",

      // Daftar route aplikasi
      routes: {
        "/splash": (context) => SplashScreentugas15(),
        "/login": (context) => LoginPagetugas15(),
        "/register": (context) => RegisterPagetugas15(),
        "/profile": (context) => ProfileInstagramPage(),
        "/edit": (context) => EditProfileInstagramPage(),
      },
    );
  }
}
