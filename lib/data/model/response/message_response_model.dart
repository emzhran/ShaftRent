class MessageResponseModel {
  final int id;
  final int senderId;
  final int receiverId;
  final String pesan;
  final DateTime createdAt;

  MessageResponseModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.pesan,
    required this.createdAt,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      pesan: json['pesan'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class ChatUser {
  final int id;
  final String nama;
  final String? email;
  final String? role;

  ChatUser({
    required this.id,
    required this.nama,
    this.email,
    this.role,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      role: json['role']?['nama'],
    );
  }
}

class ChatItem {
  final int id;
  final int senderId;
  final int receiverId;
  final String pesan;
  final DateTime createdAt;
  final UserInfo sender;
  final UserInfo receiver;

  ChatItem({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.pesan,
    required this.createdAt,
    required this.sender,
    required this.receiver,
  });

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      pesan: json['pesan'],
      createdAt: DateTime.parse(json['created_at']),
      sender: UserInfo.fromJson(json['sender']),
      receiver: UserInfo.fromJson(json['receiver']),
    );
  }
}

class UserInfo {
  final int id;
  final String nama;

  UserInfo({required this.id, required this.nama});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      nama: json['nama'],
    );
  }
}
