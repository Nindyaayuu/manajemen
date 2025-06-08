import 'package:flutter/material.dart';
import '../models/barang.dart';
import '../services/supabase_service.dart';

class AddEditScreen extends StatefulWidget {
  final Barang? barang;
  const AddEditScreen({super.key, this.barang});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _stokController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.barang?.nama ?? '');
    _stokController = TextEditingController(
      text: widget.barang?.stok.toString() ?? '',
    );
    _deskripsiController = TextEditingController(
      text: widget.barang?.deskripsi ?? '',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _stokController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _simpanData() async {
    if (_formKey.currentState!.validate()) {
      final barang = Barang(
        id: widget.barang?.id ?? 0,
        nama: _namaController.text,
        stok: int.tryParse(_stokController.text) ?? 0,
        deskripsi: _deskripsiController.text,
      );

      if (widget.barang == null) {
        await SupabaseService.tambahBarang(barang);
      } else {
        await SupabaseService.updateBarang(barang);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.barang != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Barang' : 'Tambah Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Stok tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpanData,
                child: Text(isEditing ? 'Simpan Perubahan' : 'Tambah Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
