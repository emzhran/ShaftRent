class ProfileCustomerResponseModel {
  final List<ProfileCustomer> data;

  ProfileCustomerResponseModel({required this.data});

  factory ProfileCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileCustomerResponseModel(
      data: List<ProfileCustomer>.from(
        json['data'].map((x) => ProfileCustomer.fromJson(x)),
      ),
    );
  }
}

class ProfileCustomer {
  final int id;
  final String? nama;
  final String? status;
  final String? alamat;
  final String? identitas;
  final String? uploadIdentitas;
  final String? nomorIdentitas;
  final User? user;


  ProfileCustomer({
    required this.id,
    this.nama,
    this.status,
    this.alamat,
    this.identitas,
    this.uploadIdentitas,
    this.nomorIdentitas,
    this.user,
  });

  factory ProfileCustomer.fromJson(Map<String, dynamic> json) {
    return ProfileCustomer(
      id: json['id'],
      nama: json['nama'],
      status: json['user']?['status_akun'],
      alamat: json['alamat'],
      identitas: json['identitas'],
      uploadIdentitas: json['upload_identitas'],
      nomorIdentitas: json['nomor_identitas'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final int id;
  final String email;
  final Role? role;

  User({
    required this.id,
    required this.email,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
    );
  }
}

class Role {
  final int id;
  final String? nama;

  Role({required this.id, this.nama});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      nama: json['nama'],
    );
  }
}
