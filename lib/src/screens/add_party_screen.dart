import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/party.dart';
import '../providers/profile.dart';
import './ready_screen.dart';
import '../utils/utils.dart';
import '../widgets/file_picker.dart';
import '../models/friend.dart';
import '../widgets/add_party_background.dart';
import '../widgets/friend_picker.dart';
import '../widgets/movie_picker.dart';

class AddPartyScreen extends StatefulWidget with Utils {
  static const routeName = '/add-party';

  @override
  _AddPartyScreenState createState() => _AddPartyScreenState();
}

class _AddPartyScreenState extends State<AddPartyScreen> {
  int _pageNumber = 1;
  String _movieName;
  Friend _friend;
  File _file;

  void submitMovie(String movieName) {
    this._movieName = movieName;
    FocusScope.of(context).unfocus();
    setState(() {
      _pageNumber = 2;
    });
  }

  void submitFriend(Friend friend) {
    this._friend = friend;
    setState(() {
      _pageNumber = 3;
    });
  }

  void submitFile(File file) async {
    this._file = file;
    await _submitNewParty();
  }

  @override
  void didChangeDependencies() {
    _friend = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AddPartyBackground(_pageNumber),
          if (_pageNumber != 1) _buildBackButton(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: fadeWidgets(),
          )
        ],
      ),
    );
  }

  Widget fadeWidgets() {
    return AnimatedCrossFade(
      firstChild:
          _pageNumber == 3 ? FilePicker(submitFile) : MoviePicker(submitMovie),
      secondChild:
          FriendPicker(submitFriend, _friend == null ? null : _friend.username),
      crossFadeState: _pageNumber != 2
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      left: 16,
      top: 40,
      child: InkWell(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
        onTap: () {
          setState(() {
            _pageNumber--;
          });
        },
      ),
    );
  }

  Future<void> _submitNewParty() async {
    try {
      final party = await Provider.of<Party>(context, listen: false)
          .createParty(_friend.id, _movieName);
      final userId = Provider.of<Profile>(context, listen: false).user.id;
      Navigator.of(context).pushReplacementNamed(
        ReadyScreen.routeName,
        arguments: {
          'party': party,
          'file': _file,
          'friend': _friend,
          'roomId': userId,
        },
      );
    } catch (err) {
      _showSnackBarError();
      throw (err);
    }
  }

  void _showSnackBarError() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Could not create a party!'),
      duration: Duration(milliseconds: 1500),
    ));
  }
}
