import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:haidar_ppkd/tugas/hari1/listtugas_drawer.dart';
import 'package:haidar_ppkd/tugas/hari16/drawer_tugas7.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page", style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 44, 95, 158),
      ),
      body: _selectedIndex == 0
          ? const Center(child: Text("Halaman Beranda"))
          : _selectedIndex == 1
          ? const Center(child: Text(""))
          : const Center(child: Text("Profil")),
      bottomNavigationBar: CircleBottomNavigation(
        initialSelection: _selectedIndex,
        barBackgroundColor: Colors.white,
        circleColor: const Color.fromARGB(255, 44, 95, 158),
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: [
          TabData(icon: Icons.home, iconSize: 28, title: 'Home'),
          TabData(icon: Icons.task, iconSize: 28, title: 'Tugas'),
          TabData(icon: Icons.person, iconSize: 28, title: 'Profil'),
        ],
        onTabChangedListener: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Tugas7Page()),
            );
          }
        },
      ),
    );
  }
}
