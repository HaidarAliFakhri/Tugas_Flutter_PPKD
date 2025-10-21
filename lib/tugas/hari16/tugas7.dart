import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari16/checkbox.dart';
import 'package:haidar_ppkd/tugas/hari16/datepicker.dart';
import 'package:haidar_ppkd/tugas/hari16/dropdawn.dart';
import 'package:haidar_ppkd/tugas/hari16/switch.dart';
import 'package:haidar_ppkd/tugas/hari16/timepicker.dart';
import 'package:haidar_ppkd/tugas/homepagebottom_nav.dart';

class Tugas7Page extends StatefulWidget {
  const Tugas7Page({super.key});

  @override
  State<Tugas7Page> createState() => _Tugas7PageState();
}

class _Tugas7PageState extends State<Tugas7Page> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Checkboxtugas7(),
    Modegelap(),
    DropdownKategoriProduk(),
    Datepickertugas7(),
    Timepickertugas7(),
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

            
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text("chekbox & switch"),
              onTap: () {
                onTapDrawer(0);
              },
            ),
            const Divider(),

            
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Switch"),
              onTap: () {
                onTapDrawer(1);
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.vaccines),
              title: const Text("Dropdawn"),
              onTap: () {
                onTapDrawer(2);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text("Datepicker"),
              onTap: () {
                onTapDrawer(3);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Timepicker"),
              onTap: () {
                onTapDrawer(4);
              },
            ),

            
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                MaterialPageRoute(builder: (context) => const HomePage());
                
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
