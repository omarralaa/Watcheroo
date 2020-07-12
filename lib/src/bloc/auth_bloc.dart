import 'package:rxdart/rxdart.dart';

import './validators/login_validators.dart';

class AuthBloc with LoginValidators {
  BehaviorSubject<String> _emailController = BehaviorSubject();
  BehaviorSubject<String> _passwordController = BehaviorSubject();
  BehaviorSubject<String> _fullNameController = BehaviorSubject();

  // Sink Getters
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeFullName => _fullNameController.sink.add;

  // Streams Getters
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<String> get fullName =>
      _fullNameController.stream.transform(validateFullName);

  Stream<bool> get validLogin =>
      Rx.combineLatest2(email, password, (a, b) => true);
  Stream<bool> get validRegister =>
      Rx.combineLatest3(email, password, fullName, (a, b, c) => true);

  void restData() {
    changeFullName('');
    changeEmail('');
    changePassword('');
  }

  void submitData(bool isLogin) {
    print(_fullNameController.value);
    print(_emailController.value);
    print(_passwordController.value);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _fullNameController.close();
  }
}
