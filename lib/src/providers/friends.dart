
import 'package:flutter/cupertino.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/services/friend_service.dart';
import 'package:watcherooflutter/src/utils/service_locator.dart';

class Friends with ChangeNotifier {

  final _friendService = locator<FriendService>();

  Future<Friend> searchFriendByUsername(String username) async {
    try {
      final friend = await _friendService.searchFriendByUsername(username);
      return friend;
    } catch (err) {
      throw (err);
    }
  }

  Future<bool> sendFriendRequest(String profileId) async {
    try {
      notifyListeners();
      return await _friendService.sendFriendRequest(profileId);
    } catch (err) {
      throw (err);
    } finally {
      notifyListeners();
    }
  }
}