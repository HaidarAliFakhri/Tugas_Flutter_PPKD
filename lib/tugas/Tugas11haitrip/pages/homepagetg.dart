import 'package:flutter/material.dart';

class Homepagetourguide extends StatelessWidget {
  const Homepagetourguide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF8),
      appBar: AppBar(
        title: const Text("HaiTrip – Pemandu Wisata"),
        centerTitle: true,
        backgroundColor: const Color(0xFF023E8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat datang, Pemandu!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF03045E),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Kelola wisata, jadwal tur, dan lihat ulasan wisatawan.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Statistik singkat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard("Wisata Aktif", "8"),
                _statCard("Tur Bulan Ini", "12"),
                _statCard("Rating", "4.8⭐"),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Destinasi Kamu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  _destinationCard("Candi Prambanan", "Rp150.000", "Aktif"),
                  _destinationCard("Bukit Panguk Kediwung", "Rp75.000", "Aktif"),
                  _destinationCard("Hutan Pinus Mangunan", "Rp100.000", "Nonaktif"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Tombol tambah wisata
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0077B6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Aksi tambah destinasi nanti di sini
                },
                icon: const Icon(Icons.add_location_alt_rounded),
                label: const Text("Tambah Destinasi Baru"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0077B6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _destinationCard(String name, String price, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Color(0xFF0077B6)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("Harga: $price"),
        trailing: Chip(
          label: Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor:
              status == "Aktif" ? Colors.green.shade600 : Colors.red.shade400,
        ),
      ),
    );
  }
}
