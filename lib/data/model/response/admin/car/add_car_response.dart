import 'dart:convert';

class AddCarModel {
  final String message;
  final int? statusCode;

  AddCarModel({required this.message, this.statusCode});

  factory AddCarModel.fromRawJson(String str) =>
      AddCarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCarModel.fromJson(Map<String, dynamic> json) {
    return AddCarModel(
      message: json['message'] ?? 'Mobil berhasil ditambahkan',
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
  };
}