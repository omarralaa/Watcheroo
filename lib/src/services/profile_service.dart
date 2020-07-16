import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:watcherooflutter/src/models/profile.dart';
import 'package:http/http.dart' show get;
import 'package:watcherooflutter/src/services/utils/utils.dart';

class ProfileService with Utils {
  final String url = "http://10.0.2.2:3000/api/v1/profiles/";

  Future<UserProfile> fetchUser() async {
    try {
      final _token = await token;
      final response = await get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      UserProfile user = UserProfile.fromJson(responseBody['data']);

      return user;
    } catch (error) {
      throw error;
    }
  }
}
