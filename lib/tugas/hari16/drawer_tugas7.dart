import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_18/login_page.dart';
import 'package:haidar_ppkd/tugas/hari16/checkbox.dart';
import 'package:haidar_ppkd/tugas/hari16/datepicker.dart';
import 'package:haidar_ppkd/tugas/hari16/dropdawn.dart';
import 'package:haidar_ppkd/tugas/hari16/switch.dart';
import 'package:haidar_ppkd/tugas/hari16/timepicker.dart';

import 'package:haidar_ppkd/tugas/preferences/preference_handler.dart';


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

      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Bagian header drawer
            const UserAccountsDrawerHeader(
              accountName: Text("haidar"),
              accountEmail: Text("haidar@gmail.com"),
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

            Divider(),
            ListTile(
              onTap: () {
                PreferenceHandler.removeLogin();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageCanva()),
                  (route) => false,
                );
              },
              leading: Icon(Icons.outbond),
              title: Text("LogOut"),),
          ],
        ),
      ),

      
      body: _widgetOptions[_selectedIndex],
    );
  }
}
