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

  String get imageUrl {
    return 'http://10.0.2.2:3000/uploads/$photo';
  }

  Friend.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _photo = json['photo'];
  }

  static List<Friend> getFriendsFromJson(List<dynamic> mapList) {
    List<Friend> friends = List<Friend>();
    if (mapList != null)
      for (var mapJson in mapList) {
        friends.add(Friend.fromJson(mapJson));
      }

    return friends;
  }
}
