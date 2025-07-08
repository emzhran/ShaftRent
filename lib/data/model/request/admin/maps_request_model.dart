class MapsRequestModel {
  final String? namaLokasi;
  final double? latitude;
  final double? longitude;

  MapsRequestModel({
    this.namaLokasi,
    this.latitude,
    this.longitude,
  });

  factory MapsRequestModel.fromMap(Map<String, dynamic> json) => MapsRequestModel(
        namaLokasi: json['nama_lokasi'],
        latitude: (json['latitude'] is String)
            ? double.tryParse(json['latitude'])
            : json['latitude']?.toDouble(),
        longitude: (json['longitude'] is String)
            ? double.tryParse(json['longitude'])
            : json['longitude']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'nama_lokasi': namaLokasi,
        'latitude': latitude,
        'longitude': longitude,
      };
}
