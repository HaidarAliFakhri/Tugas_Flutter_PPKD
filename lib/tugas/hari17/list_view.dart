import 'package:flutter/material.dart';

class TanpaMap extends StatelessWidget {
  const TanpaMap({super.key});

  final List<String> kategori = const [
    "Buah-buahan",
    "Sayuran",
    "Elektronik",
    "Pakaian Pria",
    "Pakaian Wanita",
    "Alat Tulis Kantor",
    "Peralatan Dapur",
    "Minuman",
    "Makanan Ringan",
    "Kosmetik",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategori.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(kategori[index]));
      },
    );
  }
}
