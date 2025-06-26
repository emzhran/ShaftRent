import 'dart:convert';

class UpdateCarModel {
  final String message;
  final int? statusCode;

  UpdateCarModel({required this.message, this.statusCode});

  factory UpdateCarModel.fromRawJson(String str) =>
      UpdateCarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateCarModel.fromJson(Map<String, dynamic> json) {
    return UpdateCarModel(
      message: json['message'] ?? 'Mobil berhasil diperbarui',
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
  };
}