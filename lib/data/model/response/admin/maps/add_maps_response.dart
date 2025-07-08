import 'dart:convert';
import 'package:shaftrent/data/model/response/maps_response_model.dart';

class AddMapsResponseModel {
  final String message;
  final int? statusCode;
  final Maps? map;

  AddMapsResponseModel({
    required this.message,
    this.statusCode,
    this.map,
  });

  factory AddMapsResponseModel.fromRawJson(String str) =>
      AddMapsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddMapsResponseModel.fromJson(Map<String, dynamic> json) {
    return AddMapsResponseModel(
      message: json['message'] ?? 'Lokasi berhasil ditambahkan',
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
