import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';
import '../widgets/friend_list_tile.dart';

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Friends',
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          if (profile.user.requests.length != 0) buildFriendRequest(profile.user.requests.length),
          SizedBox(
            height: 10,
          ),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildFriendRequest(int numberOfRequests) {
    return Card(
      color: Colors.pink,
      child: ListTile(
        leading: Icon(
          Icons.notifications_active,
          color: Colors.white,
        ),
        title: Text(
          'Friend Request',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        trailing: GestureDetector(
          child: Wrap(
            spacing: 0,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text('$numberOfRequests',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400)),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget buildListView() {
    return Consumer<Profile>(builder: (context, profile, _) {
      return Expanded(
        child: ListView.builder(
          itemCount: profile.user.friends.length,
          itemBuilder: (context, index) =>
              FriendListTile(profile.user.friends[index]),
        ),
      );
    });
  }
}
