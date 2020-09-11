import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/models/party.dart';
import 'package:watcherooflutter/src/providers/party.dart' as PartyProvider;
import 'package:watcherooflutter/src/providers/profile.dart';
import 'package:watcherooflutter/src/screens/ready_screen.dart';

class ReviewInvitationScreen extends StatefulWidget {
  static const String routeName = '/review-invitation';

  @override
  _ReviewInvitationScreenState createState() => _ReviewInvitationScreenState();
}

class _ReviewInvitationScreenState extends State<ReviewInvitationScreen> {
  Friend _friend;
  Party _party;
  String _roomId;
  File _file;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _setData() async {
    Map data = ModalRoute.of(context).settings.arguments;
    final profile = Provider.of<Profile>(context, listen: false);

    //final String friendId = data['friendId'];
    final String roomId = data['roomId'];
    final String partyId = data['partyId'];

    _friend = profile.getFriendById(roomId);
    _roomId = roomId;

    final party = await Provider.of<PartyProvider.Party>(context, listen: false)
        .getParty(partyId);

    _party = party;
  }

  @override
  void didChangeDependencies() {
    _setData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildGradientContainer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: 75),
              _buildSelectFile(),
              SizedBox(height: 40),
              _buildButtonsRow(),
              SizedBox(height: 20),
              Image.asset('assets/images/watch_together.png')
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGradientContainer() {
    return Positioned(
      left: -220,
      top: 170,
      child: Transform.rotate(
        angle: pi / 4,
        child: Container(
          height: 200,
          width: 600,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.withOpacity(.41),
                Colors.white.withOpacity(0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 38,
                color: Color(0xFF2F2E41),
              ),
              children: <TextSpan>[
                TextSpan(text: 'Watch '),
                TextSpan(
                  text: 'Interstellar\n',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                TextSpan(text: 'together'),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Image.asset('assets/images/upper_line.png'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${_friend.fullName} invited to watch together',
            style: TextStyle(fontSize: 17, color: Color(0xFF707070)),
          ),
        ),
        Image.asset('assets/images/lower_line.png'),
      ],
    );
  }

  Widget _buildSelectFile() {
    return Column(
      children: <Widget>[
        Text(
          'Select a file to get started',
          style: TextStyle(
              fontSize: 22, color: Color(0xFF2F2E41).withOpacity(0.78)),
        ),
        SizedBox(height: 10),
        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFFE91E63).withOpacity(.22),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                  child: FittedBox(
                    child: Text(
                      _file == null
                          ? 'Please select a file'
                          : _file.uri.toString(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                child: Image.asset('assets/images/folder_icon.png'),
                onTap: _selectFile,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildButtonsRow() {
    return Container(
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: double.infinity,
            width: 144,
            child: RaisedButton(
              child: Text('Accept',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: acceptParty,
            ),
          ),
          SizedBox(width: 30),
          SizedBox(
            height: double.infinity,
            width: 144,
            child: RaisedButton(
              color: Color(0xFF707070),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text('Decline',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              onPressed: declineParty,
            ),
          )
        ],
      ),
    );
  }

  void _selectFile() async {
    File videoFile = await FilePicker.getFile(type: FileType.video);
    setState(() {
      _file = videoFile;
    });
  }

  void acceptParty() async {
    if (_file == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('You must select a file to accept the party'),
        ),
      );
    } else {
      await changePartyStatus('accepted');
      Navigator.of(context).pushReplacementNamed(
        ReadyScreen.routeName,
        arguments: {
          'party': _party,
          'file': _file,
          'friend': _friend,
          'roomId': _roomId
        },
      );
    }
  }

  void declineParty() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Declining Party'),
          content: Text('Are you sure you want to decline this party ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
                await changePartyStatus('declined');
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> changePartyStatus(String status) async {
    try {
      final party = Provider.of<PartyProvider.Party>(context, listen: false);
      await party.changePartyStatus(_party.id, status);
      await party.getPendingParties();
    } catch (err) {
      print(err);
      //_showSnackBarError();
    }
  }

  void _showSnackBarError() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Couldn\'t process your request'),
      duration: Duration(milliseconds: 1500),
    ));
  }
}
