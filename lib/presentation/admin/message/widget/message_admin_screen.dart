import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/message_response_model.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_bloc.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_event.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_state.dart';

class MessageAdminScreen extends StatefulWidget {
  const MessageAdminScreen({super.key});

  @override
  State<MessageAdminScreen> createState() => _MessageAdminScreenState();
}

class _MessageAdminScreenState extends State<MessageAdminScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MessageAdminBloc>().add(FetchAllMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: BlocBuilder<MessageAdminBloc, MessageAdminState>(
        builder: (context, state) {
          if (state is MessageAdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MessageAdminLoaded) {
            final grouped = <int, List<ChatItem>>{};
            for (var msg in state.messages) {
              final partnerId = msg.senderId != 1 ? msg.senderId : msg.receiverId;
              grouped.putIfAbsent(partnerId, () => []).add(msg);
            }
            if (grouped.isEmpty) {
              return const Center(child: Text('Belum ada pesan.'));
            }
            return ListView(
              padding: const EdgeInsets.all(12),
              children: grouped.entries.map((entry) {
                final messages = entry.value;
                final lastMessage = messages.last;
                final name = lastMessage.sender.nama != 'Administrator'
                    ? lastMessage.sender.nama
                    : lastMessage.receiver.nama;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: AppColors.white),
                    ),
                    title: Text(name),
                    subtitle: Text(lastMessage.pesan),
                    onTap: () {
                      //navigasi ke chat message admin chat screen
                    },
                  ),
                );
              }).toList(),
            );
          }
          return const Center(child: Text('Tidak ada pesan.'));
        },
      ),
    );
  }
}
