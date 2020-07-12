import 'package:flutter/material.dart';
import 'package:watcherooflutter/widgets/drawer_items_widget.dart';
import 'package:watcherooflutter/widgets/sliver_appbar_widget.dart';

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
      drawer: Drawer(
        child: DrawerItems(),
      ),
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
