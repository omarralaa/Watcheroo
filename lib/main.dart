import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/screens/ready_screen.dart';

import './src/providers/add_friend.dart';
import './src/providers/edit_profile_validation.dart';
import './src/providers/profile.dart';
import './src/providers/ready.dart';
import './src/screens/about_screen.dart';
import './src/screens/add_friend_screen.dart';
import './src/screens/edit_profile_screen.dart';
import 'src/screens/ready_screen.dart';
import './src/screens/tabs_screen.dart';
import './src/screens/view_profile_screen.dart';
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
        ChangeNotifierProvider<Profile>(
          create: (ctx) => Profile(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Watcheroo',
            theme: ThemeData(
              fontFamily: 'OpenSans',
              backgroundColor: Color(0xFFa6dcef),
              primarySwatch: Colors.pink,
              accentColor: Colors.grey[700],
              buttonTheme: ButtonThemeData().copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: auth.isAuth
                ? TabsScreen()
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
              TabsScreen.routeName: (ctx) => TabsScreen(),
              PartyManagementScreen.routeName: (ctx) => PartyManagementScreen(),
              CreatePartyScreen.routeName: (ctx) =>
                  ChangeNotifierProvider<CreateParty>(
                    create: (ctx) => CreateParty(),
                    child: CreatePartyScreen(),
                  ),
              EditProfileScreen.routeName: (ctx) =>
                  ChangeNotifierProvider<EditProfileValidation>(
                    create: (ctx) => EditProfileValidation(),
                    child: EditProfileScreen(),
                  ),
              ViewProfileScreen.routeName: (ctx) => ViewProfileScreen(),
              AddFriendScreen.routeName: (ctx) =>
                  ChangeNotifierProvider<AddFriend>(
                    create: (ctx) => AddFriend(),
                    child: AddFriendScreen(),
                  ),
              AboutScreen.routeName: (ctx) => AboutScreen(),
              ReadyScreen.routeName: (ctx) => ChangeNotifierProvider<Ready>(
                    create: (ctx) => Ready(),
                    child: ReadyScreen(),
                  ),
            },
          );
        },
      ),
    );
  }
}
