import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/message_response_model.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_bloc.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_event.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_state.dart';

class MessageAdminChatScreen extends StatefulWidget {
  final int customerId;
  final String customerName;
  final List<ChatItem> allMessages;

  const MessageAdminChatScreen({
    super.key,
    required this.customerId,
    required this.customerName,
    required this.allMessages,
  });

  @override
  State<MessageAdminChatScreen> createState() => _MessageAdminChatScreenState();
}

class _MessageAdminChatScreenState extends State<MessageAdminChatScreen> {
  final TextEditingController kirimPesanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageAdminBloc, MessageAdminState>(
              builder: (context, state) {
                List<ChatItem> messages = widget.allMessages;
                if (state is MessageAdminLoaded) {
                  messages = state.messages
                      .where(
                        (msg) =>
                            msg.senderId == widget.customerId ||
                            msg.receiverId == widget.customerId,
                      )
                      .toList();
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final msg = messages[index];
                    final isMe = msg.sender.nama == 'Administrator';
                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.primary : AppColors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          msg.pesan,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: kirimPesanController,
                    decoration: InputDecoration(
                      hintText: 'Balas...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                const SpaceWidth(8),
                ElevatedButton(
                  onPressed: () {
                    final text = kirimPesanController.text.trim();
                    if (text.isEmpty) return;
                    context.read<MessageAdminBloc>().add(
                      ReplyToCustomer(
                        receiverId: widget.customerId,
                        pesan: text,
                      ),
                    );
                    kirimPesanController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.send, color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
