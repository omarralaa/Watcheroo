import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../providers/auth_validation.dart';

class AuthForm extends StatelessWidget {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authValidation = Provider.of<AuthValidation>(context);
    return Column(
      children: <Widget>[
        if (!authValidation.isLogin)
          _fullNameTextField(authValidation, context),
        _emailTextField(authValidation, context),
        _passwordTextField(authValidation),
      ],
    );
  }

  Widget _fullNameTextField(
      AuthValidation authValidation, BuildContext context) {
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

  Widget _emailTextField(AuthValidation authValidation, BuildContext context) {
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
