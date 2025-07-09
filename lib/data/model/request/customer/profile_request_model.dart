class ProfileRequestModel {
  final String alamat;
  final String jenisIdentitas;
  final String nomorIdentitas;
  final String? uploadIdentitas;

  ProfileRequestModel({
    required this.alamat,
    required this.jenisIdentitas,
    required this.nomorIdentitas,
    required this.uploadIdentitas,
  });

  Map<String, dynamic> toMap() {
    return {
      'alamat': alamat,
      'identitas': jenisIdentitas,
      'nomor_identitas': nomorIdentitas,
      'upload_identitas': uploadIdentitas,
    };
  }
}
