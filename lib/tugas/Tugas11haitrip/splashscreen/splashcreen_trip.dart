import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/loginpagetrip.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/screens/drawertrip.dart';
import 'package:haidar_ppkd/tugas/preferences/preference_handler.dart';

class SplashScreenDayHaiTrip extends StatefulWidget {
  const SplashScreenDayHaiTrip({super.key});

  @override
  State<SplashScreenDayHaiTrip> createState() => _SplashScreenDayHaiTripState();
}

class _SplashScreenDayHaiTripState extends State<SplashScreenDayHaiTrip> {
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
          MaterialPageRoute(builder: (context) => DrawerHaiTrip()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HaiTrip()),
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
