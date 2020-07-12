import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../bloc/auth_bloc.dart';
import '../widgets/auth_form.dart';
import './party_management_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthBloc>(context);
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
                  AuthForm(_isLogin),
                  SizedBox(
                    height: 15,
                  ),
                  _loginButton(bloc),
                  FlatButton(
                    child: Text(
                      _isLogin
                          ? 'Not a user? Register now'
                          : 'Already a user? Login now',
                    ),
                    onPressed: () {
                      bloc.restData();
                      setState(() {
                        _isLogin = !_isLogin;
                      });
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

  Widget _loginButton(AuthBloc bloc) {
    return StreamBuilder<bool>(
      stream: _isLogin ? bloc.validLogin : bloc.validRegister,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text(_isLogin ? 'Login' : 'Register'),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: !snapshot.hasData
              ? null
              : () {
                  bloc.submitData(_isLogin);
                  //Navigator.of(context).pushNamed(PartyManagement.routeName);
                },
        );
      },
    );
  }
}
