import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';
import 'package:watcherooflutter/src/screens/edit_profile_screen.dart';
import 'package:watcherooflutter/src/widgets/loading_app_bar.dart';

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
    return Consumer<Profile>(
      builder: (context, profile, _) {
        return profile.user == null
            ? LoadingAppBar()
            : UserAccountsDrawerHeader(
                onDetailsPressed: () =>
                    Navigator.pushNamed(context, EditProfile.routeName),
                accountName:
                    Text(profile.user.firstName + ' ' + profile.user.lastName),
                // TODO: TO BE CHANGED TO USERNAME
                accountEmail: Text('Placeholder for username'),
                currentAccountPicture: CircleAvatar(
                  // TODO: TO BE CHANGED TO REAL PIC
                  child: Text(profile.user.firstName[0].toUpperCase()),
                  backgroundColor: Colors.white,
                ),
              );
      },
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
