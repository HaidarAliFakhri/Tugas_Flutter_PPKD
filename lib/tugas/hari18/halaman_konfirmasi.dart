import 'package:flutter/material.dart';

class HalamanKonfirmasi extends StatelessWidget {
  final String nama;
  final String kota;

  const HalamanKonfirmasi({
    super.key,
    required this.nama,
    required this.kota,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konfirmasi Pendaftaran")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Terima kasih, $nama dari $kota telah mendaftar.",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
