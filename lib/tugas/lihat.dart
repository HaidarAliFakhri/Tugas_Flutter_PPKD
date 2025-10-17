import 'package:flutter/material.dart';

class GestureDetectorButtonDay12 extends StatelessWidget {
  const GestureDetectorButtonDay12({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GestureDetector Button")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onLongPress: () {
                print("Tekan lama");
              },
              onDoubleTap: () {
                print("Tekan dua kali");
              },
              onTap: () {
                print("Tekan sekali");
              },
              child: Text("Tekan disini"),
            ),
          ),
        ],
      ),
    );
  }
}
