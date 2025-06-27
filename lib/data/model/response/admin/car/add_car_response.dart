import 'dart:convert';

import 'package:shaft_rent_app/data/model/response/get_all_car_response_model.dart';

class AddCarModel {
  final String message;
  final int? statusCode;
  final Car? car;

  AddCarModel({required this.message, this.statusCode, this.car});

  factory AddCarModel.fromRawJson(String str) =>
      AddCarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCarModel.fromJson(Map<String, dynamic> json) {
    return AddCarModel(
      message: json['message'] ?? 'Mobil berhasil ditambahkan',
      statusCode: json['status_code'],
      car: json['car'] != null ? Car.fromJson(json['car']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
    'car' : car?.toJson()
  };
}