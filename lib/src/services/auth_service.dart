import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_response.dart';
import '../models/http_exception.dart';

class AuthService {
  final String url = 'http://10.0.2.2:3000/api/v1/auth';

  Future<AuthResponse> login(String email, String password) async {
    final loginUrl = url + '/login';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final reqBody = json.encode({
        'email': email,
        'password': password,
      });

      final response = await http
          .post(loginUrl, body: reqBody, headers: requestHeaders)
          .timeout(Duration(seconds: 5),
              onTimeout: () => throw HttpException('Server Timed out'));
      final responseData = json.decode(response.body);

      if (responseData['error'] != null)
        throw HttpException(responseData['error']);

      return AuthResponse.fromJson(responseData['data']);
    } catch (error) {
      throw (error);
    }
  }

  Future<AuthResponse> register(
      String email, String password, String fullName) async {
    final loginUrl = url + '/signup';
    print(loginUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final names = fullName.split(' ');

    try {
      final reqBody = json.encode({
        'email': email,
        'password': password,
        'firstName': names[0],
        'lastName': names[1],
      });

      final response =
          await http.post(loginUrl, body: reqBody, headers: requestHeaders);
      final responseData = json.decode(response.body);

      if (responseData['error'] != null)
        throw HttpException(responseData['error']);

      return AuthResponse.fromJson(responseData);
    } catch (error) {
      throw (error);
    }
  }
}
