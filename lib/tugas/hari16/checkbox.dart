import 'package:flutter/material.dart';

class Checkboxtugas7 extends StatefulWidget {
  const Checkboxtugas7({super.key});

  @override
  State<Checkboxtugas7> createState() => _Checkboxtugas7State();
}

class _Checkboxtugas7State extends State<Checkboxtugas7> {
  bool isChecked = false;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkbox & Switch"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Text(
              "Syarat & Ketentuan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "Saya menyetujui semua persyaratan yang berlaku",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pesan status
            Text(
              isChecked
                  ? "Lanjutkan pendaftaran diperbolehkan"
                  : "Anda belum bisa melanjutkan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isChecked
                    ? Colors.green
                    : (isSwitched ? Colors.red[300] : Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
