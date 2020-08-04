import 'dart:convert';

import 'package:http/http.dart' as http;

import './servicesUtils/service_utils.dart';
import '../models/auth_response.dart';
import '../models/http_exception.dart';

class AuthService with ServiceUtils {
  final String url = 'http://10.0.2.2:3000/api/v1/auth';

  Future<AuthResponse> login(String email, String password) async {
    final loginUrl = url + '/login';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final _fcmToken = await fcmToken;

      final reqBody = json.encode({
        'email': email,
        'password': password,
        'fcmToken': _fcmToken,
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
    final registerUrl = url + '/signup';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final names = fullName.split(' ');

    try {
      final _fcmToken = await fcmToken;

      final reqBody = json.encode({
        'email': email,
        'password': password,
        'firstName': names[0],
        'lastName': names[1],
        'fcmToken': _fcmToken,
      });

      final response = await http
          .post(registerUrl, body: reqBody, headers: requestHeaders)
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

    Future<void> logout() async {
    final subUrl = url + '/logout';
    try {
      final _token = await token;
      final response = await http.post(
        subUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);
        
    } catch (error) {
      throw error;
    }
  }
}
