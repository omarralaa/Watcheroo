import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/screens/movie_screen.dart';

import '../models/friend.dart';
import '../models/party.dart';
import '../providers/profile.dart';
import '../sockets/watchSocket.dart';
import '../widgets/ready_background.dart';

class ReadyScreen extends StatefulWidget {
  static const String routeName = '/ready';

  @override
  _ReadyScreenState createState() => _ReadyScreenState();
}

class _ReadyScreenState extends State<ReadyScreen> {
  final _watchSocket = WatchSocket();

  Friend _friend;
  Party _party;
  String _roomId;
  File _file;

  bool _isFriendReady = false;
  bool _isUserReady = false;

  void _initReady() {
    final Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    _friend = map['friend'];
    _party = map['party'];
    _roomId = map['roomId'];
    _file = map['file'];

    final profileId = Provider.of<Profile>(context, listen: false).user.id;

    WatchSocket().setup(_roomId, profileId);
    _watchSocket.setStartPartyCallback(_startParty);
    _watchSocket.setUpdatePartyCallback(_updateFriendReady);
  }

  @override
  Widget build(BuildContext context) {
    _initReady();
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Are you sure you want to quit ?'),
            content: Text('Closing this page will cause the party to be canceled'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  _watchSocket.closeConnection();
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(false)),
            ],
          );
        },
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ReadyBackground(_isUserReady),
            _buildLabels(context),
            _buildReadyButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLabels(BuildContext context) {
    return Positioned(
      right: 45,
      top: 170,
      child: Column(
        children: <Widget>[
          Container(
            width: 250,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Text(
                _party.movieName,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: !_isFriendReady
                ? Text(
                    'Waiting for ${_friend.firstName} to be ready',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Text(
                    '${_friend.firstName} is ready now !',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadyButton(BuildContext context) {
    return Positioned(
      right: 45,
      bottom: 170,
      child: FlatButton(
        child: CircleAvatar(
          radius: 80,
          backgroundColor:
              _isUserReady ? Colors.amber : Theme.of(context).primaryColor,
          child: Text(
            _isUserReady ? 'CANCEL' : 'READY',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () {
          _watchSocket.emitReady();

          setState(() {
            _isUserReady = !_isUserReady;
          });
        },
      ),
    );
  }

  void _startParty() {
    Navigator.of(context).pushReplacementNamed(
      MovieScreen.routeName,
      arguments: {'file': _file, 'friend': _friend},
    );
  }

  void _updateFriendReady(int numOfReady) {
    setState(() {
      _isFriendReady = numOfReady == 0 ? false : _isUserReady ? false : true;
    });
  }
}
