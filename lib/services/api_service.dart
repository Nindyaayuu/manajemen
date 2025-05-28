import '../models/barang.dart';

class ApiService {
  static final List<Barang> _dummyData = [];

  static Future<List<Barang>> fetchBarang() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _dummyData;
  }

  static Future<void> tambahBarang(Barang barang) async {
    final newBarang = barang.copyWith(
      id: DateTime.now().millisecondsSinceEpoch,
    );
    _dummyData.add(newBarang);
  }

  static Future<void> updateBarang(Barang barang) async {
    final index = _dummyData.indexWhere((item) => item.id == barang.id);
    if (index != -1) {
      _dummyData[index] = barang;
    }
  }

  static Future<void> hapusBarang(int id) async {
    _dummyData.removeWhere((item) => item.id == id);
  }
}
