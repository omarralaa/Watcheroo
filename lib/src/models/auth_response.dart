class AuthResponse {
  final String token;
  final DateTime expiryDate;
  final String userId;

  AuthResponse.fromJson(Map<String, dynamic> map)
      : token = map['token'],
        expiryDate = DateTime.fromMillisecondsSinceEpoch(map['expiryDate']),
        userId = map['_userId'];

  Map<String, dynamic> toJson() => {
        'token': token,
        'expiryDate': expiryDate.millisecondsSinceEpoch,
        'userId': userId,
      };
}
