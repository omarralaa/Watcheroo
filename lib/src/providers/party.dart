import 'package:flutter/material.dart';

import '../services/party_service.dart';
import '../utils/service_locator.dart';
import '../models/party.dart' as p;

class Party with ChangeNotifier {
  final _partyService = locator<PartyService>();

  List<p.Party> prevParties;

  Future<p.Party> createParty(String friendId, String movieName) async {
    try {
      final party = await _partyService.createParty(friendId, movieName);
      return party;
    } catch (err) {
      throw (err);
    }
  }

  Future<void> getPrevParties() async {
    try {
      final parties = await _partyService.getPrevParties();
      prevParties = parties;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  Future<p.Party> getParty(String partyId) async {
    try {
      final fetchedParty = await PartyService().getParty(partyId);
      return fetchedParty;
    } catch (err) {
      throw (err);
    }
  }
}
