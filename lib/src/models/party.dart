class Party {
  final String _id;
  final String _creator;
  final String _guest;
  final String _movieName;
  bool _isCreatorReady;
  bool _isGuestReady;
  final DateTime _createdAt;

  String get id => _id;
  String get creator => _creator;
  String get guest => _guest;
  String get movieName => _movieName;
  bool get isCreatorReady => _isCreatorReady;
  bool get isGuestReady => _isGuestReady;
  DateTime get createdAt => _createdAt;

  Party.fromJson(Map<String, dynamic> json) :
    _id = json['_id'],
    _creator = json['_creator'],
    _guest = json['_guest'],
    _movieName = json['movieName'],
    _isCreatorReady = json['isCreatorReady'],
    _isGuestReady = json['isGuestReady'],
    _createdAt = DateTime.parse(json['createdAt']);
  
}