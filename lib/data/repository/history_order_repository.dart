import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shaftrent/data/model/response/customer/history_order_response.dart';
import 'package:shaftrent/service/service_http_client.dart';

class HistoryOrderRepository {
  final ServiceHttpClient _serviceHttpClient;

  HistoryOrderRepository(this._serviceHttpClient);

  Future<Either<String, List<HistoryOrder>>> getHistoryOrders() async {
    try {
      final response = await _serviceHttpClient.get('customer/orders');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<HistoryOrder> orders = List<HistoryOrder>.from(
          (jsonResponse['data'] as List).map((e) => HistoryOrder.fromJson(e)),
        );
        return Right(orders);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat riwayat pesanan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat riwayat pesanan: ${e.toString()}');
    }
  }

  Future<Either<String, String>> submitRating({
    required int orderId,
    required int rating,
  }) async {
    try {
      final response = await _serviceHttpClient.put(
        'customer/orders/$orderId',
        {
          'rating': rating,
        },
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return Right(jsonResponse['message'] ?? 'Rating berhasil disimpan');
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal menyimpan rating');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menyimpan rating: ${e.toString()}');
    }
  }


}
