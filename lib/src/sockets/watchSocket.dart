import 'package:socket_io_client/socket_io_client.dart' as IO;

class WatchSocket {
  static IO.Socket _socket;
    static final WatchSocket _watchSocketSingleton = WatchSocket._internal();

  factory WatchSocket() {
    return _watchSocketSingleton;
  }

  Function _startPartyCallback;
  Function _updatePartyCallBack;

  WatchSocket._internal();

  IO.Socket setup(String roomId, String profileId) {
    if (_socket == null) {
      _connectSocket(roomId, profileId);
    }

    return _socket;
  }

  // SETTERS
  void setStartPartyCallback(callback) {
    _startPartyCallback = callback;
  }

    void setUpdatePartyCallback(callback) {
    _updatePartyCallBack = callback;
  }

  void _connectSocket(String roomId, String profileId) {
    _socket = IO.io('http://10.0.2.2:3000/watch', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      //'extraHeaders': {'foo': 'bar'},
      'query': {'roomId': roomId, 'profileId': profileId},
    });

    _socket.on('connect', _socketStatus);

    _socket.on('updateReady', _updateReady);

    _socket.on('startParty', _startParty);

    //connect socket
    _socket.connect();
  }

  void emitReady() {
    _socket.emit('ready', '');
  }

  _socketStatus(dynamic data) {
    print('Conncted to the server');
  }

  _updateReady(dynamic data) {
    _updatePartyCallBack(data);
  }

  _startParty(dynamic data) {
    _startPartyCallback();
  }
}
