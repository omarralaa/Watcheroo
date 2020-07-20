import 'friend.dart';

class UserProfile {
  String _id;
  String _userId;
  String _username;
  String _firstName;
  String _lastName;
  String _photo;
  List<Friend> _friends;
  List<Friend> _requests;
  List<Friend> _sentRequests;

  String get id => _id;
  String get userId => _userId;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get photo => _photo;
  List<Friend> get friends => _friends;
  List<Friend> get requests => _requests;
  List<Friend> get sentRequests => _sentRequests;

  UserProfile.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _userId = json['_userId'];
    _photo = json['photo'];
    _friends = Friend.getFriendsFromJson(json['friends']);
    _requests = Friend.getFriendsFromJson(json['requests']);
    _sentRequests = Friend.getFriendsFromJson(json['sentRequests']);
  }
}
