import 'dart:convert';

class UpdateCarResponseModel {
  final String message;
  final int? statusCode;

  UpdateCarResponseModel({required this.message, this.statusCode});

  factory UpdateCarResponseModel.fromRawJson(String str) =>
      UpdateCarResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateCarResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateCarResponseModel(
      message: json['message'] ?? 'Mobil berhasil diperbarui',
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
  };
}