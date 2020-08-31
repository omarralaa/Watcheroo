import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/view_profile_screen.dart';
import '../models/friend.dart';
import '../models/party.dart';

class PrevPartyTile extends StatefulWidget {
  final Party party;
  final Friend friend;

  PrevPartyTile(this.party, this.friend);

  @override
  _PrevPartyTileState createState() => _PrevPartyTileState();
}

class _PrevPartyTileState extends State<PrevPartyTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().add_Hm().format(widget.party.createdAt);
    return Column(
      children: <Widget>[
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 12),
            elevation: 2,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(widget.friend.imageUrl),
                  ),
                  title: Text(
                    widget.party.movieName,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2F2E41),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Watched with ${widget.friend.fullName}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text('$date'),
                    ],
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
        ),
        if (_isExpanded)
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${widget.friend.fullName}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'View Details >',
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ViewProfileScreen.routeName,
                        arguments: widget.friend,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
