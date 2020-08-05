import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/friend.dart';
import '../providers/profile.dart';
import '../providers/friends.dart';

class AddFriendScreen extends StatefulWidget {
  static const routeName = '/add-friend';

  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final searchedFriendController = TextEditingController();

  Friend _friend;
  bool _isSearching = false;
  bool _isSendingRequest = false;

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
              _buildSearchBar(),
              SizedBox(height: 30),
              _buildFoundFriend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search by username',
          hintText: 'ex: JohnDoe123',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        enabled: !_isSearching,
        onSubmitted: searchNewFriend,
      ),
    );
  }

  Widget _buildFoundFriend() {
    return _friend == null
        ? _isSearching ? CircularProgressIndicator() : SizedBox()
        : Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              width: 500,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  _buildFriendData(),
                  SizedBox(height: 30),
                  _buildAddingButton(),
                ],
              ),
            ),
          );
  }

  Widget _buildFriendData() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Text(_friend.firstName[0].toUpperCase()),
          radius: 30,
        ),
        SizedBox(height: 10),
        Text(
          '${_friend.firstName} ${_friend.lastName}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          _friend.username,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAddingButton() {
    final profile = Provider.of<Profile>(context);

    final isFriend = profile.hasFriendbyUsername(_friend.username);
    final isRequestSent = profile.hasFriendRequestbyUsername(_friend.username);

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
            : _buildAddFriendButton(profile);
  }

  Widget _buildAddFriendButton(Profile profile) {
    return RaisedButton(
      child: Text('Add Friend'),
      color: Colors.amberAccent[200],
      onPressed: _isSendingRequest
          ? null
          : () async {
              setState(() => _isSendingRequest = true);
              final friends = Provider.of<Friends>(context, listen: false);
              final result = await friends.sendFriendRequest(_friend.id);
              if (result) await profile.getProfile();
              setState(() => _isSendingRequest = false);
            },
    );
  }

  Future<void> searchNewFriend(String val) async {
    if (val.trim() != '') {
      setState(() => _isSearching = true);
      try {
        final friend = await Provider.of<Friends>(context, listen: false)
            .searchFriendByUsername(val);
        setState(() {
          _friend = friend;
          _isSearching = false;
        });
      } catch (err) {
        setState(() {
          _friend = null;
          _isSearching = false;
        });
      }
    }
  }
}
