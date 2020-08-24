import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/party.dart';
import 'package:watcherooflutter/src/screens/add_party_screen.dart';

import './src/providers/accept_invitation.dart';
import './src/providers/friends.dart';
import './src/screens/movie_screen.dart';
import './src/utils/navigation_service.dart';
import './src/utils/service_locator.dart';
import './src/screens/accept_invitation_screen.dart';
import './src/screens/ready_screen.dart';
import './src/providers/profile.dart';
import './src/screens/about_screen.dart';
import './src/screens/add_friend_screen.dart';
import './src/screens/edit_profile_screen.dart';
import './src/screens/tabs_screen.dart';
import './src/screens/view_profile_screen.dart';
import './src/providers/auth.dart';
import './src/screens/splash_screen.dart';
import './src/screens/party_management_screen.dart';
import './src/screens/auth_screen.dart';

void main() {
  setupLocator();
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
        ChangeNotifierProvider<Friends>(
          create: (ctx) => Friends(),
        ),
        ChangeNotifierProvider<Party>(
          create: (ctx) => Party(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Watcheroo',
            navigatorKey: locator<NavigationService>().navigatorKey,
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
                          : AuthScreen();
                    },
                  ),
            routes: {
              TabsScreen.routeName: (ctx) => TabsScreen(),
              PartyManagementScreen.routeName: (ctx) => PartyManagementScreen(),
              EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
              ViewProfileScreen.routeName: (ctx) => ViewProfileScreen(),
              AddFriendScreen.routeName: (ctx) => AddFriendScreen(),
              AboutScreen.routeName: (ctx) => AboutScreen(),
              ReadyScreen.routeName: (ctx) => ReadyScreen(),
              AcceptInvitationScreen.routeName: (ctx) =>
                  ChangeNotifierProvider<AcceptInvitation>(
                    create: (ctx) => AcceptInvitation(),
                    child: AcceptInvitationScreen(),
                  ),
              MovieScreen.routeName: (ctx) => MovieScreen(),
              AddPartyScreen.routeName: (ctx) => AddPartyScreen(),
            },
          );
        },
      ),
    );
  }
}
