import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/customer/dashboard/message_customer/bloc/message_customer_bloc.dart';
import 'package:shaftrent/presentation/customer/dashboard/message_customer/bloc/message_customer_event.dart';
import 'package:shaftrent/presentation/customer/dashboard/message_customer/bloc/message_customer_state.dart';

class MessageCustomerScreen extends StatefulWidget {
  const MessageCustomerScreen({super.key});

  @override
  State<MessageCustomerScreen> createState() => _MessageCustomerScreenState();
}

class _MessageCustomerScreenState extends State<MessageCustomerScreen> {
  final TextEditingController kirimPesanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MessageCustomerBloc>().add(FetchMyMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageCustomerBloc, MessageCustomerState>(
              builder: (context, state) {
                if (state is MessageCustomerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MessageCustomerLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      final msg = messages[index];
                      final isMe = msg.sender.nama != 'Administrator';
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? AppColors.primary : AppColors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            msg.pesan,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('Belum ada pesan.'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: kirimPesanController,
                    decoration: InputDecoration(
                      hintText: 'Tulis pesan...',
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
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: () {
                    if (kirimPesanController.text.trim().isEmpty) return;
                    context.read<MessageCustomerBloc>().add(SendMessageToAdmin(
                          receiverId: 1,
                          pesan: kirimPesanController.text.trim(),
                        ));
                    kirimPesanController.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
