class User {
  String _email;
  String _firstName;
  String _lastName;
  String _role;
  String _id;

  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get role => _role;
  String get id => _id;

  User.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _role = json['role'];
    _id = json['_id'];
  }
}
