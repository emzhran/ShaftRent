import 'dart:convert';

class DeleteMapsResponseModel {
  final String message;
  final int? statusCode;

  DeleteMapsResponseModel({
    required this.message,
    this.statusCode,
  });

  factory DeleteMapsResponseModel.fromRawJson(String str) =>
      DeleteMapsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteMapsResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteMapsResponseModel(
      message: json['message'] ?? 'Lokasi berhasil dihapus',
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
      };
}
