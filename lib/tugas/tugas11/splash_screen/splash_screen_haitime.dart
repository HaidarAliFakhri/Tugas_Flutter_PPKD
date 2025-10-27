import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/preferences/preference_handler.dart';
import 'package:haidar_ppkd/tugas/tugas11/db/db_helper.dart';
import 'package:haidar_ppkd/tugas/tugas11/models/user_model.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/drawer_haitime.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/login_page_haitime.dart';

class SplashScreenDayHaiTime extends StatefulWidget {
  const SplashScreenDayHaiTime({super.key});

  @override
  State<SplashScreenDayHaiTime> createState() => _SplashScreenDayHaiTimeState();
}

class _SplashScreenDayHaiTimeState extends State<SplashScreenDayHaiTime> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    // kasih jeda 3 detik biar splash keliatan
    await Future.delayed(const Duration(seconds: 3));

    // ambil status login
    final isLogin = await PreferenceHandler.getLogin();

    // kalau kamu juga nyimpan email user di preferences:
    final email = await PreferenceHandler.getEmail();

    if (isLogin == true && email != null) {
      // ambil data user dari database
      final List<UserModel> allUsers = await DbHelper.getAllUser();
      final user = allUsers.firstWhere(
        (u) => u.email == email,
        orElse: () => UserModel(username: '', email: '', password: ''),
      );

      if (mounted && user.email.isNotEmpty) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DrawerHaitime(user: user)),
          (route) => false,
        );
        return;
      }
    }

    // kalau belum login
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPageHaitime()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/logoHaiTime/jempol.jpg')),
          const SizedBox(height: 20),
          const Text(
            "Welcome!!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
