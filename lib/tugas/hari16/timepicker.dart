import 'package:flutter/material.dart';

class Timepickertugas7 extends StatefulWidget {
  const Timepickertugas7({super.key});

  @override
  State<Timepickertugas7> createState() => _Timepickertugas7State();
}

class _Timepickertugas7State extends State<Timepickertugas7> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atur Pengingat"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Pengingat diatur pukul: ${pickedTime.format(context)}",
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text("Pilih Waktu Pengingat"),
            ),
            const SizedBox(height: 20),
            if (_selectedTime != null)
              Text(
                "Pengingat diatur pukul: ${_selectedTime!.format(context)}",
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
