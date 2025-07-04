import 'dart:convert';

class OrderCarRequest {
  final int carId;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String metodePembayaran;

  OrderCarRequest({
    required this.carId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.metodePembayaran,
  });

  factory OrderCarRequest.fromMap(Map<String, dynamic> json) =>
      OrderCarRequest(
        carId: json['car_id'] as int,
        tanggalMulai: json['tanggal_mulai'] as String,
        tanggalSelesai: json['tanggal_selesai'] as String,
        metodePembayaran: json['metode_pembayaran'] as String,
      );

  Map<String, dynamic> toMap() => {
        'car_id': carId,
        'tanggal_mulai': tanggalMulai,
        'tanggal_selesai': tanggalSelesai,
        'metode_pembayaran': metodePembayaran,
      };

  String toRawJson() => json.encode(toMap());
}
