import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:watcherooflutter/src/utils/navigation_service.dart';
import 'package:watcherooflutter/src/utils/service_locator.dart';

class WatchSocket {
  static IO.Socket _socket;
  static final WatchSocket _watchSocketSingleton = WatchSocket._internal();

  factory WatchSocket() {
    return _watchSocketSingleton;
  }

  Function _startPartyCallback;
  Function _updatePartyCallBack;
  Function _pausePartyCallback;
  Function _resumePartyCallback;

  WatchSocket._internal();

  IO.Socket setup(String roomId, String profileId) {
    if (_socket == null || _socket.disconnected) {
      _connectSocket(roomId, profileId);
    }

    return _socket;
  }

  void closeConnection() {
    _socket.disconnect();
  }

  // SETTERS
  void setStartPartyCallback(callback) {
    _startPartyCallback = callback;
  }

  void setUpdatePartyCallback(callback) {
    _updatePartyCallBack = callback;
  }

  void setPausePartyCallback(callback) {
    _pausePartyCallback = callback;
  }

  void setResumePartyCallback(callback) {
    _resumePartyCallback = callback;
  }

  void _connectSocket(String roomId, String profileId) {
    _socket = IO.io('http://10.0.2.2:3000/watch', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'query': {'roomId': roomId, 'profileId': profileId},
    });

    _socket.on('connect', _socketStatus);

    _socket.on('updateReady', _updateReady);

    _socket.on('startParty', _startParty);

    _socket.on('pause', _pauseParty);

    _socket.on('resume', _resumeParty);

    _socket.on('roomDisconnected', _endParty);

    //connect socket
    _socket.connect();
  }

  void emitReady() {
    _socket.emit('ready', '');
  }

  void emitPause() {
    _socket.emit('requestPause', '');
  }

  void emitReadyResume() {
    _socket.emit('readyResume', '');
  }

  void _socketStatus(dynamic data) {
    print('Conncted to the server');
  }

  _endParty(dynamic data) {
    closeConnection();
    locator<NavigationService>().popToHome();
    locator<NavigationService>().showDisconnectionDialog();
  }

  _updateReady(dynamic data) {
    _updatePartyCallBack(data);
  }

  _startParty(dynamic data) {
    _startPartyCallback();
  }

  _pauseParty(dynamic data) {
    _pausePartyCallback();
  }

  _resumeParty(dynamic data) {
    _resumePartyCallback();
  }
}
