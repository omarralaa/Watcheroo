import 'package:flutter/material.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/screens/view_profile_screen.dart';

class FriendListTile extends StatelessWidget {
  final Friend friend;

  FriendListTile(this.friend);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: friend.photo == 'no-photo.png'
                ? Text(friend.firstName[0].toUpperCase())
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(friend.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          title: Text('${friend.firstName} ${friend.lastName}'),
          subtitle: Text(friend.username),
          onTap: () {
            Navigator.of(context)
                .pushNamed(ViewProfileScreen.routeName, arguments: friend);
          },
        ),
        Divider(),
      ],
    );
  }
}
