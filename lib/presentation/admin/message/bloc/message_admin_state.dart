import 'package:shaftrent/data/model/response/message_response_model.dart';

sealed class MessageAdminState {}

class MessageAdminInitial extends MessageAdminState {}

class MessageAdminLoading extends MessageAdminState {}

class MessageAdminLoaded extends MessageAdminState {
  final List<ChatItem> messages;

  MessageAdminLoaded(this.messages);
}

class MessageAdminSent extends MessageAdminState {
  final String message;

  MessageAdminSent(this.message);
}

class MessageAdminError extends MessageAdminState {
  final String error;

  MessageAdminError(this.error);
}
