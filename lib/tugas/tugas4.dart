import 'package:flutter/material.dart';

class Tugas4Page extends StatelessWidget {
  const Tugas4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir & Daftar Produk"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- FORMULIR ---
          const Text(
            "Formulir Pengguna",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 12),

          // --- Nama ---
          const TextField(
            decoration: InputDecoration(
              labelText: "Nama",
              prefixIcon: Icon(Icons.person, color: Colors.teal),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          // --- Email ---
          const TextField(
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email, color: Colors.teal),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          // --- No HP ---
          const TextField(
            decoration: InputDecoration(
              labelText: "No. HP",
              prefixIcon: Icon(Icons.phone, color: Colors.teal),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),

          // --- Deskripsi ---
          const TextField(
            decoration: InputDecoration(
              labelText: "Deskripsi",
              prefixIcon: Icon(Icons.description, color: Colors.teal),
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),

          const SizedBox(height: 24),

          // --- DAFTAR PRODUK ---
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Daftar Produk",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text("Smartphone XYZ"),
                  subtitle: Text("Rp 3.500.000"),
                ),
                ListTile(
                  leading: Icon(Icons.laptop_mac),
                  title: Text("Laptop Pro 14"),
                  subtitle: Text("Rp 12.000.000"),
                ),
                ListTile(
                  leading: Icon(Icons.watch),
                  title: Text("Smartwatch Fit"),
                  subtitle: Text("Rp 1.200.000"),
                ),
                ListTile(
                  leading: Icon(Icons.headphones),
                  title: Text("Headphone TDR"),
                  subtitle: Text("Rp 950.000"),
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('Smart TV 43"'),
                  subtitle: Text("Rp 5.300.000"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
