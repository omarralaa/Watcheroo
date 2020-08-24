import 'package:flutter/material.dart';

import '../services/party_service.dart';
import '../utils/service_locator.dart';
import '../models/party.dart' as p;

class Party with ChangeNotifier {
  final _partyService = locator<PartyService>();

  Future<p.Party> createParty(String friendId, String movieName) async {
    try {
      final party = await _partyService.createParty(friendId, movieName);
      return party;
    } catch (err) {
      throw (err);
    }
  }
}
