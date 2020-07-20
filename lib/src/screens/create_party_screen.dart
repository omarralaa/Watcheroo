import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

import '../providers/create_party.dart';

class CreatePartyScreen extends StatelessWidget {
  static const routeName = '/create-party';

  var friendProfile;
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    friendProfile = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: <Widget>[
              _buildMovieTextField(context),
              SizedBox(height: 20),
              _buildFileRow(context),
              SizedBox(height: 20),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 20),
              _buildMovieDuration(),
              SizedBox(height: 20),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 20),
              _buildComboBox(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildLaunchButton(),
    );
  }

  Widget _buildMovieTextField(BuildContext context) {
    final createParty = Provider.of<CreateParty>(context, listen: false);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Movie Name',
        hintText: 'ex. Interstellar, The Green Mile',
      ),
      onChanged: createParty.setMovieName,
    );
  }

  Widget _buildFileRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Consumer<CreateParty>(
          builder: (ctx, createParty, _) =>
              Expanded(child: Text(createParty.url ?? '')),
        ),
        RaisedButton(
          child: Text('Select'),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () => _selectFile(context),
        ),
      ],
    );
  }

  Widget _buildMovieDuration() {
    return Consumer<CreateParty>(
      builder: (context, createParty, _) => Text(
        'Movie Duration: ${createParty.movieDuration}',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }

  Widget _buildComboBox() {
    return Consumer<CreateParty>(builder: (context, createParty, _) {
      final userProfile = Provider.of<Profile>(context, listen: false).user;
      return DropdownButton(
        value: valueOfFriend(createParty),
        elevation: 20,
        icon: Icon(Icons.account_circle),
        iconSize: 24,
        items: userProfile.friends
            .map((friend) => friend.username)
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.blueAccent),
            ),
          );
        }).toList(),
        onChanged: createParty.selectFriend,
      );
    });
  }

  String valueOfFriend(CreateParty createParty) {
    if (friendProfile != null && isFirst) {
      isFirst = false;
      createParty.selectFriend(friendProfile.username);
    }
      return createParty.selectedFriend;
    
  }

  Widget _buildLaunchButton() {
    return Consumer<CreateParty>(
      builder: (context, createParty, _) {
        return Container(
          width: 300,
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text(
              'Launch Party Now!',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: !createParty.isValidSubmit ? null : () {},
          ),
        );
      },
    );
  }

  void _selectFile(BuildContext context) async {
    File file = await FilePicker.getFile(type: FileType.video);
    Provider.of<CreateParty>(context, listen: false).setMetaData(file);
  }
}
