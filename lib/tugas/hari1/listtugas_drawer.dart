import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari16/checkbox.dart';
import 'package:haidar_ppkd/tugas/hari16/switch.dart';
import 'package:haidar_ppkd/tugas/homepagebottom_nav.dart';
import 'package:haidar_ppkd/tugas/hari1/tugas5.dart';

class Listtugas extends StatefulWidget {
  const Listtugas({super.key});

  @override
  State<Listtugas> createState() => _Listtugas();
}

class _Listtugas extends State<Listtugas> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Checkboxtugas7(),
    Modegelap(),

    Tugas5Page(),
  ];

  void onTapDrawer(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // tutup drawer setelah klik menu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer")),

      // --- Drawer mulai di sini ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Bagian header drawer
            const UserAccountsDrawerHeader(
              accountName: Text("haidar"),
              accountEmail: Text("haidar@ppkd.id"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/haidar.jpg"),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 44, 95, 158),
              ),
            ),

            // Menu Home
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Tugas 1"),
              onTap: () {
                onTapDrawer(0);
              },
            ),
            const Divider(),

            // Menu Payment
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text("Tugas 2"),
              onTap: () {
                onTapDrawer(1);
              },
            ),
            const Divider(),

            // Menu Settings tambahan
            ListTile(
              leading: const Icon(Icons.vaccines),
              title: const Text("Tugas 5"),
              onTap: () {
                onTapDrawer(2);
              },
            ),
            const Divider(),

            // Menu Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                MaterialPageRoute(builder: (context) => const HomePage());
                // tambahkan aksi logout di sini nanti
              },
            ),
          ],
        ),
      ),

      // --- Drawer selesai di sini ---
      body: _widgetOptions[_selectedIndex],
    );
  }
}
