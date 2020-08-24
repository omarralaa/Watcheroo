import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

class FriendPicker extends StatefulWidget {
  final Function submitCallBack;
  final String selectedFriendUsername;

  FriendPicker(this.submitCallBack, this.selectedFriendUsername);

  @override
  _FriendPickerState createState() => _FriendPickerState();
}

class _FriendPickerState extends State<FriendPicker> {
  String dropdownValue;

  @override
  void didChangeDependencies() {
    if (widget.selectedFriendUsername != null) {
      dropdownValue = widget.selectedFriendUsername;
    } else {
      final firstFriendUsername =
          Provider.of<Profile>(context).user.friends[0].username;
      dropdownValue = firstFriendUsername;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Pick a friend',
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        SizedBox(height: 30),
        _buildFriendDropDown(),
        SizedBox(height: 50),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black87,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 35,
            ),
            onTap: () {
              final friend = Provider.of<Profile>(context, listen: false)
                  .getFriendByUsername(dropdownValue);
              widget.submitCallBack(friend);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFriendDropDown() {
    final friendsUsernames = Provider.of<Profile>(context)
        .user
        .friends
        .map((friend) => friend.username)
        .toList();

    return Container(
      width: 200,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.deepPurple,
        ),
        iconSize: 24,
        isExpanded: true,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: friendsUsernames.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
