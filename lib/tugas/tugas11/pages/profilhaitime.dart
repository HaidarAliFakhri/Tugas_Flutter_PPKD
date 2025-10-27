import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/tugas11/db/db_helper.dart';
import 'package:haidar_ppkd/tugas/tugas11/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilTime extends StatefulWidget {
  const ProfilTime({super.key});

  @override
  State<ProfilTime> createState() => _ProfilTimeState();
}

class _ProfilTimeState extends State<ProfilTime> {
  String? name;
  String? email;
  String? password;
  bool _showPassword = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString(
      'email',
    ); // ambil dari PreferenceHandler

    if (storedEmail != null) {
      // ambil semua user dari DB, lalu cari yang email-nya cocok
      final users = await DbHelper.getAllUser();
      final user = users.firstWhere(
        (u) => u.email == storedEmail,
        orElse: () => UserModel(username: '-', email: '-', password: '-'),
      );

      setState(() {
        name = user.username;
        email = user.email;
        password = user.password;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF8),
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: const Color(0xFF0077B6),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: const AssetImage(
                      "assets/images/logoHaiTime/haidar.jpg",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name ?? '-',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF03045E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email ?? '-',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  _passwordTile(),
                ],
              ),
            ),
    );
  }

  Widget _passwordTile() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.lock, color: Colors.grey),
              SizedBox(width: 12),
              Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                _showPassword
                    ? (password ?? '-')
                    : '*' * (password?.length ?? 0),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
