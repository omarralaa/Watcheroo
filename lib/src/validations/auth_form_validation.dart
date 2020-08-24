class AuthFormValidation {
  String validateFullName(String name) {
    bool nameValid = RegExp(r"\b[a-zA-Z]+\s[a-zA-Z]+\b").hasMatch(name);
    return nameValid ? null : 'Invalid Name';
  }

  String validateSingleName(String name) {
    if (name == null || name.isEmpty) {
      return 'You must provide a name';
    }

    if (name.length > 20) {
      return 'Names should not excceed 20 char';
    }

    return null;
  }

  String validateUsername(String username) {
    if (username.length < 6) {
      return 'Username must be at least 6 characters long';
    }
    if (username.length < 6) {
      return 'Username must be at least 6 characters long';

      //TODO: THIS NEEDS MODIFICATION
    }
    if (RegExp(r"^[a-zA-Z0-9_-]*$/").hasMatch(username)) {
      return 'Username can only contain characters, numbers, dashes and underscores';
    } 

    return null;
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
