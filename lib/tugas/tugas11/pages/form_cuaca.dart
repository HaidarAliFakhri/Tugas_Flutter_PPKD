import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/tugas11/models/cuaca_model.dart';

import '../db/db_helper.dart';

class FormCuaca extends StatefulWidget {
  const FormCuaca({super.key});

  @override
  State<FormCuaca> createState() => _FormCuacaState();
}

class _FormCuacaState extends State<FormCuaca> {
  final _formKey = GlobalKey<FormState>();
  final kotaController = TextEditingController();
  final kondisiController = TextEditingController();
  final suhuController = TextEditingController();
  final tanggalController = TextEditingController();

  final dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Data Cuaca")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: kotaController,
                decoration: const InputDecoration(labelText: "Nama Kota"),
                validator: (value) =>
                    value!.isEmpty ? "Nama kota wajib diisi" : null,
              ),
              TextFormField(
                controller: kondisiController,
                decoration: const InputDecoration(labelText: "Kondisi Cuaca"),
                validator: (value) =>
                    value!.isEmpty ? "Kondisi wajib diisi" : null,
              ),
              TextFormField(
                controller: suhuController,
                decoration: const InputDecoration(labelText: "Suhu (°C)"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Suhu wajib diisi" : null,
              ),
              TextFormField(
                controller: tanggalController,
                decoration: const InputDecoration(labelText: "Tanggal"),
                validator: (value) =>
                    value!.isEmpty ? "Tanggal wajib diisi" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final cuaca = CuacaModel(
                      kota: kotaController.text,
                      kondisi: kondisiController.text,
                      suhu: double.parse(suhuController.text),
                      tanggal: tanggalController.text,
                    );
                    await DbHelper.createCuaca(cuaca);
                    if (mounted) Navigator.pop(context, true);
                  }
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
