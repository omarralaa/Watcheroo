import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../bloc/auth_bloc.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;

  AuthForm(this.isLogin);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthBloc>(context);
    return Form(
      child: Column(
        children: <Widget>[
          if (!widget.isLogin) _fullNameTextField(bloc),
          _emailTextField(bloc),
          _passwordTextField(bloc),
        ],
      ),
    );
  }

  Widget _fullNameTextField(AuthBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.fullName,
      builder: (context, snapshot) {
        return TextField(
          key: ValueKey('fullName'),
          decoration: InputDecoration(
            labelText: 'Full Name',
            hintText: 'John Doe',
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeFullName,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(_emailFocusNode);
          },
        );
      },
    );
  }

  Widget _emailTextField(AuthBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          key: ValueKey('email'),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'john@example.com',
            errorText: snapshot.error,
          ),
          focusNode: _emailFocusNode,
          onChanged: bloc.changeEmail,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        );
      },
    );
  }

  Widget _passwordTextField(AuthBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          key: ValueKey('password'),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: snapshot.error,
          ),
          focusNode: _passwordFocusNode,
          onChanged: bloc.changePassword,
        );
      },
    );
  }
}
