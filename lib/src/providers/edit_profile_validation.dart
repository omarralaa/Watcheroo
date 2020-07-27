import 'package:flutter/foundation.dart';
import 'package:watcherooflutter/src/models/validation_item.dart';

class EditProfileValidation with ChangeNotifier {
  ValidationItem _firstName = ValidationItem(null, null);
  ValidationItem _lastName = ValidationItem(null, null);
  ValidationItem _username = ValidationItem(null, null);

  // GETTERS
  ValidationItem get firstName => _firstName;
  ValidationItem get lastName => _lastName;
  ValidationItem get username => _username;

  Map<String, dynamic> get updatedFields {
    return {
      'firstName': _firstName.value,
      'lastName': _lastName.value,
      'username': _username.value,
    };
  }

  bool get isValidSubmit {
    if (firstName.value != null &&
        lastName.value != null &&
        username.value != null) {
      return true;
    }

    return false;
  }

  // SETTERS
  void changeFirstName(String firstNameVal) {
    if (firstNameVal.isEmpty) {
      _firstName = ValidationItem(null, 'Invalid First Name');
    } else {
      _firstName = ValidationItem(firstNameVal, null);
    }
    notifyListeners();
  }

  void changeLastName(String lastNameVal) {
    if (lastNameVal.isEmpty) {
      _lastName = ValidationItem(null, 'Invalid First Name');
    } else {
      _lastName = ValidationItem(lastNameVal, null);
    }
    notifyListeners();
  }

  void changeUsername(String usernameVal) {
    if (usernameVal.length < 6) {
      _username =
          ValidationItem(null, 'Username must be at least 6 characters long');
    } else if (usernameVal.length < 6) {
      _username =
          ValidationItem(null, 'Username must be at least 6 characters long');
          //TODO: THIS NEEDS MODIFICATION
    } else if (RegExp(r"^[a-zA-Z0-9_-]*$/").hasMatch(usernameVal)) {
      _username = ValidationItem(null,
          'Username can only contain characters, numbers, dashes and underscores');
    } else {
      _username = ValidationItem(usernameVal, null);
    }

    notifyListeners();

    //            /^[a-zA-Z0-9_-]*$/,
  }

  void initValidation(userProfile) {
    _firstName = ValidationItem(userProfile.firstName, null);
    _lastName = ValidationItem(userProfile.lastName, null);
    _username = ValidationItem(userProfile.username, null);
  }
}
