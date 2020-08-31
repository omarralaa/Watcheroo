import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/party.dart';
import 'package:watcherooflutter/src/providers/profile.dart';
import 'package:watcherooflutter/src/widgets/prev_party_tile.dart';
import '../models/party.dart' as PartyModel;

import '../widgets/main_drawer.dart';

class PreviousPartiesScreen extends StatefulWidget {
  static String routeName = '/previous-parties';

  @override
  _PreviousPartiesScreenState createState() => _PreviousPartiesScreenState();
}

class _PreviousPartiesScreenState extends State<PreviousPartiesScreen> {
  List<PartyModel.Party> searchedParties;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Previously Watched Parties')),
      drawer: MainDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          _buildSearchBar(),
          SizedBox(height: 20),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final prevParties = Provider.of<Party>(context).prevParties;

    return Container(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search by movie name',
          hintText: 'ex: Interstellar',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onChanged: ((val) {
          this.setState(() {
            searchedParties = prevParties
                .where((party) =>
                    party.movieName.toLowerCase().startsWith(val.toLowerCase()))
                .toList();
          });
        }),
      ),
    );
  }

  Widget _buildList() {
    final prevParties = Provider.of<Party>(context).prevParties;
    final profile = Provider.of<Profile>(context);

    final notLoaded = profile.user == null || prevParties == null;
    if (searchedParties == null) searchedParties = prevParties;
    return Expanded(
      child: ListView.builder(
        key: UniqueKey(),
        itemCount: notLoaded ? 2 : searchedParties.length,
        itemBuilder: (ctx, i) {
          if (notLoaded) {
            return Container(
              height: 85,
              margin: EdgeInsets.only(top: 12),
              color: Color(0xFFE8E8E8),
            );
          } else {
            final friend = profile.getFriendByGuestOrCreator(
              searchedParties[i].creator,
              searchedParties[i].guest,
            );

            return PrevPartyTile(searchedParties[i], friend);
          }
        },
      ),
    );
  }
}
