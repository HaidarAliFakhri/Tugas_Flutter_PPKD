import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreentugas15 extends StatefulWidget {
  const SplashScreentugas15({super.key});

  @override
  State<SplashScreentugas15> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreentugas15> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2)); // animasi splash

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if (token != null && token.isNotEmpty) {
      // Token ada → langsung masuk Profile
      Navigator.pushReplacementNamed(context, "/profile");
    } else {
      // Token kosong → masuk Login
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flutter_dash, color: Colors.white, size: 90),
            SizedBox(height: 20),
            Text(
              "instakw App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
