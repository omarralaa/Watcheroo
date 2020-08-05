import 'package:flutter/foundation.dart';
import 'package:watcherooflutter/src/models/friend.dart';

import '../services/friend_service.dart';
import '../services/profile_service.dart';
import '../models/user_profile.dart';

class Profile extends ChangeNotifier {
  UserProfile _user;

  final _profileService = ProfileService();
  final _friendService = FriendService();

  UserProfile get user => _user;

  Future<void> getProfile() async {
    try {
      _user = await _profileService.fetchProfile();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Friend getFriendById(String id) {
    print(user.friends);
    return user.friends.firstWhere((friend) => friend.id == id);
  }

  Friend getFriendByUsername(String username) {
    return user.friends.firstWhere((friend) => friend.username == username);
  }

  bool hasFriendbyUsername(String username) {
    for (var friend in _user.friends) {
      if (friend.username == username) return true;
    }

    return false;
  }

  bool hasFriendRequestbyUsername(String username) {
    for (var friend in _user.sentRequests) {
      if (friend.username == username) return true;
    }

    return false;
  }

  Future<void> updateProfile(Map<String, dynamic> updatedFields) async {
    try {
      final updatedProfile = await _profileService.updateProfile(updatedFields);
      _user = updatedProfile;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  Future<void> changeFriendRequest(
      String friendshipState, Friend friend) async {
    try {
      await _friendService.changeFriendState(friendshipState, friend.id);
      user.requests
          .removeWhere((requestFriend) => requestFriend.id == friend.id);

      if (friendshipState == 'accept') {
        user.friends.add(friend);
      }

      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
}
