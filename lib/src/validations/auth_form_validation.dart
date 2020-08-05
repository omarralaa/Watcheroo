class AuthFormValidation {
  String validateFullName(String name) {
    bool nameValid = RegExp(r"\b[a-zA-Z]+\s[a-zA-Z]+\b").hasMatch(name);
    return nameValid ? null : 'Invalid Name';
  }

  String validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid ? null : 'Invalid Email';
  }

  String validatePassword(String password) {
    bool passValid = password.length >= 6;
    return passValid ? null : 'Invalid Password';
  }
}
