import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../providers/auth_validation.dart';

class AuthForm extends StatefulWidget {
  // TODO: CHECK IF CAN BE CHANGED TO STATELESS

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authValidation = Provider.of<AuthValidation>(context);
    return Column(
      children: <Widget>[
        if (!authValidation.isLogin) _fullNameTextField(authValidation),
        _emailTextField(authValidation),
        _passwordTextField(authValidation),
      ],
    );
  }

  Widget _fullNameTextField(AuthValidation authValidation) {
    return TextField(
      key: ValueKey('fullName'),
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: 'John Doe',
        errorText: authValidation.fullName.error,
      ),
      onChanged: authValidation.changeFullName,
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );
  }

  Widget _emailTextField(AuthValidation authValidation) {
    return TextField(
      key: ValueKey('email'),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'john@example.com',
        errorText: authValidation.email.error,
      ),
      focusNode: _emailFocusNode,
      onChanged: authValidation.changeEmail,
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _passwordTextField(AuthValidation authValidation) {
    return TextField(
      key: ValueKey('password'),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: authValidation.password.error,
      ),
      focusNode: _passwordFocusNode,
      onChanged: authValidation.changePassword,
    );
  }
}
