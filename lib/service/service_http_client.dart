import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  //POST
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final token = await secureStorage.read(key: 'authToken');
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Post request failed: $e');
    }
  }

  //GET
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await secureStorage.read(key: 'authToken');
    try {
      final response = await http.get(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Get request failed: $e');
    }
  }

  //PUT
  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await secureStorage.read(key: 'authToken');
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Put request failed: $e');
    }
  }

  //DELETE
  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await secureStorage.read(key: 'authToken');

    try {
      final response = await http.delete(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Delete request failed: $e');
    }
  }
}
