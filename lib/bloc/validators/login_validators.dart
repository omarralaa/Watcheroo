import 'dart:async';

class LoginValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, sink) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid) {
        sink.add(email);
      } else {
        sink.addError('Invalid Email');
      }
    },
  );

  final validateFullName = StreamTransformer<String, String>.fromHandlers(
    handleData: (String name, sink) {
      bool emailValid = RegExp(r"\b[a-zA-Z]+\s[a-zA-Z]+\b").hasMatch(name);
      if (emailValid) {
        sink.add(name);
      } else {
        sink.addError('Invalid Name');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, sink) {
      bool passValid = password.length >= 6;
      if (passValid) {
        sink.add(password);
      } else {
        sink.addError('Invalid Password');
      }
    },
  );
}
