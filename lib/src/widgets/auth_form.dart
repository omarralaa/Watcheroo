import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../providers/auth.dart';
import '../utils/utils.dart';
import '../validations/auth_form_validation.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with Utils, AuthFormValidation {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (!_isLogin) _fullNameTextField(),
          _emailTextField(),
          _passwordTextField(),
          SizedBox(height: 15),
          _loginButton(),
          _switchLoginButton(),
        ],
      ),
    );
  }

  Widget _fullNameTextField() {
    return TextFormField(
      key: ValueKey('fullName'),
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: 'John Doe',
      ),
      controller: fullNameController,
      validator: _isLogin ? null : validateFullName,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      key: ValueKey('email'),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'john@example.com',
      ),
      focusNode: _emailFocusNode,
      controller: emailController,
      validator: validateEmail,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      key: ValueKey('password'),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      controller: passwordController,
      focusNode: _passwordFocusNode,
      validator: validatePassword,
    );
  }

  Widget _loginButton() {
    return RaisedButton(
      child: Text(_isLogin ? 'Login' : 'Register'),
      onPressed: _isLoading ? null : _submitForm,
    );
  }

  Widget _switchLoginButton() {
    return FlatButton(
      child: Text(
        _isLogin ? 'Not a user? Register now' : 'Already a user? Login now',
      ),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      
      setState(() {
        _isLoading = true;
      });

      final auth = Provider.of<Auth>(context, listen: false);

      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final fullName = fullNameController.text;

      try {
        if (_isLogin) {
          await auth.login(email, password);
        } else {
          await auth.register(email, password, fullName);
        }
      } catch (err) {
        showError(err, context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
