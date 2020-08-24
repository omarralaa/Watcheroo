import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:watcherooflutter/src/models/user_profile.dart';
import 'package:http/http.dart' as http;

import './servicesUtils/service_utils.dart';

class ProfileService with ServiceUtils {
  final String url = "http://10.0.2.2:3000/api/v1/profiles/me";

  Future<UserProfile> fetchProfile() async {
    try {
      final _token = await token;
      final response = await http.get(
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
      final response = await http
          .put(url,
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ' + _token,
              },
              body: json.encode(updatedFields))
          .timeout(Duration(seconds: 5),
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

  Future<String> uploadPhoto(File file) async {
    try {
      final _token = await token;

      final subUrl = url + '/photo';

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path,
            filename: basename(file.path)),
      });

      Dio dio = Dio();
      final response = await dio.put(
        subUrl,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + _token,
          },
        ),
      );

      return response.data['data'];

    } catch (error) {
      throw error;
    }
  }
}
