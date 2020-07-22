import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

import '../models/friend.dart';

class FriendRequestTile extends StatelessWidget {
  final Friend friend;

  FriendRequestTile(this.friend);

  @override
  Widget build(BuildContext context) {
    final fullName = '${friend.firstName} ${friend.lastName}';
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: Text(friend.firstName[0].toUpperCase()),
          ),
          title: Text(fullName),
          subtitle: Text(friend.username),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () => _changeFriendState(context, 'accept'),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => _changeFriendState(context, 'decline'),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  void _changeFriendState(BuildContext context, String friendState) async {
    await Provider.of<Profile>(context, listen: false)
        .changeFriendRequest(friendState, friend);

    Navigator.of(context).pop();
  }
}
