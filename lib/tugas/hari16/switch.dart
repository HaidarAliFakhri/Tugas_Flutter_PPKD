import 'package:flutter/material.dart';

class Modegelap extends StatefulWidget {
  const Modegelap({super.key});

  @override
  State<Modegelap> createState() => _ModegelapState();
}

class _ModegelapState extends State<Modegelap> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: isSwitched ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch Mode Gelap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Aktifkan Mode Gelap",
                  style: TextStyle(
                    fontSize: 18,
                    color: isSwitched ? Colors.white : Colors.black,
                  ),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                isSwitched ? "Mode Gelap Aktif" : "Mode Terang Aktif",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSwitched ? Colors.white : Colors.black,
                ),
              ),
            ),
            const Divider(height: 40, thickness: 1),
          ],
        ),
      ),
    );
  }
}
