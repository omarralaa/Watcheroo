import 'package:flutter/material.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/widgets/friend_request_tile.dart';

class FriendRequestBottomSheet extends StatelessWidget {
  final List<Friend> requests;

  FriendRequestBottomSheet(this.requests);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Text('Friend Requests'),
            Container(
              height: 300,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (ctx, index) {
                  return FriendRequestTile(requests[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
