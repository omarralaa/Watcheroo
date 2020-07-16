import 'package:flutter/cupertino.dart';
import 'package:watcherooflutter/src/services/user_service.dart';
import 'package:watcherooflutter/src/models/user.dart' as u;

class User extends ChangeNotifier {
  u.User _user;

  start() async {
    try {
      UserService userService = UserService();
      _user = await userService.fetchUser();
    } catch (err) {
      throw err;
    }
  }

  u.User get user => _user;
}
