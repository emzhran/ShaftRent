import 'dart:convert';

class DeleteCarModel {
  final String message;
  final int? statusCode;

  DeleteCarModel({required this.message, this.statusCode});

  factory DeleteCarModel.fromRawJson(String str) =>
      DeleteCarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteCarModel.fromJson(Map<String, dynamic> json) {
    return DeleteCarModel(
      message: json['message'] ?? 'Mobil berhasil dihapus',
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
  };
}