import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/hari17/list_view.dart';

import 'tugas9_list.dart';
import 'tugas9_produk.dart';

class Tugas9DrawerPage extends StatefulWidget {
  const Tugas9DrawerPage({super.key});

  @override
  State<Tugas9DrawerPage> createState() => _Tugas9DrawerPageState();
}

class _Tugas9DrawerPageState extends State<Tugas9DrawerPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    TanpaMap(),
    Tugas9PageList(),

    ListProduk(kategori: 'Peralatan Dapur'),
  ];

  final List<String> _titles = const [
    'List String',
    'List Dengan Map+icon',
    'List Peralatan Dapur (Model)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Center(
                child: Text(
                  'Menu Tugas 9 Flutter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('List String'),
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('List Dengan Map+icon'),
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.kitchen),
              title: const Text('List Peralatan Dapur'),
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
