import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/models/user.dart';
import 'package:watcherooflutter/src/providers/user.dart' as p;
import 'package:watcherooflutter/src/services/user_service.dart';

import '../widgets/main_drawer.dart';
import '../widgets/sliver_appbar.dart';

class PartyManagement extends StatelessWidget {
  static const routeName = '/party-management';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppBar(),
          SliverList(delegate: _buildWatchPartyListView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      drawer: MainDrawer(),
      endDrawer: Drawer(),
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
