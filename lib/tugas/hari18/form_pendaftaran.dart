import 'package:flutter/material.dart';
import 'halaman_konfirmasi.dart';

class FormPendaftaran extends StatefulWidget {
  const FormPendaftaran({super.key});

  @override
  State<FormPendaftaran> createState() => _FormPendaftaranState();
}

class _FormPendaftaranState extends State<FormPendaftaran> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // tampilkan dialog ringkasan
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Konfirmasi Data"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Lengkap: ${namaController.text}"),
                Text("Email: ${emailController.text}"),
                Text("Nomor HP: ${hpController.text.isEmpty ? '-' : hpController.text}"),
                Text("Kota Domisili: ${kotaController.text}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Kembali"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HalamanKonfirmasi(
                        nama: namaController.text,
                        kota: kotaController.text,
                      ),
                    ),
                  );
                },
                child: const Text("Lanjut"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulir Pendaftaran Kelas Flutter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Nama wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email wajib diisi";
                }

                // pola regex email umum
                final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );

                if (!emailRegex.hasMatch(value)) {
                  return "Format email tidak valid";
                }

                return null;
              },
            ),

              const SizedBox(height: 16),
              TextFormField(
                controller: hpController,
                decoration: const InputDecoration(
                  labelText: "Nomor HP (opsional)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: kotaController,
                decoration: const InputDecoration(
                  labelText: "Kota Domisili",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Kota wajib diisi" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
