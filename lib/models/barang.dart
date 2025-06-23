class Barang {
  final int id;
  final String nama;
  final int stok;
  final String? deskripsi;

  Barang({
    required this.id,
    required this.nama,
    required this.stok,
    this.deskripsi,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'],
      nama: json['nama'],
      stok: json['stok'],
      deskripsi: json['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'stok': stok,
    'deskripsi': deskripsi,
  };
}
