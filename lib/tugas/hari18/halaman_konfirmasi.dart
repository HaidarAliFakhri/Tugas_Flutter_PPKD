import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haidar_ppkd/tugas/bottom_nav.dart';

class HalamanKonfirmasiday18 extends StatelessWidget {
  final String nama;
  final String kota;

  const HalamanKonfirmasiday18({
    super.key,
    required this.nama,
    required this.kota,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              Center(
                child: Image.asset(
                  'assets/images/jempol.jpg',
                  height: 200,
                  width: 200,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                "Terima kasih, $nama dari $kota telah mendaftar.",
                style: GoogleFonts.poppins(fontSize: 20),

                textAlign: TextAlign.center,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Lanjut ke homepage ---> "),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },

                      child: const Text(
                        " KLIK Lanjutkan",
                        style: TextStyle(
                          color: Color.fromARGB(150, 135, 32, 153),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
