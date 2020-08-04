import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:watcherooflutter/src/models/auth_response.dart';

class ServiceUtils {
  final _secureStorage = FlutterSecureStorage();

  Future<String> get token async {
    try {
      final authJson = await _secureStorage.read(key: 'jsonAuth');

      if (authJson == null) return null;

      final AuthResponse authResponse =
          AuthResponse.fromJson(json.decode(authJson));

      return authResponse.token;
    } catch (error) {
      throw error;
    }
  }

  Future<String> get fcmToken async {
    try {
      final token = await FirebaseMessaging().getToken();
      return token;
    } catch (error) {
      throw error;
    }
  }
}
