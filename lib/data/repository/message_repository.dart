import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shaftrent/data/model/request/message_request.dart';
import 'package:shaftrent/data/model/response/message_response_model.dart';
import 'package:shaftrent/service/service_http_client.dart';

class MessageRepository {
  final ServiceHttpClient _serviceHttpClient;

  MessageRepository(this._serviceHttpClient);
  Future<Either<String, List<ChatItem>>> getMyMessages() async {
    try {
      final response = await _serviceHttpClient.get('customer/messages/my-messages');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final messages = (jsonResponse['data'] as List)
            .map((item) => ChatItem.fromJson(item))
            .toList();
        return Right(messages);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat pesan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat pesan: ${e.toString()}');
    }
  }

  Future<Either<String, List<ChatItem>>> getAllMessages() async {
    try {
      final response = await _serviceHttpClient.get('admin/messages');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final messages = (jsonResponse['data'] as List)
            .map((item) => ChatItem.fromJson(item))
            .toList();
        return Right(messages);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat semua pesan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat pesan: ${e.toString()}');
    }
  }

  Future<Either<String, String>> sendMessage(MessageRequest request) async {
    try {
      final endpoint = request.isFromAdmin
          ? 'admin/messages/reply'
          : 'customer/messages/send';

      final response = await _serviceHttpClient.post(endpoint, request.toMap());
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        return Right(jsonResponse['message'] ?? 'Pesan berhasil dikirim!');
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal mengirim pesan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat mengirim pesan: ${e.toString()}');
    }
  }
}
