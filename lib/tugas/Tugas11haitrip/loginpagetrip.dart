import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/admin/dashboard_admin.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/pages/homepagetg.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/screens/drawertrip.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/screens/form_pendaftaran.dart';
import 'package:haidar_ppkd/tugas/Tugas11haitrip/screens/form_pendaftaran_tour_guide.dart';
import 'package:haidar_ppkd/tugas/preferences/preference_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HaiTrip extends StatefulWidget {
  const HaiTrip({super.key});
  static const id = "/HaiTrip";

  @override
  State<HaiTrip> createState() => _HaiTripState();
}

class _HaiTripState extends State<HaiTrip> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisibility = false;
  String selectedRole = "Wisatawan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF8),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Gambar background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logoHaiTime/Bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay hitam transparan
          Container(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.25),
          ),

          // Konten utama (form login)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/images/haitrip.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 3),

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
                      "Jelajahi dunia tanpa khawatir cuaca dan waktu.",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Pilihan Role (Kiri-Kanan)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            "Masuk sebagai",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: SegmentedButton<String>(
                                segments: const [
                                  ButtonSegment(
                                    value: "Wisatawan",
                                    label: Text("Wisatawan"),
                                  ),
                                  ButtonSegment(
                                    value: "Tour Guide",
                                    label: Text("Tour Guide"),
                                  ),
                                ],
                                selected: {selectedRole},
                                onSelectionChanged: (newSelection) {
                                  setState(() {
                                    selectedRole = newSelection.first;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith(
                                        (states) =>
                                            states.contains(
                                              WidgetState.selected,
                                            )
                                            ? const Color.fromARGB(
                                                255,
                                                0,
                                                27,
                                                41,
                                              )
                                            : Colors.white,
                                      ),
                                  foregroundColor:
                                      WidgetStateProperty.resolveWith(
                                        (states) =>
                                            states.contains(
                                              WidgetState.selected,
                                            )
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                  side: WidgetStateProperty.all(
                                    BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Form Login
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email dan Password tanpa jarak
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  hintText: "Masukkan email anda",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email tidak boleh kosong";
                                  } else if (!RegExp(
                                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                                  ).hasMatch(value)) {
                                    return "Format email tidak valid";
                                  }
                                  return null;
                                },
                              ),
                              const Divider(height: 1, color: Colors.grey),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Masukkan password anda",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  border: InputBorder.none,
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
                            ],
                          ),
                        ),

                        // Lupa Password
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Lupa password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),

                        // Tombol Login
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                0,
                                50,
                                77,
                              ),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                final registeredEmail = prefs.getString(
                                  'registered_email',
                                );
                                final registeredPassword = prefs.getString(
                                  'registered_password',
                                );

                                final emailInput = emailController.text.trim();
                                final passwordInput = passwordController.text
                                    .trim();

                                // 🔹 1. Cek dulu: apakah login sebagai ADMIN
                                if (emailInput == 'admin@haitrip.com' &&
                                    passwordInput == 'admin123') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Login sebagai Admin berhasil!',
                                      ),
                                    ),
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const DashboardAdminPage(),
                                    ),
                                  );
                                  return; // stop di sini kalau admin
                                }

                                // 🔹 2. Cek login sesuai role yang dipilih
                                if (selectedRole == "Wisatawan") {
                                  if (emailInput == registeredEmail &&
                                      passwordInput == registeredPassword) {
                                    await PreferenceHandler.saveLogin(true);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Login berhasil sebagai Wisatawan!',
                                        ),
                                      ),
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const DrawerHaiTrip(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Email atau password salah!',
                                        ),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                } else if (selectedRole == "Tour Guide") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login sebagai Tour Guide'),
                                    ),
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Homepagetourguide(),
                                    ),
                                  );
                                }
                              } else {
                                // Jika form belum valid
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Validation Error"),
                                      content: const Text(
                                        "Silakan isi semua field dengan benar.",
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text("OK"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                indent: 20,
                                endIndent: 10,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "Or continue with",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                indent: 10,
                                endIndent: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Tombol sosial media
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton("assets/images/iconss/google.jpg"),
                            const SizedBox(width: 20),
                            _socialButton("assets/images/iconss/apple.jpg"),
                            const SizedBox(width: 20),
                            _socialButton("assets/images/iconss/twitter.jpg"),
                          ],
                        ),

                        // Sudah punya akun
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum punya akun? "),
                            TextButton(
                              onPressed: () {
                                if (selectedRole == "Wisatawan") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FormPendaftaranWisatawan(),
                                    ),
                                  );
                                } else if (selectedRole == "Tour Guide") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FormPendaftaranTourGuide(),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Color.fromARGB(149, 0, 8, 80),
                                  fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}

Widget _socialButton(String assetPath) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Image.asset(assetPath, width: 30, height: 30),
  );
}
