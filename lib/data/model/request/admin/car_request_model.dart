class CarRequestModel {
  final String? merkMobil;
  final String? namaMobil;
  final String? nomorKendaraan;
  final double? hargaMobil;
  final int? jumlahMobil;
  final int? jumlahKursi;
  final String? transmisi;
  final String? gambarMobil;

  CarRequestModel({
    this.merkMobil,
    this.namaMobil,
    this.nomorKendaraan,
    this.hargaMobil,
    this.jumlahMobil,
    this.jumlahKursi,
    this.transmisi,
    this.gambarMobil,
  });


  factory CarRequestModel.fromMap(Map<String, dynamic> json) =>
      CarRequestModel(
        merkMobil: json['merk_mobil'],
        namaMobil: json['nama_mobil'],
        nomorKendaraan: json['nomor_kendaraan'],
        hargaMobil: json['harga_mobil']?.toDouble(),
        jumlahMobil: json['jumlah_mobil'],
        jumlahKursi: json['jumlah_kursi'],
        transmisi: json['transmisi'],
        gambarMobil: json['gambar_mobil'],
      );

  Map<String, dynamic> toMap() => {
        'merk_mobil': merkMobil,
        'nama_mobil': namaMobil,
        'nomor_kendaraan': nomorKendaraan,
        'harga_mobil': hargaMobil,
        'jumlah_mobil': jumlahMobil,
        'jumlah_kursi': jumlahKursi,
        'transmisi': transmisi,
        'gambar_mobil': gambarMobil,
      };
}