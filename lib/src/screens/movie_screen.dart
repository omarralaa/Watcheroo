import 'dart:io';
import 'dart:async';

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

  Timer _timer;
  int _timerStart = 4;
  bool _isTimerRunning = false;

  _setInitData() {
    final Map<String, dynamic> map = ModalRoute.of(context).settings.arguments;
    _file = map['file'];
    _friend = map['friend'];

    _watchSocket.setUpdatePartyCallback(_updateFriendReady);
    _watchSocket.setPausePartyCallback(_pause);
    _watchSocket.setResumePartyCallback(_startTimer);
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
        floatingActionButton: !_isPaused
            ? FloatingActionButton(
                child: Icon(Icons.pause),
                onPressed: () {
                  _watchSocket.emitPause();
                },
              )
            : SizedBox(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.center,
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
      bottom: 0,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFF750f31),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 50),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: _isTimerRunning && _timerStart < 4
            ? Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    '$_timerStart',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Text(
                    _isFriendReady
                        ? '${_friend.firstName} is ready!'
                        : '${_friend.firstName} is not ready!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.white),
                      child: Text(
                        _isUserReady ? 'UNREADY' : 'READY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: _isTimerRunning
                          ? null
                          : () {
                              _watchSocket.emitReadyResume();
                              setState(() {
                                _isUserReady = !_isUserReady;
                              });
                            },
                    ),
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

  void _startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerStart == 1) {
          _timer.cancel();
          _timerStart = 4;
          _isTimerRunning = false;
          _resume();
        } else {
          _timerStart--;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }
}
