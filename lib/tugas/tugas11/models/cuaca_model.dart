class CuacaModel {
  int? id;
  String kota;
  String kondisi;
  double suhu;
  String tanggal;

  CuacaModel({
    this.id,
    required this.kota,
    required this.kondisi,
    required this.suhu,
    required this.tanggal,
  });

  factory CuacaModel.fromMap(Map<String, dynamic> map) {
    return CuacaModel(
      id: map['id'],
      kota: map['kota'],
      kondisi: map['kondisi'],
      suhu: map['suhu'],
      tanggal: map['tanggal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kota': kota,
      'kondisi': kondisi,
      'suhu': suhu,
      'tanggal': tanggal,
    };
  }
}
