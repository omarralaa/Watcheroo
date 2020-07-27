import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

import 'friend_request_bottom_sheet.dart';

class FriendRequestBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Profile>(
      builder: (context, profile, _) => Card(
        color: Colors.pink,
        child: ListTile(
          leading: const Icon(
            Icons.notifications_active,
            color: Colors.white,
          ),
          title: const Text(
            'Friend Request',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          trailing: Wrap(
            spacing: 0,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(
                  child: Text('${profile.user.requests.length}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            ],
          ),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (_) =>
                    FriendRequestBottomSheet(profile.user.requests));
          },
        ),
      ),
    );
  }
}
