import 'dart:convert';

import 'package:shaftrent/data/model/response/auth_response_model.dart';
import 'package:shaftrent/data/model/response/car_response_model.dart';

class OrderCarResponseModel {
  final String message;
  final CarOrder data;

  OrderCarResponseModel({
    required this.message,
    required this.data,
  });

  factory OrderCarResponseModel.fromRawJson(String str) =>
      OrderCarResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCarResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderCarResponseModel(
        message: json['message'] as String,
        data: CarOrder.fromJson(json['order'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'order': data.toJson(),
      };
}

class CarOrder {
  final int id;
  final int userId;
  final int carId;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String metodePembayaran;
  final String statusPemesanan;
  final User? user;
  final Car? car;

  CarOrder({
    required this.id,
    required this.userId,
    required this.carId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.metodePembayaran,
    required this.statusPemesanan,
    this.user,
    this.car,
  });

  factory CarOrder.fromJson(Map<String, dynamic> json) => CarOrder(
        id: json['id'] as int,
        userId: json['user_id'] as int,
        carId: json['car_id'] as int,
        tanggalMulai: json['tanggal_mulai'] as String,
        tanggalSelesai: json['tanggal_selesai'] as String,
        metodePembayaran: json['metode_pembayaran'] as String,
        statusPemesanan: json['status_pemesanan'] as String,
        user: json['user'] != null ? User.fromMap(json['user']) : null,
        car: json['car'] != null ? Car.fromJson(json['car']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'car_id': carId,
        'tanggal_mulai': tanggalMulai,
        'tanggal_selesai': tanggalSelesai,
        'metode_pembayaran': metodePembayaran,
        'status_pemesanan': statusPemesanan,
        if (user != null) 'user': user!.toJson(),
        if (car != null) 'car': car!.toJson(),
      };
}
