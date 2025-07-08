import 'dart:convert';

class MapsResponseModel {
  final String message;
  final int statusCode;
  final List<Maps> data;

  MapsResponseModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  MapsResponseModel copyWith({
    String? message,
    int? statusCode,
    List<Maps>? data,
  }) =>
      MapsResponseModel(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory MapsResponseModel.fromRawJson(String str) =>
      MapsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapsResponseModel.fromJson(Map<String, dynamic> json) =>
      MapsResponseModel(
        message: json['message'] ?? '',
        statusCode: json['status_code'] ?? 200,
        data: List<Maps>.from(json['data'].map((x) => Maps.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetMapById {
  final String message;
  final int statusCode;
  final Maps data;

  GetMapById({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetMapById copyWith({
    String? message,
    int? statusCode,
    Maps? data,
  }) =>
      GetMapById(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory GetMapById.fromRawJson(String str) =>
      GetMapById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMapById.fromJson(Map<String, dynamic> json) => GetMapById(
        message: json['message'] ?? '',
        statusCode: json['status_code'] ?? 200,
        data: Maps.fromJson(json['map'] ?? json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'data': data.toJson(),
      };
}

class Maps {
  final int id;
  final String namaLokasi;
  final double latitude;
  final double longitude;
  String? staticMapImageUrl;

  Maps({
    required this.id,
    required this.namaLokasi,
    required this.latitude,
    required this.longitude,
    this.staticMapImageUrl,
  });

  Maps copyWith({
    int? id,
    String? namaLokasi,
    double? latitude,
    double? longitude,
    String? staticMapImageUrl,
  }) =>
      Maps(
        id: id ?? this.id,
        namaLokasi: namaLokasi ?? this.namaLokasi,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        staticMapImageUrl: staticMapImageUrl ?? this.staticMapImageUrl,
      );

  factory Maps.fromRawJson(String str) =>
      Maps.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        id: json['id'],
        namaLokasi: json['nama_lokasi'],
        latitude: (json['latitude'] is String)
            ? double.tryParse(json['latitude']) ?? 0.0
            : json['latitude']?.toDouble(),
        longitude: (json['longitude'] is String)
            ? double.tryParse(json['longitude']) ?? 0.0
            : json['longitude']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_lokasi': namaLokasi,
        'latitude': latitude,
        'longitude': longitude,
      };
}
