import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Gudang')),
      body: const Center(
        child: Text('Belum ada data barang.', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
