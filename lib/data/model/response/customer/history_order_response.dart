class HistoryOrder {
  final int id;
  final int userId;
  final Car? car;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final String metodePembayaran;
  final String statusPemesanan;
  final int? rating;

  HistoryOrder({
    required this.id,
    required this.userId,
    this.car,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.metodePembayaran,
    required this.statusPemesanan,
    required this.rating
  });

  factory HistoryOrder.fromJson(Map<String, dynamic> json) {
    return HistoryOrder(
      id: json['id'],
      userId: json['user_id'],
      car: json['car'] != null ? Car.fromJson(json['car']) : null,
      tanggalMulai: DateTime.parse(json['tanggal_mulai']),
      tanggalSelesai: DateTime.parse(json['tanggal_selesai']),
      metodePembayaran: json['metode_pembayaran'],
      statusPemesanan: json['status_pemesanan'],
      rating: json['rating']
    );
  }
}

class Car {
  final int id;
  final String merkMobil;
  final String namaMobil;
  final String nomorKendaraan;
  final String? transmisi;
  final String? gambarMobil;

  Car({
    required this.id,
    required this.merkMobil,
    required this.namaMobil,
    required this.nomorKendaraan,
    required this.transmisi,
    this.gambarMobil,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      merkMobil: json['merk_mobil'],
      namaMobil: json['nama_mobil'],
      nomorKendaraan: json['nomor_kendaraan'],
      transmisi: json['transmisi'],
      gambarMobil: json['gambar_mobil'],
    );
  }
}
