import 'dart:convert';

class DeleteCarResponseModel {
  final String message;
  final int? statusCode;

  DeleteCarResponseModel({required this.message, this.statusCode});

  factory DeleteCarResponseModel.fromRawJson(String str) =>
      DeleteCarResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteCarResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteCarResponseModel(
      message: json['message'] ?? 'Mobil berhasil dihapus',
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
  };
}