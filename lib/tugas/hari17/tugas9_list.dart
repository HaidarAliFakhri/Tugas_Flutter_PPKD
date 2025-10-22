import 'package:flutter/material.dart';

import 'tugas9_produk.dart';

class Tugas9PageList extends StatefulWidget {
  const Tugas9PageList({super.key});

  @override
  State<Tugas9PageList> createState() => _Tugas9PageListState();
}

class _Tugas9PageListState extends State<Tugas9PageList> {
  final List<Map<String, dynamic>> kategori = [
    {"nama": "Buah-buahan", "icon": Icons.apple_rounded},
    {"nama": "Sayuran", "icon": Icons.eco},
    {"nama": "Elektronik", "icon": Icons.devices_other},
    {"nama": "Pakaian Pria", "icon": Icons.male},
    {"nama": "Pakaian Wanita", "icon": Icons.female},
    {"nama": "Alat Tulis Kantor", "icon": Icons.edit},
    {"nama": "Peralatan Dapur", "icon": Icons.kitchen},
    {"nama": "Minuman", "icon": Icons.local_drink},
    {"nama": "Makanan Ringan", "icon": Icons.fastfood},
    {"nama": "Kosmetik", "icon": Icons.brush},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Kategori")),
      body: ListView.builder(
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          final item = kategori[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(item["icon"], color: Colors.orange),
              title: Text(item["nama"]),
              trailing: const Icon(Icons.local_grocery_store, size: 25),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListProduk(kategori: item["nama"]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
