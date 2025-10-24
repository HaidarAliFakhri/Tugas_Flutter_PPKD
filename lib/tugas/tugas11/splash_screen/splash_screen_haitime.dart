import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/preferences/preference_handler.dart';
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
    isLoginFunction();
  }

  isLoginFunction() async {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      var isLogin = await PreferenceHandler.getLogin();
      print(isLogin);
      if (isLogin != null && isLogin == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DrawerHaitime()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPageHaitime()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/logoHaiTime/jempol.jpg')),
          Text(
            "Welcome!!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
