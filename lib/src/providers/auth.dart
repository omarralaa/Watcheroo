import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_response.dart';
import '../services/auth_service.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  final _flutterSecureStorage = FlutterSecureStorage();

  bool get isAuth {
    return token == null ? false : true;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  String get userId => _userId;

  AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    final authResponse = await _authService.login(email, password);
    await _setData(authResponse);
  }

  Future<void> register(String email, String password, String fullName) async {
    final authResponse = await _authService.register(email, password, fullName);
    await _setData(authResponse);
  }

  Future<void> _setData(AuthResponse authResponse) async {
    _token = authResponse.token;
    _expiryDate = authResponse.expiryDate;
    _userId = authResponse.userId;

    var jsonAuth = json.encode(authResponse);
    await _flutterSecureStorage.write(key: 'jsonAuth', value: jsonAuth);
    notifyListeners();
    _autoLogout();
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }


    _authService.logout();
    FirebaseMessaging().deleteInstanceID();
    notifyListeners();

    _flutterSecureStorage.delete(key: 'jsonAuth');
  }

  Future<bool> tryAutoLogin() async {
    final authJson = await _flutterSecureStorage.read(key: 'jsonAuth');
    if (authJson == null || authJson.isEmpty) return false;

    final authResponse = AuthResponse.fromJson(json.decode(authJson));
    if (DateTime.now().isAfter(authResponse.expiryDate)) return false;

    _token = authResponse.token;
    _expiryDate = authResponse.expiryDate;
    _userId = authResponse.userId;
    notifyListeners();
    _autoLogout();
    return true;
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
