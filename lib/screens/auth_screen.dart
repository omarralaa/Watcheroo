import 'package:flutter/material.dart';

import './party_managment_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Hello from Auth'),
          RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.of(context).pushNamed(PartyManagement.routeName);
            },
          )
        ],
      )
    );
  }
}
