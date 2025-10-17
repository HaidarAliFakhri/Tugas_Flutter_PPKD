import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(home: Tugas5Page(), debugShowCheckedModeBanner: false),
  );
}

class Tugas5Page extends StatefulWidget {
  const Tugas5Page({super.key});

  @override
  State<Tugas5Page> createState() => _Tugas5PageState();
}

class _Tugas5PageState extends State<Tugas5Page> {
  bool showName = false;
  bool liked = false;
  bool showDescription = false;
  bool showBoxText = false;
  int counter = 0;

  int gestureValue = 0;
  String gestureText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Halaman Interaksi",
          style: GoogleFonts.poppins(
            // nyoba pakai font google fonts hehe
            fontSize: 20,
          ),
        ),

        backgroundColor: const Color.fromARGB(255, 185, 174, 174),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showName)
              const Text(
                "Haidar Ali Fakhri",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showName = !showName;
                });
              },
              child: const Text("Tampilkan Nama"),
            ),

            const SizedBox(height: 6),

            // Tambahan: Kotak gambar dan row icon seperti Instagram cihuy
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage('https://picsum.photos/400/200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 9),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: liked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      liked = !liked;
                    });
                  },
                  iconSize: 30,
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    debugPrint("Share ditekan");
                  },
                  iconSize: 30,
                  color: Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {
                    debugPrint("Komentar ditekan");
                  },
                  iconSize: 30,
                  color: Colors.grey,
                ),
              ],
            ),

            if (liked)
              const Align(
                alignment: Alignment.centerLeft,

                child: Text("Disukai", style: TextStyle(fontSize: 16)),
              ),
            const SizedBox(height: 3),

            // 3. TextButton
            TextButton(
              onPressed: () {
                setState(() {
                  showDescription = !showDescription;
                });
              },
              child: const Text(
                "Lihat Selengkapnya",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            if (showDescription)
              const Text(
                "Hallo, saya deskripsi",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

            const SizedBox(height: 6),

            // 4. InkWell
            InkWell(
              onTap: () {
                debugPrint("Kotak disentuh");
                setState(() {
                  showBoxText = !showBoxText;
                });
              },
              splashColor: Colors.white24,
              child: Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  showBoxText ? "Kotak disentuh!" : "",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 9),

            // 5. GestureDetector
            GestureDetector(
              onTap: () {
                debugPrint("Ditekan sekali");
                setState(() {
                  gestureText = "Ditekan sekali";
                  gestureValue += 1;
                });
              },
              onDoubleTap: () {
                debugPrint("Ditekan dua kali");
                setState(() {
                  gestureText = "Ditekan dua kali";
                  gestureValue += 2;
                });
              },
              onLongPress: () {
                debugPrint("Tahan lama");
                setState(() {
                  gestureText = "Tahan lama";
                  gestureValue += 3;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Tekan Aku",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$gestureText (+$gestureValue)",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Tombol Minus
          FloatingActionButton(
            onPressed: () {
              setState(() {
                counter--;
              });
            },
            backgroundColor: Colors.grey,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16), // jarak antar tombol
          // Tombol Plus
          FloatingActionButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            backgroundColor: Colors.grey,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: Text(
          "Counter: $counter",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
