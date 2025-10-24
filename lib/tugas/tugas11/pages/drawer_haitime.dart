import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/list_catatan.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/list_cuaca.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/list_jadwal_sholat.dart';
import 'package:haidar_ppkd/tugas/tugas11/pages/login_page_haitime.dart';

class DrawerHaitime extends StatefulWidget {
  const DrawerHaitime({super.key});

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
      appBar: AppBar(title: const Text("Drawer")),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Bagian header drawer
            const UserAccountsDrawerHeader(
              accountName: Text("haidar"),
              accountEmail: Text("haidar@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/logoHaiTime/haidar.jpg",
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 44, 95, 158),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.cloudy_snowing),
              title: const Text("Cuaca"),
              onTap: () {
                onTapDrawer(0);
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.punch_clock),
              title: const Text("Jadwal Sholat"),
              onTap: () {
                onTapDrawer(1);
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.note),
              title: const Text("Pengingat Catatan"),
              onTap: () {
                onTapDrawer(2);
              },
            ),

            Divider(),
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
                    content: const Text("Yakin ingin keluar dari HaiTime?"),
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
                  // Pindah ke halaman login dan hapus semua route sebelumnya
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

      body: _widgetOptions[_selectedIndex],
    );
  }
}
