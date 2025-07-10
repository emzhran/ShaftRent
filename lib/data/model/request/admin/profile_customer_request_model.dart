class StatusAccountRequestModel {
  final String customerId;
  final String status;

  StatusAccountRequestModel({
    required this.customerId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'status_akun': status,
    };
  }
}
