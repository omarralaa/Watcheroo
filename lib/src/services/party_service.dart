import 'dart:convert';

import 'package:http/http.dart' show post;

import '../models/http_exception.dart';
import '../services/utils/service_utils.dart';
import '../models/party.dart';

class PartyService with ServiceUtils {
  final String url = "http://10.0.2.2:3000/api/v1/parties";

  Future<Party> createParty(String guestId, String movieName) async {
    try {
      final _token = await token;
      final response = await post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        },
        body: json.encode({
          '_guest': guestId,
          'movieName': movieName,
        }),
      ).timeout(Duration(seconds: 5),
          onTimeout: () => throw HttpException('Server Timed out'));

      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null)
        throw HttpException(responseBody['error']);

      final party = Party.fromJson(responseBody['data']);

      return party;
    } catch (error) {
      throw error;
    }
  }
}
