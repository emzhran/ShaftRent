import 'package:shaftrent/data/model/response/car_response_model.dart';

class StatusOrderUpdate {
  final String message;
  final CarOrderAdmin order;

  StatusOrderUpdate({
    required this.message,
    required this.order,
  });

  factory StatusOrderUpdate.fromJson(Map<String, dynamic> json) {
    return StatusOrderUpdate(
      message: json['message'] ?? 'Status berhasil diperbarui',
      order: CarOrderAdmin.fromJson(json['order']),
    );
  }
}

class CarOrderAdmin {
  final int id;
  final int userId;
  final int carId;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String metodePembayaran;
  final String statusPemesanan;
  final Car? car;
  final String? nama;
  final String? email;
  final String? alamat;
  final String? identitas;
  final String? nomorIdentitas;

  CarOrderAdmin({
    required this.id,
    required this.userId,
    required this.carId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.metodePembayaran,
    required this.statusPemesanan,
    this.car,
    this.nama,
    this.email,
    this.alamat,
    this.identitas,
    this.nomorIdentitas,
  });

  factory CarOrderAdmin.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return CarOrderAdmin(
      id: json['id'],
      userId: json['user_id'],
      carId: json['car_id'],
      tanggalMulai: json['tanggal_mulai'],
      tanggalSelesai: json['tanggal_selesai'],
      metodePembayaran: json['metode_pembayaran'],
      statusPemesanan: json['status_pemesanan'],
      car: json['car'] != null ? Car.fromJson(json['car']) : null,
      nama: user['nama'],
      email: user['email'],
      alamat: user['alamat'],
      identitas: user['identitas'],
      nomorIdentitas: user['nomor_identitas'],
    );
  }
}
