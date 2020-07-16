class UserProfile {
  String _id;
  String _userId;
  String _firstName;
  String _lastName;
  String _photo;

  String get id => _id;
  String get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get photo => _photo;

  UserProfile.fromJson(Map<String, dynamic> json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _id = json['_id'];
    _userId = json['_userId'];
    _photo = json['photo'];
  }
}
