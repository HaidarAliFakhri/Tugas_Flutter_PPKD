import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/tugas11/models/user_model.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/list_catatan.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/list_cuaca.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/list_jadwal_sholat.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/login_page_haitime.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/profilhaitime.dart';

class DrawerHaitime extends StatefulWidget {
  final UserModel user;
  const DrawerHaitime({super.key, required this.user});

  @override
  State<DrawerHaitime> createState() => _DrawerHaitimeState();
}

class _DrawerHaitimeState extends State<DrawerHaitime> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    ListCuaca(),
    ListJadwalSholat(),
    ListCatatan(),
  ];

  void onTapDrawer(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HaiTime")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header drawer
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF42A5F5)),
              accountName: Text(
                widget.user.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user.email),
                  Text(
                    widget.user.password,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
            ),

            // Menu drawer
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text("Cuaca"),
              onTap: () => onTapDrawer(0),
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.punch_clock),
              title: const Text("Jadwal Sholat"),
              onTap: () => onTapDrawer(1),
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.note),
              title: const Text("Pengingat Catatan"),
              onTap: () => onTapDrawer(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil Saya"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilTime()),
                );
              },
            ),
            const Divider(),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Konfirmasi"),
                    content: const Text(
                      "Yakin ingin keluar dari aplikasi HaiTime?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPageHaitime(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),

      // Konten utama berdasarkan menu yang dipilih
      body: _widgetOptions[_selectedIndex],
    );
  }
}
