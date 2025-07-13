class MessageRequest {
  final int receiverId;
  final String pesan;
  final bool isFromAdmin;

  MessageRequest({
    required this.receiverId,
    required this.pesan,
    this.isFromAdmin = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'receiver_id': receiverId,
      'pesan': pesan,
    };
  }
}
