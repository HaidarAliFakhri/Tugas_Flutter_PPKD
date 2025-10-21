import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haidar_ppkd/tugas/hari16/tugas7.dart';

class Tugas8Page extends StatefulWidget {
  const Tugas8Page({super.key});

  @override
  State<Tugas8Page> createState() => _Tugas8PageState();
}

class _Tugas8PageState extends State<Tugas8Page> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Daftar halaman yang akan ditampilkan
    final List<Widget> pages = [
      const Tugas7Page(),
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tentang Aplikasi",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Aplikasi ini dibuat untuk menampilkan "
              "widget seperti "
              "Dropdown, Checkbox, dan Bottom Navigation.",
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "Pembuat: Haidar\nVersi: 1.0.0",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page", style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 44, 95, 158),
      ),
      body: pages[_selectedIndex], // Tampilkan halaman sesuai tab yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Tentang Aplikasi',
          ),
        ],
      ),
    );
  }
}
