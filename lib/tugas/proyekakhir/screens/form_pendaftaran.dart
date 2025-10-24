import 'package:flutter/material.dart';
import '../db/db_helper_haitrip.dart';
import '../models/participant.dart';

class FormPendaftaranWisatawan extends StatefulWidget {
  const FormPendaftaranWisatawan({super.key});

  @override
  State<FormPendaftaranWisatawan> createState() => _FormPendaftaranWisatawanState();
}

class _FormPendaftaranWisatawanState extends State<FormPendaftaranWisatawan> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _cityC = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _cityC.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final participant = Participant(
      name: _nameC.text.trim(),
      email: _emailC.text.trim(),
      phone: _phoneC.text.trim(),
      city: _cityC.text.trim(),
    );

    try {
      await DBHelperTrip().insertParticipant(participant);
      // kembali dan beri tahu caller agar list bisa refresh
      Navigator.pop(context, true);
    } catch (e) {
      // fallback error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // penting agar background "naik" sampai belakang AppBar
  appBar: AppBar(
    title: const Text(
      'Form Pendaftaran',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
      body: Stack(
  children: [
    // Gambar background
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logoHaiTime/Bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),

    // Overlay hitam transparan
    Container(
      color: Colors.black.withOpacity(0.25),
    ),

    // Konten utama (form login)
    SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
              TextFormField(
                controller: _nameC,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailC,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                  final pattern =
                      RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                  if (!pattern.hasMatch(v.trim())) return 'Format email salah';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneC,
                decoration: const InputDecoration(labelText: 'Nomor HP'),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Nomor HP wajib' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityC,
                decoration: const InputDecoration(labelText: 'Asal Kota'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Asal kota wajib' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
   ],), );
  }
}
