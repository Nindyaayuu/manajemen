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
  List<Barang> _barangList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBarang();
  }

  Future<void> _loadBarang() async {
    setState(() => _isLoading = true);
    try {
      final data = await SupabaseService.fetchBarang();
      setState(() {
        _barangList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  void _deleteBarang(int id) async {
    await SupabaseService.hapusBarang(id);
    _loadBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Gudang')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _barangList.isEmpty
              ? const Center(child: Text('Belum ada data barang.'))
              : ListView.builder(
                itemCount: _barangList.length,
                itemBuilder: (context, index) {
                  final barang = _barangList[index];
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
