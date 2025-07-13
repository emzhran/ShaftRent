class StatusUpdateRequest {
  final String statusPemesanan;

  StatusUpdateRequest({required this.statusPemesanan});

  Map<String, dynamic> toMap() {
    return {
      'status_pemesanan': statusPemesanan,
    };
  }
}
