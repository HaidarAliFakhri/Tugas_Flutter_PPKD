import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilTrip extends StatefulWidget {
  const ProfilTrip({super.key});

  @override
  State<ProfilTrip> createState() => _ProfilTripState();
}

class _ProfilTripState extends State<ProfilTrip> {
  String? name;
  String? email;
  String? phone;
  String? city;
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

    setState(() {
      name = prefs.getString('registered_name') ?? 'Belum diisi';
      email = prefs.getString('registered_email') ?? '-';
      phone = prefs.getString('registered_phone') ?? '-';
      city = prefs.getString('registered_city') ?? '-';
      password = prefs.getString('registered_password') ?? '-';
      _isLoading = false;
    });
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
                  // Foto profil
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        const AssetImage("assets/images/logoHaiTime/haidar.jpg"),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF03045E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email ?? '',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),

                  const SizedBox(height: 30),

                  // Data detail
                  _infoTile(Icons.phone, "Nomor HP", phone ?? "-"),
                  _infoTile(Icons.location_on, "Asal Kota", city ?? "-"),

                  const SizedBox(height: 12),

                  // Password field
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
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
                                  ? (password ?? "-")
                                  : "*" * (password?.length ?? 0),
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() => _showPassword = !_showPassword);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
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
        children: [
          Icon(icon, color: const Color(0xFF0077B6)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: 13)),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
