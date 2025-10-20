import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hai Time", style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 44, 95, 158),
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm),
            tooltip: "Pengingat",
            onPressed: () {
              print("Pengingat ditekan");
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: "Profil",
            onPressed: () {
              print("Profil ditekan");
            },
          ),
        ],
      ),
    );
  }
}
