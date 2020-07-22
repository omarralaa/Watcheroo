import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:watcherooflutter/src/models/user_profile.dart';
import 'package:http/http.dart' show get;
import 'package:watcherooflutter/src/services/utils/service_utils.dart';

class ProfileService with ServiceUtils {
  final String url = "http://10.0.2.2:3000/api/v1/profiles/me";

  Future<UserProfile> fetchProfile() async {
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

      UserProfile profile = UserProfile.fromJson(responseBody['data']);

      return profile;
    } catch (error) {
      throw error;
    }
  }

  Future<UserProfile> updateProfile(Map<String, dynamic> updatedFields) async {
    try {
      final _token = await token;
      final response = await put(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
        body: json.encode(updatedFields)
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      UserProfile profile = UserProfile.fromJson(responseBody['data']);

      return profile;
    } catch (error) {
      throw error;
    }
  }
}
