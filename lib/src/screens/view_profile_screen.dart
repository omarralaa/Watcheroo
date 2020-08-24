import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/models/friend.dart';
import 'package:watcherooflutter/src/screens/add_party_screen.dart';

import '../providers/profile.dart';
import '../widgets/profile_picture_header.dart';

class ViewProfileScreen extends StatelessWidget {
  static const routeName = '/view-profile';

  @override
  Widget build(BuildContext context) {
    final viewedProfile = ModalRoute.of(context).settings.arguments as Friend;
    return Scaffold(
      body: Column(
        children: <Widget>[
          ProfilePictureHeader(
            // TODO: TO BE REPLACED WITH profile.user.image
            image:
                viewedProfile.imageUrl,
            editable: false,
          ),
          SizedBox(
            height: 20,
          ),
          buildBody(viewedProfile, context),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: buildViewTogetherButton(viewedProfile),
      ),
    );
  }

  Widget buildBody(profile, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '${profile.firstName} ${profile.lastName}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${profile.username}',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildViewTogetherButton(viewedProfile) {
    return Consumer<Profile>(builder: (context, profile, _) {
      return RaisedButton(
        padding: EdgeInsets.all(10),
        child: Text('Watch together now!'),
        onPressed: !profile.hasFriendbyUsername(viewedProfile.username) ? null : () {
          Navigator.popAndPushNamed(context, AddPartyScreen.routeName, arguments: viewedProfile);
        },
      );
    });
  }
}
