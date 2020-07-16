import 'package:flutter/foundation.dart';

import '../services/profile_service.dart';
import '../models/profile.dart';

class Profile extends ChangeNotifier {
  UserProfile _user;

  UserProfile get user => _user;

  Future<void> getProfile() async {
    try {
      ProfileService userService = ProfileService();
      _user = await userService.fetchUser();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
