import 'dart:convert';

class CarResponseModel {
  final String message;
  final int statusCode;
  final List<Car> data;

  CarResponseModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  CarResponseModel copyWith({
    String? message,
    int? statusCode,
    List<Car>? data,
  }) =>CarResponseModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory CarResponseModel.fromRawJson(String str) =>
      CarResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarResponseModel.fromJson(Map<String, dynamic> json) => CarResponseModel(
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
  final String nomorKendaraan;
  final double hargaMobil;
  final int jumlahMobil;
  final int jumlahKursi;
  final String transmisi;
  final String? gambarmobil;

  Car({
    required this.id,
    required this.merkMobil,
    required this.namaMobil,
    required this.nomorKendaraan,
    required this.hargaMobil,
    required this.jumlahMobil,
    required this.jumlahKursi,
    required this.transmisi,
    this.gambarmobil,
  });

  Car copyWith({
    int? id,
    String? merkMobil,
    String? namaMobil,
    String? nomorKendaraan,
    double? hargaMobil,
    int? jumlahMobil,
    int? jumlahKursi,
    String? transmisi,
    String? gambarmobil,
  }) =>Car(
    id: id ?? this.id,
    merkMobil: merkMobil ?? this.merkMobil,
    namaMobil: namaMobil ?? this.namaMobil,
    nomorKendaraan: nomorKendaraan ?? this.nomorKendaraan,
    hargaMobil: hargaMobil ?? this.hargaMobil,
    jumlahMobil: jumlahMobil ?? this.jumlahMobil,
    jumlahKursi: jumlahKursi ?? this.jumlahKursi,
    transmisi: transmisi ?? this.transmisi,
    gambarmobil: gambarmobil ?? this.gambarmobil,
  );

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json['id'] as int,
    merkMobil: json['merk_mobil'],
    namaMobil: json['nama_mobil'],
    nomorKendaraan: json['nomor_kendaraan'],
    hargaMobil: (json['harga_mobil'] as num).toDouble(),
    jumlahMobil: json['jumlah_mobil'] as int,
    jumlahKursi: json['jumlah_kursi'] as int,
    transmisi: json['transmisi'],
    gambarmobil: json['gambar_mobil'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'merk_mobil': merkMobil,
    'nama_mobil': namaMobil,
    'nomor_kendaraan': nomorKendaraan,
    'harga_mobil': hargaMobil,
    'jumlah_mobil': jumlahMobil,
    'jumlah_kursi': jumlahKursi,
    'transmisi': transmisi,
    'gambar_mobil': gambarmobil,
  };
}