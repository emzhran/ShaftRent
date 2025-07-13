import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/model/request/message_request.dart';
import 'package:shaftrent/data/repository/message_repository.dart';
import 'message_customer_event.dart';
import 'message_customer_state.dart';

class MessageCustomerBloc extends Bloc<MessageCustomerEvent, MessageCustomerState> {
  final MessageRepository messageCustomerrepository;

  MessageCustomerBloc({required this.messageCustomerrepository}) : super(MessageCustomerInitial()) {
    on<FetchMyMessages>(_onFetchMessages);
    on<SendMessageToAdmin>(_onSendMessage);
  }

  Future<void> _onFetchMessages(FetchMyMessages event, Emitter<MessageCustomerState> emit) async {
    final result = await messageCustomerrepository.getMyMessages();

    result.fold(
      (error) => emit(MessageCustomerError(error)),
      (messages) => emit(MessageCustomerLoaded(messages)),
    );
  }

  Future<void> _onSendMessage(SendMessageToAdmin event, Emitter<MessageCustomerState> emit) async {
    final result = await messageCustomerrepository.sendMessage(
      MessageRequest(receiverId: event.receiverId, pesan: event.pesan),
    );

    result.fold(
      (error) => emit(MessageCustomerError(error)),
      (success) {
        emit(MessageCustomerSent(success));
        add(FetchMyMessages());
      },
    );
  }
}
