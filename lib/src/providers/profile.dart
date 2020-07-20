import 'package:flutter/foundation.dart';

import '../services/profile_service.dart';
import '../models/user_profile.dart';

class Profile extends ChangeNotifier {
  UserProfile _user;

  UserProfile get user => _user;

  Future<void> getProfile() async {
    try {
      final profileService = ProfileService();
      _user = await profileService.fetchProfile();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  bool hasFriendbyUsername(String username) {
    for (var friend in _user.friends) {
      if (friend.username == username) return true;
    }

    return false;
  }

    Future<void> updateProfile(updatedFields) async {
    try {
      final profileService = ProfileService();
      final updatedProfile = await profileService.updateProfile(updatedFields);
      _user = updatedProfile;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
}
