import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';
import '../widgets/profile_picture_header.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = "/edit-profile";
  Color accentColor;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    accentColor = Theme.of(context).accentColor;
    bgColor = Theme.of(context).backgroundColor;
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          disabledColor: accentColor,
          disabledTextColor: Colors.white,
          onPressed: null,
          child: Text('Save'),
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: <Widget>[
        ProfilePictureHeader(
          image:
              'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
          editable: true,
        ),
        Consumer<Profile>(
          builder: (context, profile, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: accentColor,
                              ),
                            ),
                            labelText: 'First Name',
                          ),
                          controller: TextEditingController()
                            ..text = profile.user.firstName,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: accentColor,
                              ),
                            ),
                            labelText: 'Last Name',
                          ),
                          controller: TextEditingController()
                            ..text = profile.user.lastName,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: accentColor,
                        ),
                      ),
                      labelText: 'Username',
                    ),
                    controller: TextEditingController()
                      ..text = profile.user.username,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
