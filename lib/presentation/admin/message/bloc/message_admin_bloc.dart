import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/model/request/message_request.dart';
import 'package:shaftrent/data/repository/message_repository.dart';
import 'message_admin_event.dart';
import 'message_admin_state.dart';

class MessageAdminBloc extends Bloc<MessageAdminEvent, MessageAdminState> {
  final MessageRepository messageAdminRepository;

  MessageAdminBloc({required this.messageAdminRepository}) : super(MessageAdminInitial()) {
    on<FetchAllMessages>(_onFetchAll);
    on<ReplyToCustomer>(_onReply);
  }

  Future<void> _onFetchAll(FetchAllMessages event, Emitter<MessageAdminState> emit) async {
    final result = await messageAdminRepository.getAllMessages();
    result.fold(
      (error) => emit(MessageAdminError(error)),
      (messages) => emit(MessageAdminLoaded(messages)),
    );
  }

  Future<void> _onReply(ReplyToCustomer event, Emitter<MessageAdminState> emit) async {
    final result = await messageAdminRepository.sendMessage(
      MessageRequest(receiverId: event.receiverId, pesan: event.pesan, isFromAdmin: true),
    );

    result.fold(
      (error) => emit(MessageAdminError(error)),
      (success) {
        emit(MessageAdminSent(success));
        add(FetchAllMessages());
      },
    );
  }
}
