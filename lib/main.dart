import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/user.dart';

import './src/providers/auth.dart';
import './src/screens/splash_screen.dart';
import './src/providers/auth_validation.dart';
import './src/screens/party_management_screen.dart';
import './src/screens/auth_screen.dart';
import './src/screens/create_party_screen.dart';
import './src/providers/create_party.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider<User>(
          create: (ctx) => User(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              backgroundColor: Color(0xFFa6dcef),
              primarySwatch: Colors.pink,
              //accentColor: Color(0xFF1EE9A4),
              buttonTheme: ButtonThemeData().copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: auth.isAuth
                ? PartyManagement()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : ChangeNotifierProvider<AuthValidation>(
                              create: (ctx) => AuthValidation(),
                              child: AuthScreen(),
                            );
                    },
                  ),
            routes: {
              PartyManagement.routeName: (ctx) => PartyManagement(),
              CreatePartyScreen.routeName: (ctx) =>
                  ChangeNotifierProvider<CreateParty>(
                    create: (ctx) => CreateParty(),
                    child: CreatePartyScreen(),
                  ),
            },
          );
        },
      ),
    );
  }
}
