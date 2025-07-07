import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shaftrent/data/model/request/admin/car_request_model.dart';
import 'package:shaftrent/data/model/response/admin/car/add_car_response_model.dart';
import 'package:shaftrent/data/model/response/admin/car/delete_car_response_model.dart';
import 'package:shaftrent/data/model/response/admin/car/update_car_response_model.dart';
import 'package:shaftrent/data/model/response/car_response_model.dart';
import 'package:shaftrent/service/service_http_client.dart';

class CarRepository {
  final ServiceHttpClient _serviceHttpClient;

  CarRepository(this._serviceHttpClient);

  Future<Either<String, CarResponseModel>> getCars() async {
    try {
      final response = await _serviceHttpClient.get('cars');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final CarResponseModel allCarsResponse =
            CarResponseModel.fromJson(jsonResponse);
        return Right(allCarsResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memuat daftar mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat mobil: ${e.toString()}');
    }
  }

  Future<Either<String, GetCarById>> getCarById(String carId) async {
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

  Future<Either<String, AddCarResponseModel>> addCar(CarRequestModel request) async {
    try {
      final response = await _serviceHttpClient.post('admin/cars', request.toMap());
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final AddCarResponseModel addCarModel = AddCarResponseModel.fromJson(jsonResponse);
        return Right(addCarModel);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal menambahkan mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menambahkan mobil: ${e.toString()}');
    }
  }

  Future<Either<String, UpdateCarResponseModel>> updateCar(
    int carId,
    CarRequestModel request,
  ) async {
    try {
      final response = await _serviceHttpClient.put('admin/cars/$carId', request.toMap());
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final UpdateCarResponseModel updateCarModel = UpdateCarResponseModel.fromJson(jsonResponse);
        return Right(updateCarModel);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memperbarui mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memperbarui mobil: ${e.toString()}');
    }
  }

  Future<Either<String, DeleteCarResponseModel>> deleteCar(int carId) async {
    try {
      final response = await _serviceHttpClient.delete('admin/cars/$carId');
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final DeleteCarResponseModel deleteCarModel = DeleteCarResponseModel.fromJson(jsonResponse);
        return Right(deleteCarModel);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal menghapus mobil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menghapus mobil: ${e.toString()}');
    }
  }
}
