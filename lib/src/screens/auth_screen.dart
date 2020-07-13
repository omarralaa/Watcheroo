import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import 'package:watcherooflutter/src/providers/auth.dart';
import 'package:watcherooflutter/src/providers/auth_validation.dart';

import '../widgets/auth_form.dart';
import './party_management_screen.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final authValidation = Provider.of<AuthValidation>(context, listen: false);
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
                  SizedBox(
                    height: 15,
                  ),
                  _loginButton(),
                  FlatButton(
                    child: Text(
                      authValidation.isLogin
                          ? 'Not a user? Register now'
                          : 'Already a user? Login now',
                    ),
                    onPressed: () {
                      authValidation.changeLogin();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Consumer<AuthValidation>(builder: (ctx, authValidation, _) {
      return RaisedButton(
        child: Text(authValidation.isLogin ? 'Login' : 'Register'),
        color: Theme.of(ctx).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: !authValidation.isValid
            ? null
            : () async {
                final auth = Provider.of<Auth>(ctx, listen: false);
                authValidation.submitData(auth);
                Navigator.of(ctx).pushNamed(PartyManagement.routeName);
              },
      );
    });
  }
}
