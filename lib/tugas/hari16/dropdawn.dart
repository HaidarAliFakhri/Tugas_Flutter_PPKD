import 'package:flutter/material.dart';

class DropdownKategoriProduk extends StatefulWidget {
  const DropdownKategoriProduk({super.key});

  @override
  State<DropdownKategoriProduk> createState() => _DropdownKategoriProdukState();
}

class _DropdownKategoriProdukState extends State<DropdownKategoriProduk> {
  String? selectedKategori;
  final List<String> kategoriList = [
    "Elektronik",
    "Pakaian",
    "Makanan",
    "Lainnya",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Kategori Produk"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Kategori Produk:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // DropdownButton
            DropdownButton<String>(
              hint: const Text("Pilih kategori"),
              value: selectedKategori,
              items: kategoriList.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedKategori = value;
                });
              },
            ),
            const SizedBox(height: 30),

            // Teks hasil pilihan
            Text(
              selectedKategori == null
                  ? "Belum ada kategori yang dipilih"
                  : "Anda memilih kategori: $selectedKategori",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
