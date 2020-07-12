import 'package:flutter/material.dart';
import 'package:watcherooflutter/screens/party_managment_screen.dart';

import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //backgroundColor: Color(0xFFe36387),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
      routes: {
        PartyManagement.routeName: (ctx) => PartyManagement(),
      },
    );
  }
}