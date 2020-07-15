import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Yosra Emad'),
      accountEmail: Text('yosra@gmail.com'),
      currentAccountPicture: CircleAvatar(
        child: Text('Y'),
        backgroundColor: Colors.white,
      ),
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: <Widget>[
              drawerHeader,
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
