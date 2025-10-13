import 'package:flutter/material.dart';

class ProfilLengkapPage extends StatelessWidget {
  const ProfilLengkapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Lengkap"),
        backgroundColor: Colors.teal,

        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris 1: Nama lengkap di tengah
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    const LinearGradient(
                      colors: [Colors.teal, Colors.blue, Colors.purple],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: const Text(
                  "Haidar Ali Fakhri",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Baris 2: Email
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: const [
                  Icon(Icons.email, color: Colors.teal),
                  SizedBox(width: 8),
                  Text("haidar.ali.fakhri@email.com"),
                ],
              ),
            ),
          ),

          // Baris 3: Nomor Telepon
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: const [
                Icon(Icons.phone, color: Colors.teal),
                SizedBox(width: 8),
                Text("0812-1212-1212"),
                Spacer(),
                Icon(Icons.check_circle, color: Colors.green, size: 18),
              ],
            ),
          ),

          // Baris 4: Dua Container sejajar (Postingan & Followers)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Postingan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Followers",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Baris 5: Deskripsi profil
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.teal, width: 1.5),
              ),
              child: const Text(
                "Haidar adalah mahasiswa Teknik Informatika yang memiliki minat kuat pada dunia teknologi, "
                "khususnya dalam pengembangan aplikasi mobile dan desain antarmuka pengguna. "
                "Ia senang mengeksplorasi cara baru untuk menggabungkan logika pemrograman dengan sentuhan estetika visual, "
                "sehingga setiap karya yang dibuatnya tidak hanya berfungsi dengan baik, tetapi juga nyaman digunakan. "
                "Saat ini Haidar sedang mendalami Flutter sebagai langkah awal membangun aplikasi lintas platform "
                "yang responsif, modern, dan bermanfaat bagi banyak orang. ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 50),

          // Baris 6: Hiasan visual bawah
          Container(
            height: 70,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            child: const Center(
              child: Text(
                "Terima kasih telah mengunjungi profil saya!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
