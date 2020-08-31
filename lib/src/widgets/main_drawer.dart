import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/screens/previous_parties_screen.dart';

import '../providers/profile.dart';
import '../screens/about_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/tabs_screen.dart';
import '../widgets/loading_app_bar.dart';
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
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName),
              ),
              Divider(),
              ListTile(
                title: Text('Previously Watched'),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(PreviousPartiesScreen.routeName),
              ),
              Divider(),
              ListTile(
                title: Text('About'),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(AboutScreen.routeName),
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
                    Navigator.pushNamed(context, EditProfileScreen.routeName),
                accountName:
                    Text(profile.user.firstName + ' ' + profile.user.lastName),
                accountEmail: Text(profile.user.username),
                currentAccountPicture: CircleAvatar(
                  child: profile.user.photo == 'no-photo.png'
                      ? Text(profile.user.firstName[0].toUpperCase())
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(profile.user.imageUrl),
                                fit: BoxFit.cover),
                          ),
                          //child: CachedNetworkImage(imageUrl: profile.user.imageUrl, fit: BoxFit.cover,),
                        ),
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
          child: Text('Logout'),
          onPressed: auth.logout,
        ),
      );
    });
  }
}
