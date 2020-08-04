import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/friend.dart';
import '../models/party.dart';
import '../providers/profile.dart';
import '../providers/ready.dart';
import '../sockets/watchSocket.dart';
import '../widgets/ready_background.dart';

class ReadyScreen extends StatelessWidget {
  static const String routeName = '/ready';

  void _initReady(BuildContext context) {
    final Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    final Party party = map['party'];
    final Friend friend = map['friend'];
    final String roomId = map['roomId'];

    Provider.of<Ready>(context, listen: false)
        .setInitData(party, friend, roomId);
  }

  void _initSocket(BuildContext context) {
    final roomId = Provider.of<Ready>(context, listen: false).roomId;
    final profileId = Provider.of<Profile>(context, listen: false).user.id;
    WatchSocket().setup(roomId, profileId);
  }

  @override
  Widget build(BuildContext context) {
    _initReady(context);
    _initSocket(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ReadyBackground(),
          _buildMovieLabel(context),
          _buildReadyText(),
          _buildReadyButton(context),
        ],
      ),
    );
  }

  Widget _buildMovieLabel(BuildContext context) {
    final movieName =
        Provider.of<Ready>(context, listen: false).party.movieName;
    return Positioned(
      right: 45,
      top: 170,
      child: Container(
        width: 250,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            movieName,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadyText() {
    return Positioned(
      right: 68,
      top: 250,
      child: Consumer<Ready>(
        builder: (context, ready, child) {
          final firstName = ready.friend.firstName;
          return !ready.isFriendReady
              ? Text(
                  'Waiting for $firstName to be ready',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Text(
                  '$firstName is ready now !',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
        },
      ),
    );
  }

  Widget _buildReadyButton(BuildContext context) {
    return Positioned(
      right: 45,
      bottom: 170,
      child: Consumer<Ready>(builder: (context, ready, child) {
        return FlatButton(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: ready.isUserReady
                ? Colors.amber
                : Theme.of(context).primaryColor,
            child: Text(
              ready.isUserReady ? 'CANCEL' : 'READY',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: ready.ready,
        );
      }),
    );
  }
}
