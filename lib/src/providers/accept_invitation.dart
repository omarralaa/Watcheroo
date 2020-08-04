import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:watcherooflutter/src/screens/ready_screen.dart';

import '../services/party_service.dart';
import '../models/friend.dart';
import '../models/party.dart';

class AcceptInvitation with ChangeNotifier {
  File _file;
  String _roomId;
  Duration _movieDuration;
  Party _party;
  Friend _friend;

  // GETTERS
  Friend get friend => _friend;
  Party get party => _party;
  File get file => _file;
  String get movieDuration {
    if (_movieDuration == null) return '00:00:00';
    String sDuration =
        '${_movieDuration.inHours}:${_movieDuration.inMinutes.remainder(60)}:${(_movieDuration.inSeconds.remainder(60))}';
    return sDuration;
  }
  bool get isValidAccept {
    return _file != null;
  }

  String get url =>
      _file == null ? 'Your file URL will appear here!' : _file.uri.toString();

  // SETTERS
  Future<void> setInitData(Friend friend, String partyId, String roomId) async {
    _friend = friend;
    _roomId = roomId;
    await _fetchParty(partyId);
  }

  void setVideoData(File file) async {
    _file = file;
    var controller = VideoPlayerController.file(file);
    await controller.initialize();
    _movieDuration = controller.value.duration;
    controller.dispose();
    notifyListeners();
  }

  Future<void> selectFile() async {
    try {
      File videoFile = await FilePicker.getFile(type: FileType.video);
      _file = videoFile;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
  

  Future<void> _fetchParty(String partyId) async {
    try {
      final fetchedParty = await PartyService().getParty(partyId);
      _party = fetchedParty;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  void acceptParty(context) {
    //TODO: CHANGE PARTY STATE
    Navigator.of(context).pushReplacementNamed(
        ReadyScreen.routeName,
        arguments: {
          'party': party,
          'fileName': file,
          'friend': friend,
          'roomId': _roomId
        },
      );
  }
}
