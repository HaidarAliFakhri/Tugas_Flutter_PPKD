import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/proyekakhir/loginpagetrip.dart';
import 'package:haidar_ppkd/tugas/proyekakhir/pages/homepagetrip.dart';
import 'package:haidar_ppkd/tugas/proyekakhir/screens/cuacatrip.dart';
import 'package:haidar_ppkd/tugas/proyekakhir/screens/profiltrip.dart';

class DrawerHaiTrip extends StatefulWidget {
  const DrawerHaiTrip({super.key});

  @override
  State<DrawerHaiTrip> createState() => _DrawerHaiTripState();
}

class _DrawerHaiTripState extends State<DrawerHaiTrip> {
  int _selectedIndex = 0;

  // daftar halaman yang muncul saat menu drawer dipilih
  static final List<Widget> _widgetOptions = [
    const Homepagetrip(),
    const CuacaTrip(),
    const ProfilTrip(),
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
      appBar: AppBar(
        title: const Text("HaiTrip"),
        backgroundColor: const Color(0xFF0077B6),
        centerTitle: true,
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Haidar"),
              accountEmail: Text("haidar@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/logoHaiTime/haidar.jpg",
                ),
              ),
              decoration: BoxDecoration(color: Color(0xFF0077B6)),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () => onTapDrawer(0),
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text("Cuaca"),
              onTap: () => onTapDrawer(1),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil"),
              onTap: () => onTapDrawer(2),
            ),

            const Divider(),
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
                    content: const Text("Yakin ingin keluar dari HaiTrip?"),
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
                      builder: (context) => const HaiTrip(), // kembali ke login
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),

      // body mengikuti halaman yang dipilih di drawer
      body: _widgetOptions[_selectedIndex],
    );
  }
}
