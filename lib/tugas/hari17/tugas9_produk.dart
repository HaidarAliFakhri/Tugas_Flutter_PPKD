import 'package:flutter/material.dart';

import 'models/peralatan_model.dart';

class ListProduk extends StatelessWidget {
  final String kategori;
  const ListProduk({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<PeralatanModel>> dataProduk = {
      "Peralatan Dapur": [
        PeralatanModel(
          name: "Pisau",
          price: 25000,
          condition: "Baru",
          image: "assets/images/pisau.jpg",
        ),
        PeralatanModel(
          name: "Talenan",
          price: 18000,
          condition: "Baru",
          image: "assets/images/talenan.jpg",
        ),
        PeralatanModel(
          name: "Panci",
          price: 28000,
          condition: "Baru",
          image: "assets/images/panci.jpg",
        ),
        PeralatanModel(
          name: "Wajan",
          price: 35000,
          condition: "Baru",
          image: "assets/images/wajan.jpg",
        ),
        PeralatanModel(
          name: "Sendok",
          price: 8000,
          condition: "Baru",
          image: "assets/images/sendok.jpg",
        ),
        PeralatanModel(
          name: "Garpu",
          price: 8000,
          condition: "Baru",
          image: "assets/images/garpu.jpg",
        ),
        PeralatanModel(
          name: "Blender",
          price: 250000,
          condition: "Baru",
          image: "assets/images/blender.jpg",
        ),
        PeralatanModel(
          name: "Loyang",
          price: 15000,
          condition: "Baru",
          image: "assets/images/loyang.jpg",
        ),
        PeralatanModel(
          name: "Saringan",
          price: 10000,
          condition: "Baru",
          image: "assets/images/saringan.jpg",
        ),
        PeralatanModel(
          name: "Spatula",
          price: 12000,
          condition: "Baru",
          image: "assets/images/spatula.jpg",
        ),
      ],
    };

    final produkList = dataProduk[kategori] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Produk: $kategori")),
      body: ListView.builder(
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          final item = produkList[index];
          return Card(
            margin: const EdgeInsets.all(8),
            color: item.backgroundColor ?? Colors.white,
            child: ListTile(
              leading: Image.asset(
                item.image,
                width: 60,
                height: 290,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text("Rp ${item.price} • ${item.condition}"),
            ),
          );
        },
      ),
    );
  }
}
