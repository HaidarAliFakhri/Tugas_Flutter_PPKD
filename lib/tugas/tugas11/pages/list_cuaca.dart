import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/tugas11/db/db_helper.dart';

import '../models/cuaca_model.dart';
import 'form_cuaca.dart';

class ListCuaca extends StatefulWidget {
  const ListCuaca({super.key});

  @override
  State<ListCuaca> createState() => _ListCuacaState();
}

class _ListCuacaState extends State<ListCuaca> {
  final dbHelper =
      DbHelper(); // pastikan nama class sesuai di file db_helper_contoh.dart
  List<CuacaModel> cuacaList = [];
  bool isLoading = true;

  Future<void> loadData() async {
    try {
      final data = await DbHelper.getAllCuaca();
      setState(() {
        cuacaList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error load data cuaca: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Cuaca - HaiTime",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF42A5F5),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : cuacaList.isEmpty
            ? const Center(
                child: Text(
                  "Belum ada data cuaca ☀️",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : ListView.builder(
                itemCount: cuacaList.length,
                itemBuilder: (context, index) {
                  final cuaca = cuacaList[index];
                  final icon = cuaca.kondisi.toLowerCase().contains("hujan")
                      ? Icons.umbrella
                      : cuaca.kondisi.toLowerCase().contains("cerah")
                      ? Icons.wb_sunny
                      : cuaca.kondisi.toLowerCase().contains("berawan")
                      ? Icons.cloud_queue
                      : Icons.cloud;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(icon, color: Colors.blueAccent, size: 36),
                      title: Text(
                        cuaca.kota,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${cuaca.kondisi} • ${cuaca.suhu}°C\n${cuaca.tanggal}",
                        style: const TextStyle(height: 1.4),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF42A5F5),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormCuaca()),
          );
          if (result == true) loadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
