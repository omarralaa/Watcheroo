import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_friend_screen.dart';
import '../widgets/friend_request_bar.dart';
import '../widgets/loading_list_tile.dart';
import '../providers/profile.dart';
import '../widgets/friend_list_tile.dart';

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Friends',
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.group_add),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pushNamed(AddFriendScreen.routeName);
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<Profile>(
      builder: (ctx, profile, _) {
        return Column(
          children: <Widget>[
            _buildFriendRequest(profile),
            SizedBox(height: 10),
            _buildListView(profile),
          ],
        );
      },
    );
  }

  Widget _buildFriendRequest(profile) {
    if (profile.user != null && profile.user.requests.length != 0) {
      return FriendRequestBar();
    }

    return SizedBox();
  }

  Widget _buildListView(profile) {
    return Expanded(
      child: ListView.builder(
        itemCount: profile.user == null ? 3 : profile.user.friends.length,
        itemBuilder: (context, index) => profile.user == null
            ? LoadingListTile()
            : FriendListTile(profile.user.friends[index]),
      ),
    );
  }
}
