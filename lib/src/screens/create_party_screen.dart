import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/create_party.dart';

class CreatePartyScreen extends StatelessWidget {
  static const routeName = '/create-party';

  @override
  Widget build(BuildContext context) {
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
              _buildLaunchButton(),
            ],
          ),
        ),
      ),
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
              Expanded(child: Text(createParty.URL ?? '')),
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
      return DropdownButton(
        value: createParty.selectedFriend,
        elevation: 20,
        icon: Icon(Icons.account_circle),
        iconSize: 24,
        items: <String>[
          'Jessica Hyde',
          'Wilson Wilson',
          'Ian',
          'Becky',
          'Grant',
        ].map<DropdownMenuItem<String>>((String value) {
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

  Widget _buildLaunchButton() {
    return Consumer<CreateParty>(
      builder: (context, createParty, _) {
        return Container(
          width: 300,
          child: RaisedButton(
            child: Text(
              'Launch Party Now!',
              style: TextStyle(fontSize: 18),
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
