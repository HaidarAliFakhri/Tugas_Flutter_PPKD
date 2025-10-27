import 'package:flutter/material.dart';
import '../db/db_helper_haitrip.dart';
import '../models/participant.dart';
import 'form_pendaftaran.dart';

class ParticipantsList extends StatefulWidget {
  const ParticipantsList({super.key});

  @override
  State<ParticipantsList> createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  List<Participant> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    _items = await DBHelperTrip().getAllParticipants();
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _delete(int id) async {
    await DBHelperTrip().deleteParticipant(id);
    await _load();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Data dihapus'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peserta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // buka form pendaftaran; jika berhasil menyimpan, refresh list
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FormPendaftaranWisatawan()),
              );
              if (result == true) await _load();
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text('Belum ada peserta terdaftar.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final p = _items[index];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('${p.email} • ${p.phone}\n${p.city}'),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _confirmDelete(p.id!),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: _items.length,
                ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus data'),
        content: const Text('Yakin ingin menghapus peserta ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _delete(id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
