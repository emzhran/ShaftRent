import 'dart:convert';

class RegisterRequestModel {
  final String? nama;
  final String? email;
  final String? password;

  RegisterRequestModel({
    required this.nama,
    required this.email,
    required this.password,
  });

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(jsonDecode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        nama: json['nama'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() {
    return {'nama': nama, 'email': email, 'password': password};
  }
}
