import 'dart:async';

import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  Future<void> login(String email, String password) async {
    print(email);
    print(password);
  }

  Future<void> register(String email, String password, String fullName) async {
    print(email);
    print(password);
    print(fullName);
  }
}
