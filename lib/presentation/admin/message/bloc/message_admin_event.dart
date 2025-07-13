sealed class MessageAdminEvent {}

class FetchAllMessages extends MessageAdminEvent {}

class ReplyToCustomer extends MessageAdminEvent {
  final int receiverId;
  final String pesan;

  ReplyToCustomer({
    required this.receiverId,
    required this.pesan,
  });
}
