import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/db_helper_haitrip.dart';
import '../models/participant.dart';

class FormPendaftaranWisatawan extends StatefulWidget {
  const FormPendaftaranWisatawan({super.key});

  @override
  State<FormPendaftaranWisatawan> createState() =>
      _FormPendaftaranWisatawanState();
}

class _FormPendaftaranWisatawanState extends State<FormPendaftaranWisatawan> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _cityC = TextEditingController();
  final _passwordC = TextEditingController();

  bool _isSaving = false;
  bool _obscure = true;

  List<Participant> _participants = [];
  int? _editingId;

  @override
  void initState() {
    super.initState();
    _fetchParticipants();
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _cityC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  Future<void> _fetchParticipants() async {
    final data = await DBHelperTrip().getAllParticipants();
    setState(() => _participants = data);
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
      if (_editingId == null) {
        // Simpan ke database lokal
        await DBHelperTrip().insertParticipant(participant);
      } else {
        participant.id = _editingId;
        await DBHelperTrip().updateParticipant(participant);
        _editingId = null;
      }

      // Simpan data login ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('registered_email', _emailC.text.trim());
      await prefs.setString('registered_password', _passwordC.text.trim());
      await prefs.setString('registered_name', _nameC.text.trim());
      await prefs.setString('registered_phone', _phoneC.text.trim());
      await prefs.setString('registered_city', _cityC.text.trim());

      // Kosongkan field
      _nameC.clear();
      _emailC.clear();
      _phoneC.clear();
      _cityC.clear();
      _passwordC.clear();

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editingId == null
                ? 'Pendaftaran berhasil!'
                : 'Data berhasil diperbarui!',
          ),
        ),
      );

      // Refresh daftar data
      _fetchParticipants();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _deleteParticipant(int id) async {
    await DBHelperTrip().deleteParticipant(id);
    _fetchParticipants();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Form Pendaftaran',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logoHaiTime/Bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.25)),

          // Form isi
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    TextFormField(
                      controller: _nameC,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Nama wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _emailC,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty)
                          return 'Email wajib diisi';
                        final pattern = RegExp(
                          r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                        );
                        if (!pattern.hasMatch(v.trim()))
                          return 'Format email salah';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _passwordC,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => _obscure = !_obscure);
                          },
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Password wajib diisi';
                        } else if (v.length < 6) {
                          return 'Minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _phoneC,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Nomor HP',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Nomor HP wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _cityC,
                      decoration: const InputDecoration(
                        labelText: 'Asal Kota',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Asal kota wajib diisi'
                          : null,
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0077B6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _isSaving ? null : _save,
                        child: _isSaving
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _editingId == null ? 'Simpan' : 'Perbarui',
                                style: const TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 🔹 Daftar data di bawah tombol
                    if (_participants.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Daftar Akun Tersimpan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._participants.map(
                            (p) => Card(
                              color: Colors.white.withOpacity(0.9),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  p.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("📧 ${p.email}"),
                                    Text("📱 ${p.phone}"),
                                    Text("🌆 ${p.city}"),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _editingId = p.id;
                                          _nameC.text = p.name;
                                          _emailC.text = p.email;
                                          _phoneC.text = p.phone;
                                          _cityC.text = p.city;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          _deleteParticipant(p.id!),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
