import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          child: Container(
            width: 280,
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Image.asset(
                      'assets/images/logo.png',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  AuthForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
