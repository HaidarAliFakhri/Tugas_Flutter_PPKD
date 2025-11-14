import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/model/register_model.dart';

import '../api/api_service.dart';

class RegisterPagetugas15 extends StatefulWidget {
  const RegisterPagetugas15({super.key});

  @override
  State<RegisterPagetugas15> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPagetugas15> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;

  void doRegister() async {
    setState(() => loading = true);

    RegisterModel res = await ApiService.register(
      nameC.text,
      emailC.text,
      passC.text,
    );

    setState(() => loading = false);

    if (res.token != null) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res.message ?? "Register gagal")));
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
                Icon(Icons.person_add, size: 80, color: Colors.blue),
                SizedBox(height: 20),

                Text(
                  "Create Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                TextField(
                  controller: nameC,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                SizedBox(height: 15),

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
                  onPressed: loading ? null : doRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("REGISTER"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
