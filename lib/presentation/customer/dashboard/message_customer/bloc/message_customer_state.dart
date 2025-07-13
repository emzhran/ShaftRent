import 'package:shaftrent/data/model/response/message_response_model.dart';

sealed class MessageCustomerState {}

class MessageCustomerInitial extends MessageCustomerState {}

class MessageCustomerLoading extends MessageCustomerState {}

class MessageCustomerLoaded extends MessageCustomerState {
  final List<ChatItem> messages;

  MessageCustomerLoaded(this.messages);
}

class MessageCustomerSent extends MessageCustomerState {
  final String message;

  MessageCustomerSent(this.message);
}

class MessageCustomerError extends MessageCustomerState {
  final String message;

  MessageCustomerError(this.message);
}
