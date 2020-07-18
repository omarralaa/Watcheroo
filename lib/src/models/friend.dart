class Friend {
  String _id;
  String _userId;
  String _username;
  String _firstName;
  String _lastName;
  String _photo;

  String get id => _id;
  String get userId => _userId;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get photo => _photo;

  Friend.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _userId = json['_userId'];
    _photo = json['photo'];
  }

  static List<Friend> getFriendsFromJson(List<Map<String, dynamic>> mapList) {
    List<Friend> friends = List<Friend>();
    for (var mapJson in mapList) {
      friends.add(Friend.fromJson(mapJson));
    }

    return friends;
  }
}
