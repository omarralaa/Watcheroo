import 'package:flutter/foundation.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/models/party.dart';
import 'package:watcherooflutter/src/sockets/watchSocket.dart';

class Ready with ChangeNotifier {
  Party _party;
  Friend _friend;
  String _roomId;
  bool _isUserReady = false;
  bool _isFriendReady = false;

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
    final watchSocket = WatchSocket();
    watchSocket.emitReady();
    _isUserReady = !isUserReady;
    notifyListeners();
  }
}
