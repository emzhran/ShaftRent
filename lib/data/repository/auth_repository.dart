import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shaftrent/data/model/request/auth/login_request_model.dart';
import 'package:shaftrent/data/model/request/auth/register_request_model.dart';
import 'package:shaftrent/data/model/response/auth_response_model.dart';
import 'package:shaftrent/service/service_http_client.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'login',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final loginResponse = AuthResponseModel.fromMap(jsonResponse);
        await secureStorage.write(
          key: 'authToken',
          value: loginResponse.user!.token,
        );
        await secureStorage.write(
          key: 'userRole',
          value: loginResponse.user!.role!,
        );
        return right(loginResponse);
      } else {
        return left(jsonResponse['message'] ?? 'Login gagal.');
      }
    } catch (e) {
      return left('Terjadi kesalahan saat login: $e');
    }
  }

  Future<Either<String, String>> register(
    RegisterRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'register',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      final registerResponse = jsonResponse['message'];
      if (response.statusCode == 201) {
        return right(registerResponse);
      } else {
        return left(jsonResponse['message'] ?? 'Registrasi gagal.');
      }
    } catch (e) {
      return left('Terjadi kesalahan saat register: $e');
    }
  }
}
