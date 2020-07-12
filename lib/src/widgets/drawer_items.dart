import 'package:flutter/material.dart';

class DrawerItems extends StatelessWidget {
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
    return Column(
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
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Log out'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
