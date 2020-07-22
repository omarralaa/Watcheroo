import 'dart:convert';

import 'package:http/http.dart' show post, get;

import '../models/friend.dart';
import '../models/http_exception.dart';
import '../services/utils/service_utils.dart';

class FriendService with ServiceUtils {
  final String url = "http://10.0.2.2:3000/api/v1/profiles";

  Future<bool> changeFriendState(
      String friendState, String targetProfileId) async {
    final subUrl = '$url/$targetProfileId/friend-request/$friendState';
    try {
      final _token = await token;
      final response = await post(
        subUrl,
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

      if (response.statusCode >= 400) return false;

      return true;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> sendFriendRequest(String targetProfileId) async {
    final subUrl = '$url/$targetProfileId/friend-request/';
    try {
      final _token = await token;
      final response = await post(
        subUrl,
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

      if (response.statusCode >= 400) return false;

      return true;
    } catch (error) {
      throw error;
    }
  }

  Future<Friend> searchFriendByUsername(String username) async {
    final subUrl = '$url/username/$username';
    try {
      final _token = await token;
      final response = await get(
        subUrl,
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

      final friend = Friend.fromJson(responseBody['data']);

      return friend;
    } catch (error) {
      throw error;
    }
  }
}
