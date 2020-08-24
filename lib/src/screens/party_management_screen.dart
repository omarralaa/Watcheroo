import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/screens/add_party_screen.dart';

import '../providers/profile.dart';
import '../widgets/main_drawer.dart';
import '../widgets/sliver_appbar.dart';

class PartyManagementScreen extends StatelessWidget {
  static const routeName = '/party-management';

  @override
  Widget build(BuildContext context) {
    Provider.of<Profile>(context, listen: false).getProfile();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppBar(),
          SliverList(delegate: _buildWatchPartyListView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddPartyScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
      drawer: MainDrawer(),
    );
  }

  SliverChildBuilderDelegate _buildWatchPartyListView() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int i) {
        if (i.isOdd) return Divider();
        return _buildRow();
      },
      childCount: 10 * 2,
    );
  }

  Widget _buildRow() {
    return ListTile(
      title: Text('The green mile'),
      subtitle: Text('Yosra Emad\t8:00PM TODAY'),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
