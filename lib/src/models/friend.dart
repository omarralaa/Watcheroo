class Friend {
  String _id;
  String _username;
  String _firstName;
  String _lastName;
  String _photo;

  String get id => _id;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get photo => _photo;

  Friend.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _photo = json['photo'];
  }

  static List<Friend> getFriendsFromJson(List<dynamic> mapList) {
    List<Friend> friends = List<Friend>();
    for (var mapJson in mapList) {
      friends.add(Friend.fromJson(mapJson));
    }

    return friends;
  }
}
