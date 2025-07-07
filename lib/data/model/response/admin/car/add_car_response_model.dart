import 'dart:convert';
import 'package:shaftrent/data/model/response/car_response_model.dart';

class AddCarResponseModel {
  final String message;
  final int? statusCode;
  final Car? car;

  AddCarResponseModel({required this.message, this.statusCode, this.car});

  factory AddCarResponseModel.fromRawJson(String str) =>
      AddCarResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCarResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCarResponseModel(
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