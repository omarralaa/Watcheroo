import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/sockets/watchSocket.dart';

class MovieScreen extends StatefulWidget {
  static const routeName = '/movie';

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  VideoPlayerController _controller;
  final _watchSocket = WatchSocket();

  bool _isPaused = false;

  File _file;
  Friend _friend;
  bool _isUserReady = false;
  bool _isFriendReady = false;

  _setInitData() {
    final Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    _file = map['file'];
    _friend = map['friend'];

    _watchSocket.setUpdatePartyCallback(_updateFriendReady);
    _watchSocket.setPausePartyCallback(_pause);
    _watchSocket.setResumePartyCallback(_resume);
  }

  _playVideo() {
    _controller = VideoPlayerController.file(_file)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.play();
  }

  @override
  void didChangeDependencies() {
    _setInitData();
    _playVideo();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Are you sure you want to quit ?'),
            content:
                Text('Closing this page will cause the party to be canceled'),
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
        backgroundColor: Colors.black,
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () {
            _watchSocket.emitPause();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        if (_isPaused) _buildPauseDialog(),
        Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ],
    );
  }

  Widget _buildPauseDialog() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 50,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 50),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _isFriendReady
                  ? '${_friend.firstName} is ready'
                  : 'Waiting for ${_friend.firstName} to be ready',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _isFriendReady ? Colors.pink : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text(_isUserReady ? 'UNREADY' : 'READY'),
              onPressed: () {
                _watchSocket.emitReadyResume();
                setState(() {
                  _isUserReady = !_isUserReady;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateFriendReady(int numOfReady) {
    setState(() {
      _isFriendReady = numOfReady == 0 ? false : _isUserReady ? false : true;
    });
  }

  void _resume() {
    setState(() {
      _isPaused = false;
      _isUserReady = false;
      _isFriendReady = false;
    });
    _controller.play();
  }

  void _pause() {
    setState(() {
      _isPaused = true;
    });
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
