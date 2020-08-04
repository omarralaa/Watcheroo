import 'package:flutter/material.dart';

import '../models/friend.dart';
import '../models/party.dart';
import '../screens/movie_screen.dart';
import '../sockets/watchSocket.dart';
import '../utils/navigation_service.dart';
import '../utils/service_locator.dart';

class Ready with ChangeNotifier {
  Party _party;
  Friend _friend;
  String _roomId;
  bool _isUserReady = false;
  bool _isFriendReady = false;
  final _watchSocket = WatchSocket();

  // GETTERS
  Party get party => _party;
  Friend get friend => _friend;
  String get roomId => _roomId;
  bool get isUserReady => _isUserReady;
  bool get isFriendReady => _isFriendReady;

  // SETTERS
  void setInitData(Party party, Friend friend, String roomId) {
    _setFriend(friend);
    _setParty(party);
    _setRoomId(roomId);
    _watchSocket.setStartPartyCallback(_startParty);
    _watchSocket.setUpdatePartyCallback(_updateFriendReady);
  }

  void _setParty(Party party) {
    _party = party;
  }

  void _setFriend(Friend friend) {
    _friend = friend;
  }

  void _setRoomId(String roomId) {
    _roomId = roomId;
  }

  void ready() {
    _watchSocket.emitReady();
    _isUserReady = !isUserReady;
    notifyListeners();
  }

  void _startParty() {
    locator<NavigationService>().navigateTo(MovieScreen.routeName, {});
  }

  void _updateFriendReady(int numberOfReady) {
    _isFriendReady = numberOfReady == 0 ? false : _isUserReady ? false : true;
    notifyListeners();
  }
}
