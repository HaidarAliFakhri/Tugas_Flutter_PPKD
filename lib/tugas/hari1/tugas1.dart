import 'package:flutter/material.dart';

class Tugas1Page extends StatelessWidget {
  const Tugas1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Haidar Ali Fakhri',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.location_on, color: Colors.blueAccent),
                SizedBox(width: 6),
                Text('Jakarta', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Seorang pelajar yang sedang belajar Flutter.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
