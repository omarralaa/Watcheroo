import 'package:flutter/material.dart';
import 'package:watcherooflutter/src/screens/home_screen.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, arguments) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void popToHome() {
    return navigatorKey.currentState.popUntil((route) => route.isFirst);
  }

  void showDisconnectionDialog() {
    showDialog(
      context:
          navigatorKey.currentState.overlay.context,
          builder:  (context) => AlertDialog(
            title: Text('Canceled'),
            content: Text('Your partner disconnected from the party'),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }
}
