import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari18/tugas10.dart';
import 'package:haidar_ppkd/tugas/bottom_nav.dart';
import 'package:haidar_ppkd/tugas/preferences/preference_handler.dart';




class LoginPageCanva extends StatefulWidget {
  const LoginPageCanva({super.key});
static const id = "/LoginPageCanva";
  @override
  State<LoginPageCanva> createState() => _LoginPageCanvaState();
}

class _LoginPageCanvaState extends State<LoginPageCanva> {
  final _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF8),
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Logo
              Center(
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 80,
                  width: 80,
                ),
              ),

              const SizedBox(height: 40),

              // Judul dan subjudul
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Yuk masuk untuk bertransaksi",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 30),

              // Input Email
              Form(
  key: _formKey,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Email
      const Text(
        "Email",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 6),
      TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: "Masukkan email anda",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email tidak boleh kosong";
          } else if (!value.contains('@')) {
            return "Email tidak valid";
          } else if (!RegExp(
            r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
          ).hasMatch(value)) {
            return "Format Email tidak valid";
          }
          return null;
        },
      ),

      const SizedBox(height: 20),

      // Password
      const Text(
        "Password",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 6),
      TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Masukkan password anda",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password tidak boleh kosong";
          } else if (value.length < 6) {
            return "Password minimal 6 karakter";
          }
          return null;
        },
      ),

      const SizedBox(height: 16),

              // Lupa Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Lupa password",
                    style: TextStyle(color: Color.fromARGB(150, 135, 32, 153)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(166, 145, 26, 214),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                   onPressed: () async {
      if (_formKey.currentState!.validate()) {
        // Simpan status login
        await PreferenceHandler.saveLogin(true);

        // Tampilkan snackbar sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login berhasil!')),
        );

        // Arahkan ke HomePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        // Jika form belum valid
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Validation Error"),
              content: const Text("Silakan isi semua field dengan benar."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    },
    child: const Text("Login", style: TextStyle(fontSize: 18)),
  ),
),

              const SizedBox(height: 20),

              // Sudah punya akun
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FormPendaftaran(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Color.fromARGB(150, 135, 32, 153),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      ),
      ),
      ),
    );
  }
}
