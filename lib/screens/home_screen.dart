import 'package:flutter/material.dart';
import '../models/barang.dart';
import '../services/supabase_service.dart';
import 'add_edit_screen.dart';
import '../widgets/barang_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Barang>> _barangList;

  @override
  void initState() {
    super.initState();
    _loadBarang();
  }

  void _loadBarang() {
    setState(() {
      _barangList = SupabaseService.fetchBarang();
    });
  }

  void _deleteBarang(int id) async {
    await SupabaseService.hapusBarang(id);
    _loadBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Gudang')),
      body: FutureBuilder<List<Barang>>(
        future: _barangList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data barang.'));
          }

          final barangList = snapshot.data!;
          return ListView.builder(
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              final barang = barangList[index];
              return BarangTile(
                barang: barang,
                onEdit: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditScreen(barang: barang),
                    ),
                  );
                  _loadBarang();
                },
                onDelete: () => _deleteBarang(barang.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditScreen()),
          );
          _loadBarang();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
