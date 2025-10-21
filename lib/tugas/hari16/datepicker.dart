import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Datepickertugas7 extends StatefulWidget {
  const Datepickertugas7({super.key});

  @override
  State<Datepickertugas7> createState() => _Datepickertugas7State();
}

class _Datepickertugas7State extends State<Datepickertugas7> {
  DateTime? selectedPicked = DateTime.now();
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data lokal untuk tanggal
    initializeDateFormatting('id', null).then((_) {
      setState(() {
        isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Tanggal Lahir"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedPicked == null
                  ? "Belum ada tanggal yang dipilih"
                  : DateFormat('d MMMM yyyy', 'id').format(selectedPicked!),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedPicked ?? DateTime.now(),
                  firstDate: DateTime(1945),
                  lastDate: DateTime(2100),
                  locale: const Locale('id', 'ID'),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedPicked = pickedDate;
                  });
                }
              },
              child: const Text("Pilih Tanggal Lahir"),
            ),
          ],
        ),
      ),
    );
  }
}
