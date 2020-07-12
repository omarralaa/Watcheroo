import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/bloc/auth_bloc.dart';
import 'package:watcherooflutter/screens/party_management_screen.dart';

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
        backgroundColor: Color(0xFFa6dcef),
        primarySwatch: Colors.pink,
        //accentColor: Color(0xFFf2aaaa),
      ),
      initialRoute: AuthScreen.routeName,
      routes: {
        PartyManagement.routeName: (ctx) => PartyManagement(),
        AuthScreen.routeName: (ctx) => Provider<AuthBloc>(
              create: (ctx) => AuthBloc(),
              child: AuthScreen(),
            ),
      },
    );
  }
}
