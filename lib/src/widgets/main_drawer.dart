import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/user.dart';

import '../providers/auth.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: <Widget>[
              drawerHeader(),
              ListTile(
                title: Text('Watch Together!!!'),
              ),
              Divider(),
              ListTile(
                title: Text('Previously Watched'),
              ),
              Divider(),
              ListTile(
                title: Text('About'),
              ),
            ]),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    _buildLogoutButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerHeader() {
    return Consumer<User>(builder: (context, user, _) {
      final x = user.start();
      return FutureBuilder(
        future: x,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting)
            return UserAccountsDrawerHeader(
              accountName: Text(user.user.firstName + ' ' + user.user.lastName),
              accountEmail: Text(user.user.email),
              currentAccountPicture: CircleAvatar(
                child: Text('Y'),
                backgroundColor: Colors.white,
              ),
            );
          else
            return CircularProgressIndicator();
        },
      );
    });
  }

  Widget _buildLogoutButton() {
    return Consumer<Auth>(builder: (context, auth, _) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          child: Text('Log out'),
          onPressed: auth.logout,
        ),
      );
    });
  }
}
