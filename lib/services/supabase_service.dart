import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/barang.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;
  static const String tableName = 'barang';

  // Ambil semua data barang
  static Future<List<Barang>> fetchBarang() async {
    final data = await client.from(tableName).select();
    return (data as List<dynamic>)
        .map((e) => Barang.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Tambah barang baru
  static Future<void> tambahBarang(Barang barang) async {
    final response = await client.from(tableName).insert({
      'nama': barang.nama,
      'stok': barang.stok,
      'deskripsi': barang.deskripsi,
    });

    if (response == null) {
      throw Exception('Gagal menambahkan barang');
    }
  }

  // Update barang berdasarkan id
  static Future<void> updateBarang(Barang barang) async {
    final response = await client
        .from(tableName)
        .update({
          'nama': barang.nama,
          'stok': barang.stok,
          'deskripsi': barang.deskripsi,
        })
        .eq('id', barang.id);

    if (response == null) {
      throw Exception('Gagal mengupdate barang');
    }
  }

  // Hapus barang berdasarkan id
  static Future<void> hapusBarang(int id) async {
    final response = await client.from(tableName).delete().eq('id', id);

    if (response == null) {
      throw Exception('Gagal menghapus barang');
    }
  }
}
