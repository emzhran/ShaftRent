import 'dart:convert';

class ProfileResponseModel {
  final String message;
  final int statusCode;
  final List<Profile> data;

  ProfileResponseModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  ProfileResponseModel copyWith({
    String? message,
    int? statusCode,
    List<Profile>? data,
  }) => ProfileResponseModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory ProfileResponseModel.fromRawJson(String str) =>
      ProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        message: json['message'],
        statusCode: json['status_code'],
        data: List<Profile>.from(json['data'].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetProfileById {
  final String message;
  final int statusCode;
  final Profile data;

  GetProfileById({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetProfileById copyWith({String? message, int? statusCode, Profile? data}) =>
      GetProfileById(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory GetProfileById.fromRawJson(String str) =>
      GetProfileById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProfileById.fromJson(Map<String, dynamic> json) => GetProfileById(
    message: json['message'],
    statusCode: json['status_code'],
    data: Profile.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status_code': statusCode,
    'data': data.toJson(),
  };
}

class Profile {
  final int id;
  final int userId;
  final String nama;
  final String? alamat;
  final String? identitas;
  final String? nomorIdentitas;
  final String? uploadIdentitas;
  final User? user;

  Profile({
    required this.id,
    required this.userId,
    required this.nama,
    required this.alamat,
    required this.identitas,
    required this.nomorIdentitas,
    required this.uploadIdentitas,
    this.user,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'],
        userId: json['user_id'],
        nama: json['nama'],
        alamat: json['alamat'],
        identitas: json['identitas'],
        nomorIdentitas: json['nomor_identitas'],
        uploadIdentitas: json['upload_identitas'],
        user: json['user'] != null ? User.fromJson(json['user']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'nama': nama,
        'alamat': alamat,
        'identitas': identitas,
        'nomor_identitas': nomorIdentitas,
        'upload_identitas': uploadIdentitas,
        'user': user?.toJson(),
      };
}

class User {
  final int id;
  final String email;
  final String? statusAkun;

  User({
    required this.id,
    required this.email,
    this.statusAkun,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        statusAkun: json['status_akun'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'status_akun': statusAkun,
      };
}
