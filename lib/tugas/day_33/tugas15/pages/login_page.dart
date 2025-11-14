import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';

class LoginPagetugas15 extends StatefulWidget {
  const LoginPagetugas15({super.key});

  @override
  State<LoginPagetugas15> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagetugas15> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;

  void doLogin() async {
    setState(() => loading = true);

    LoginModel res = await ApiService.login(emailC.text, passC.text);

    setState(() => loading = false);

    if (res.token != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", res.token!);

      Navigator.pushReplacementNamed(context, "/profile");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res.message ?? "Login gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.lock, size: 80, color: Colors.blue),
                SizedBox(height: 20),
                Text(
                  "Hallo !",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: emailC,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(height: 15),

                TextField(
                  controller: passC,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),

                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: loading ? null : doLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("LOGIN"),
                ),

                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/register"),
                  child: Text("Belum punya akun? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
