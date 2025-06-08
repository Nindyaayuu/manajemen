class Barang {
  final int id;
  final String nama;
  final int stok;
  final String? deskripsi;

  Barang({
    required this.id,
    required this.nama,
    required this.stok,
    required this.deskripsi,
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

  Barang copyWith({int? id, String? nama, int? stok, String? deskripsi}) {
    return Barang(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
      deskripsi: deskripsi ?? this.deskripsi,
    );
  }
}
