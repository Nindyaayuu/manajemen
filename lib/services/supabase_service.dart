import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/barang.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;
  static const String tableName = 'barang';

  static Future<List<Barang>> fetchBarang() async {
    final data = await client.from(tableName).select();
    return (data as List).map((e) => Barang.fromJson(e)).toList();
  }

  static Future<void> tambahBarang(Barang barang) async {
    try {
      await client.from(tableName).insert({
        'nama': barang.nama,
        'stok': barang.stok,
        'deskripsi': barang.deskripsi,
      });
    } catch (e) {
      throw Exception('Gagal menambahkan barang: $e');
    }
  }

  static Future<void> updateBarang(Barang barang) async {
    try {
      await client
          .from(tableName)
          .update({
            'nama': barang.nama,
            'stok': barang.stok,
            'deskripsi': barang.deskripsi,
          })
          .eq('id', barang.id);
    } catch (e) {
      throw Exception('Gagal mengupdate barang: $e');
    }
  }

  static Future<void> hapusBarang(int id) async {
    try {
      await client.from(tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Gagal menghapus barang: $e');
    }
  }
}
