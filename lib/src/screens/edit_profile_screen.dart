import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/models/profile.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

class EditProfile extends StatelessWidget {
  static const String routeName = "/edit-profile";
  UserProfile user;
  Color accentColor;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    accentColor = Theme.of(context).accentColor;
    bgColor = Theme.of(context).backgroundColor;
    user = Provider.of<Profile>(context).user;
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
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  color: bgColor,
                ),
                Transform.translate(
                  offset: Offset(220.0, -30.0),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(30 / 360),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.pink,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 2.0,
                  child: Transform.translate(
                    offset: Offset(-150.0, -60.0),
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(-30 / 360),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: accentColor,
                      ),
                    ),
                  ),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: EdgeInsets.only(top: 90.0, right: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: accentColor,
                        radius: 25.0,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer<Profile>(
          builder: (context, user, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
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
                            ..text = user.user.firstName,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
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
                            ..text = user.user.lastName,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
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
                      ..text = user.user.username,
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
