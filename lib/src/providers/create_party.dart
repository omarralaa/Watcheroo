import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class CreateParty with ChangeNotifier {
  File _file;
  String _movieName;
  Duration _movieDuration;
  String _selectedFriend;

  // GETTERS
  File get file => _file ?? null;
  String get movieName => _movieName;
  String get url =>
      _file == null ? 'Your file URL will appear here!' : _file.uri.toString();

  String get selectedFriend => _selectedFriend;

  String get movieDuration {
    if (_movieDuration == null) return '00:00:00';
    String sDuration =
        '${_movieDuration.inHours}:${_movieDuration.inMinutes.remainder(60)}:${(_movieDuration.inSeconds.remainder(60))}';
    return sDuration;
  }

  bool get isValidSubmit {
    if (_file != null &&
        _movieName != null &&
        _movieName.isNotEmpty &&
        _selectedFriend != null) {
      return true;
    }

    return false;
  }

  // SETTERS
  void setMetaData(File file) async {
    _file = file;
    var controller = VideoPlayerController.file(file);
    await controller.initialize();
    _movieDuration = controller.value.duration;
    controller.dispose();
    notifyListeners();
  }

  void setMovieName(String movie) {
    _movieName = movie;
  }

  void selectFriend(String friend) {
    _selectedFriend = friend;
    notifyListeners();
  }
}
