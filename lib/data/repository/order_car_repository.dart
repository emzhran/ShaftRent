import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shaftrent/data/model/request/customer/order_car_request_model.dart';
import 'package:shaftrent/data/model/response/customer/order_car_response_model.dart';
import 'package:shaftrent/service/service_http_client.dart';

class CarOrderRepository {
  final ServiceHttpClient _serviceHttpClient;

  CarOrderRepository(this._serviceHttpClient);

  Future<Either<String, OrderCarResponseModel>> orderCar(OrderCarRequestModel request) async {
    try {
      final response = await _serviceHttpClient.post('customer/orders', request.toMap());
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        final model = OrderCarResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal melakukan pemesanan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memesan mobil: ${e.toString()}');
    }
  }

  Future<Either<String, List<CarOrder>>> getMyOrders() async {
    try {
      final response = await _serviceHttpClient.get('customer/orders');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<CarOrder> carOrders = List<CarOrder>.from(
          (jsonResponse['orders'] as List).map((x) => CarOrder.fromJson(x)),
        );
        return Right(carOrders);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat daftar pesanan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat daftar pesanan: ${e.toString()}');
    }
  }

  Future<Either<String, CarOrder>> getMyOrderDetail(int orderId) async {
    try {
      final response = await _serviceHttpClient.get('customer/orders/$orderId');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final CarOrder carOrder = CarOrder.fromJson(jsonResponse['order']);
        return Right(carOrder);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat detail pesanan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat detail pesanan: ${e.toString()}');
    }
  }

  Future<Either<String, String>> updateMyOrder({
    required int orderId,
    required Map<String, dynamic> updateData,
  }) async {
    try {
      final response = await _serviceHttpClient.put(
        'customer/orders/$orderId',
        updateData,
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return Right(jsonResponse['message'] ?? 'Pesanan berhasil diperbarui');
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memperbarui pesanan');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat update pesanan: ${e.toString()}');
    }
  }

  Future<Either<String, List<CarOrder>>> getAllOrdersForAdmin() async {
    try {
      final response = await _serviceHttpClient.get('admin/orders');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<CarOrder> carOrders = List<CarOrder>.from(
          (jsonResponse['orders'] as List).map((x) => CarOrder.fromJson(x)),
        );
        return Right(carOrders);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat semua pesanan.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat semua pesanan: ${e.toString()}');
    }
  }

  Future<Either<String, String>> updateOrderStatus({
    required int orderId,
    required String statusUpdated,
  }) async {
    try {
      final response = await _serviceHttpClient.put(
        'admin/orders/$orderId/status',
        {
          'status_pemesanan': statusUpdated,
        },
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return Right(jsonResponse['message'] ?? 'Status berhasil diperbarui');
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memperbarui status');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat update status: ${e.toString()}');
    }
  }
}
