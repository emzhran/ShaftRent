import 'dart:convert';

import 'package:shaft_rent_app/data/model/request/admin/car_request_model.dart';
import 'package:shaft_rent_app/data/model/response/get_all_car_response_model.dart';
import 'package:shaft_rent_app/service/service_http_client.dart';
import 'package:dartz/dartz.dart';

class CarRepository {
  final ServiceHttpClient _serviceHttpClient;

  CarRepository(this._serviceHttpClient);

  Future<Either<String, GetAllCarModel>> getCars() async {
    try {
      final response = await _serviceHttpClient.get('cars');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final GetAllCarModel allCarsResponse =
            GetAllCarModel.fromJson(jsonResponse);
        return Right(allCarsResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memuat daftar mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat mobil: ${e.toString()}');
    }
  }

  Future<Either<String, GetCarById>> getCarById(int carId) async {
    try {
      final response = await _serviceHttpClient.get('cars/$carId');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final GetCarById carResponseById = GetCarById.fromJson(jsonResponse);
        return Right(carResponseById);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memuat detail mobil.');
      }
    } catch (e) {
      return Left(
        'Terjadi kesalahan saat memuat detail mobil: ${e.toString()}',
      );
    }
  }

  Future<Either<String, void>> addCar(CarRequestModel request) async {
    try {
      final response = await _serviceHttpClient.post('admin/cars', request.toMap());

      if (response.statusCode == 201) {
        return Right(null);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal menambahkan mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menambahkan mobil: ${e.toString()}');
    }
  }

  Future<Either<String, void>> updateCar(
    int carId,
    CarRequestModel request,
  ) async {
    try {
      final response = await _serviceHttpClient.put('admin/cars/$carId', request.toMap());

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memperbarui mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memperbarui mobil: ${e.toString()}');
    }
  }

  Future<Either<String, void>> deleteCar(int carId) async {
    try {
      final response = await _serviceHttpClient.delete('admin/cars/$carId');

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal menghapus mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menghapus mobil: ${e.toString()}');
    }
  }
}