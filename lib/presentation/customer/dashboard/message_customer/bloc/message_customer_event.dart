sealed class MessageCustomerEvent {}

class FetchMyMessages extends MessageCustomerEvent {}

class SendMessageToAdmin extends MessageCustomerEvent {
  final int receiverId;
  final String pesan;

  SendMessageToAdmin({
    required this.receiverId,
    required this.pesan,
  });
}
