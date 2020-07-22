import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

import '../providers/add_friend.dart';

class AddFriendScreen extends StatelessWidget {
  static const routeName = '/add-friend';

  final searchedFriendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Friend',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      // backgroundColor: Colors.amber[200],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              _buildSearchBar(context),
              SizedBox(height: 30),
              _buildFoundFriend(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoundFriend(BuildContext context) {
    return Consumer<AddFriend>(
      builder: (context, addFriend, child) {
        return addFriend.friend == null
            ? SizedBox()
            : Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  width: 500,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      _buildFriendData(context, addFriend.friend),
                      SizedBox(height: 30),
                      _buildAddingButton(context, addFriend.friend),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            labelText: 'Search by username',
            hintText: 'ex: JohnDoe123',
            suffixIcon: Icon(Icons.search),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        controller: searchedFriendController,
        onSubmitted: (val) {
          if (val.trim() != '')
            Provider.of<AddFriend>(context, listen: false)
                .searchFriendByUsername(val);
        },
      ),
    );
  }

  Widget _buildFriendData(BuildContext context, Friend friend) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Text(friend.firstName[0].toUpperCase()),
          radius: 30,
        ),
        SizedBox(height: 10),
        Text(
          '${friend.firstName} ${friend.lastName}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          friend.username,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAddingButton(BuildContext context, Friend friend) {
    final profile = Provider.of<Profile>(context);

    final isFriend = profile.hasFriendbyUsername(friend.username);
    final isRequestSent = profile.hasFriendRequestbyUsername(friend.username);

    return isFriend
        ? Text(
            'This User is already in your Friend List',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).accentColor),
          )
        : isRequestSent
            ? Text(
                'Friend Request Sent',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).accentColor),
              )
            : _buildAddFriendButton(friend, profile);
  }

  Widget _buildAddFriendButton(Friend friend, Profile profile) {
    return Consumer<AddFriend>(
      builder: (context, addFriend, child) {
        return RaisedButton(
          child: Text('Add Friend'),
          color: Colors.amberAccent[200],
          onPressed: addFriend.isLoadingFriendRequest
              ? null
              : () async {
                  final result = await addFriend.sendFriendRequest(friend.id);
                  if (result) profile.addFriendRequest(friend);
                },
        );
      },
    );
  }
}
