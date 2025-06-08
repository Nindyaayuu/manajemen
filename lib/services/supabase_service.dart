import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/barang.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;
  static const String tableName = 'barang';

  static Future<List<Barang>> fetchBarang() async {
    final response = await client.from(tableName).select().execute();

    if (response.status != 200) {
      throw Exception('Failed to fetch barang: ${response.status}');
    }

    final data = response.data as List<dynamic>;
    return data.map((e) => Barang.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<void> tambahBarang(Barang barang) async {
    final response =
        await client.from(tableName).insert({
          'nama': barang.nama,
          'stok': barang.stok,
          'deskripsi': barang.deskripsi,
        }).execute();

    if (response.status != 201 && response.status != 200) {
      throw Exception('Failed to add barang: ${response.status}');
    }
  }

  static Future<void> updateBarang(Barang barang) async {
    final response =
        await client
            .from(tableName)
            .update({
              'nama': barang.nama,
              'stok': barang.stok,
              'deskripsi': barang.deskripsi,
            })
            .eq('id', barang.id)
            .execute();

    if (response.status != 200) {
      throw Exception('Failed to update barang: ${response.status}');
    }
  }

  static Future<void> hapusBarang(int id) async {
    final response =
        await client.from(tableName).delete().eq('id', id).execute();

    if (response.status != 200) {
      throw Exception('Failed to delete barang: ${response.status}');
    }
  }
}
