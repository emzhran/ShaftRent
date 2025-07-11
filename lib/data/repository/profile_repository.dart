import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shaftrent/data/model/request/admin/profile_customer_request_model.dart';
import 'package:shaftrent/data/model/request/customer/profile_request_model.dart';
import 'package:shaftrent/data/model/response/admin/profile_customer_response_model.dart';
import 'package:shaftrent/data/model/response/customer/profile_response_model.dart';
import 'package:shaftrent/service/service_http_client.dart';

class ProfileRepository {
  final ServiceHttpClient _serviceHttpClient;
  ProfileRepository(this._serviceHttpClient);

  Future<Either<String, GetProfileById>> getProfile() async {
    try {
      final response = await _serviceHttpClient.get('customer/profile');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final model = GetProfileById.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat data profil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat profil: ${e.toString()}');
    }
  }

  Future<Either<String, String>> addProfile(ProfileRequestModel request) async {
    try {
      final response = await _serviceHttpClient.post(
        'customer/upload-identitas',
        request.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        return Right(jsonResponse['message'] ?? 'Berhasil menyimpan profil.');
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal menyimpan profil.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat menyimpan profil: ${e.toString()}');
    }
  }

  Future<Either<String, ProfileCustomerResponseModel>> getAllCustomers() async {
    try {
      final response = await _serviceHttpClient.get('admin/customers');
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final model = ProfileCustomerResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal memuat data customer.');
      }
    } catch (e) {
      return Left('Terjadi kesalahan saat memuat data customer: ${e.toString()}');
    }
  }


  Future<Either<String, ProfileCustomerResponseModel>> updateStatusAccount(
      StatusAccountRequestModel request,    
      ) async {
        try {
          final response = await _serviceHttpClient.put(
            'admin/customers/${request.customerId}/status',request.toMap(),
          );
          final jsonResponse = json.decode(response.body);
          if (response.statusCode == 200) {
            final model = ProfileCustomerResponseModel.fromJson(jsonResponse);
            return Right(model);
          } else {
            return Left(jsonResponse['message'] ?? 'Gagal memperbarui status akun');
          }
        } catch (e) {
          return Left('Terjadi kesalahan: ${e.toString()}');
        }
      }

    Future<Either<String, ProfileCustomer>> getCustomerDetail(int id) async {
      try {
        final response = await _serviceHttpClient.get('admin/customers/$id');
        final jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          final profile = ProfileCustomer.fromJson(jsonResponse['data']);
          return Right(profile);
        } else {
          return Left(jsonResponse['message'] ?? 'Gagal memuat data customer.');
        }
      } catch (e) {
        return Left('Terjadi kesalahan: ${e.toString()}');
      }
    }
}
