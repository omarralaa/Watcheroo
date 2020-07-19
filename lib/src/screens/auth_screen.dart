import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../providers/auth_validation.dart';

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
                  SizedBox(
                    height: 15,
                  ),
                  _loginButton(),
                  _switchLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Consumer<AuthValidation>(
      builder: (ctx, authValidation, _) {
        return RaisedButton(
          child: Text(authValidation.isLogin ? 'Login' : 'Register'),
          onPressed: !authValidation.isValid
              ? null
              : () async {
                  final auth = Provider.of<Auth>(ctx, listen: false);
                  final err = await authValidation.submitData(auth);
                  if (err != null)
                    _showError(err, ctx);
                  else {
                    //await Provider.of<Profile>(ctx, listen: false).getProfile();
                  }
                },
        );
      },
    );
  }

  Widget _switchLoginButton() {
    return Consumer<AuthValidation>(builder: (context, authValidation, _) {
      return FlatButton(
        child: Text(
          authValidation.isLogin
              ? 'Not a user? Register now'
              : 'Already a user? Login now',
        ),
        onPressed: () {
          authValidation.changeLogin();
        },
      );
    });
  }

  void _showError(err, BuildContext context) {
    final errorMessage = err is HttpException
        ? err.message
        : 'Something wrong happened, try again later.';
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Authentication failed'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        );
      },
    );
  }
}
