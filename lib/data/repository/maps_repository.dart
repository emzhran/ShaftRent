import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shaftrent/data/model/request/admin/maps_request_model.dart';
import 'package:shaftrent/data/model/response/admin/maps/add_maps_response.dart';
import 'package:shaftrent/data/model/response/admin/maps/delete_maps_response.dart';
import 'package:shaftrent/data/model/response/admin/maps/update_maps_response.dart';
import 'package:shaftrent/data/model/response/maps_response_model.dart';
import 'package:shaftrent/service/service_http_client.dart';

class MapsRepository {
  final ServiceHttpClient _serviceHttpClient;
  MapsRepository(this._serviceHttpClient);

  Future<Either<String, MapsResponseModel>> getMaps() async {
    try {
      final response = await _serviceHttpClient.get('maps');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final MapsResponseModel mapsResponse = MapsResponseModel.fromJson(jsonResponse);
        return Right(mapsResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memuat lokasi.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat lokasi: ${e.toString()}');
    }
  }

  Future<Either<String, GetMapById>> getMapById(String id) async {
    try {
      final response = await _serviceHttpClient.get('maps/$id');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final mapById = GetMapById.fromJson(jsonResponse);
        return Right(mapById);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Gagal memuat detail lokasi.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat detail lokasi: ${e.toString()}');
    }
  }

  Future<Either<String, AddMapsResponseModel>> addMap(MapsRequestModel request) async {
    try {
      final response = await _serviceHttpClient.post('admin/maps', request.toMap());
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final model = AddMapsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal menambahkan lokasi.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menambahkan lokasi: ${e.toString()}');
    }
  }

  Future<Either<String, UpdateMapsResponseModel>> updateMap(int mapsId, MapsRequestModel request) async {
    try {
      final response = await _serviceHttpClient.put('admin/maps/$mapsId', request.toMap());
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final model = UpdateMapsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memperbarui lokasi.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memperbarui lokasi: ${e.toString()}');
    }
  }

  Future<Either<String, DeleteMapsResponseModel>> deleteMap(int mapId) async {
    try {
      final response = await _serviceHttpClient.delete('admin/maps/$mapId');
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final model = DeleteMapsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal menghapus lokasi.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menghapus lokasi: ${e.toString()}');
    }
  }
}
