import 'dart:convert';

class GetAllCarModel {
  final String message;
  final int statusCode;
  final List<Car> data;

  GetAllCarModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetAllCarModel copyWith({
    String? message,
    int? statusCode,
    List<Car>? data,
  }) =>GetAllCarModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory GetAllCarModel.fromRawJson(String str) =>
      GetAllCarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllCarModel.fromJson(Map<String, dynamic> json) => GetAllCarModel(
    message: json['message'], 
    statusCode: json['status_code'],
    data: List<Car>.from(json['data'].map((x) => Car.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetCarById {
  final String message;
  final int statusCode;
  final Car data;

  GetCarById({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetCarById copyWith({String? message, int? statusCode, Car? data}) =>
    GetCarById(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
    );

  factory GetCarById.fromRawJson(String str) =>
      GetCarById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCarById.fromJson(Map<String, dynamic> json) => GetCarById(
    message: json['message'],
    statusCode: json['status_code'],
    data: Car.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
    'data': data.toJson(),
  };
}

class Car {
  final int id;
  final String merkMobil;
  final String namaMobil;
  final double hargaMobil;
  final int jumlahMobil;
  final int jumlahKursi;
  final String transmisi;
  final String? fotoMobil;

  Car({
    required this.id,
    required this.merkMobil,
    required this.namaMobil,
    required this.hargaMobil,
    required this.jumlahMobil,
    required this.jumlahKursi,
    required this.transmisi,
    this.fotoMobil,
  });

  Car copyWith({
    int? id,
    String? merkMobil,
    String? namaMobil,
    double? hargaMobil,
    int? jumlahMobil,
    int? jumlahKursi,
    String? transmisi,
    String? fotoMobil,
  }) =>Car(
    id: id ?? this.id,
    merkMobil: merkMobil ?? this.merkMobil,
    namaMobil: namaMobil ?? this.namaMobil,
    hargaMobil: hargaMobil ?? this.hargaMobil,
    jumlahMobil: jumlahMobil ?? this.jumlahMobil,
    jumlahKursi: jumlahKursi ?? this.jumlahKursi,
    transmisi: transmisi ?? this.transmisi,
    fotoMobil: fotoMobil ?? this.fotoMobil,
  );

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json['id'],
    merkMobil: json['merk_mobil'],
    namaMobil: json['nama_mobil'],
    hargaMobil: double.parse(json['harga_mobil'] as String),
    jumlahMobil: json['jumlah_mobil'],
    jumlahKursi: json['jumlah_kursi'],
    transmisi: json['transmisi'],
    fotoMobil: json['foto_mobil'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'merk_mobil': merkMobil,
    'nama_mobil': namaMobil,
    'harga_mobil': hargaMobil,
    'jumlah_mobil': jumlahMobil,
    'jumlah_kursi': jumlahKursi,
    'transmisi': transmisi,
    'foto_mobil': fotoMobil,
  };
}