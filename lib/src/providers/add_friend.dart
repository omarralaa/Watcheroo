import 'package:flutter/cupertino.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/services/friend_service.dart';

class AddFriend with ChangeNotifier {
  final _friendService = FriendService();

  bool _isLoadingFriendRequest = false;
  Friend _friend;

  // GETTERS
  Friend get friend => _friend;
  bool get isLoadingFriendRequest => _isLoadingFriendRequest;

  Future<void> searchFriendByUsername(String username) async {
    try {
      _friend = await _friendService.searchFriendByUsername(username);
    } catch (err) {
      _friend = null;
      throw (err);
    } finally {
      notifyListeners();
    }
  }

  Future<bool> sendFriendRequest(String profileId) async {
    try {
      _isLoadingFriendRequest = true;
      notifyListeners();
      return await _friendService.sendFriendRequest(profileId);
    } catch (err) {
      _friend = null;
      throw (err);
    } finally {
      _isLoadingFriendRequest = false;
      notifyListeners();
    }
  }
}
