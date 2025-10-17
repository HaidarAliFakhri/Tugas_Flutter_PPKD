import 'package:flutter/material.dart';

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

  // Untuk GestureDetector
  int gestureValue = 0;
  String gestureText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Interaksi"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. ElevatedButton
            Center(
              child: Column(
                children: [
                  if (showName)
                    const Text(
                      "Haidar Ali Fakhri",
                      style: TextStyle(fontSize: 18),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showName = !showName;
                      });
                    },
                    child: const Text("Tampilkan Nama"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. IconButton
            Column(
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
                  iconSize: 32,
                ),
                if (liked)
                  const Text("Disukai", style: TextStyle(fontSize: 16)),
              ],
            ),

            const SizedBox(height: 20),

            // 3. TextButton
            TextButton(
              onPressed: () {
                setState(() {
                  showDescription = !showDescription;
                });
              },
              child: const Text("Lihat Selengkapnya"),
            ),
            if (showDescription)
              const Text("Hallo, saya deskripsi", textAlign: TextAlign.center),

            const SizedBox(height: 20),

            // 4. InkWell
            InkWell(
              onTap: () {
                debugPrint("Kotak disentuh");
                setState(() {
                  showBoxText = !showBoxText;
                });
              },
              splashColor: Colors.white,
              child: Container(
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Tekan Kotak",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (showBoxText)
              const Text(
                "Kotak disentuh!",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

            const SizedBox(height: 30),

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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
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

      // 6. FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: counter > 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Text(
                "Counter: $counter",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            )
          : null,
    );
  }
}
