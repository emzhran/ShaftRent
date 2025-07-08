import 'dart:convert';
import 'package:shaftrent/data/model/response/maps_response_model.dart';

class UpdateMapsResponseModel {
  final String message;
  final int? statusCode;
  final Maps? map;

  UpdateMapsResponseModel({
    required this.message,
    this.statusCode,
    this.map,
  });

  factory UpdateMapsResponseModel.fromRawJson(String str) =>
      UpdateMapsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateMapsResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateMapsResponseModel(
      message: json['message'] ?? 'Lokasi berhasil diperbarui',
      statusCode: json['status_code'],
      map: json['map'] != null ? Maps.fromJson(json['map']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'map': map?.toJson(),
      };
}
