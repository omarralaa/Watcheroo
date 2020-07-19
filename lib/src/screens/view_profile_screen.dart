import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';
import 'package:watcherooflutter/src/screens/create_party_screen.dart';

import 'package:watcherooflutter/src/widgets/profile_picture_header.dart';

class ViewProfileScreen extends StatelessWidget {
  static const routeName = '/view-profile';

  var viewedProfile;

  @override
  Widget build(BuildContext context) {
    viewedProfile = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          ProfilePictureHeader(
            // TODO: TO BE REPLACED WITH profile.user.image
            image:
                'https://scontent-hbe1-1.xx.fbcdn.net/v/t31.0-8/23926366_370687530042433_140437082163129802_o.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=oGny2YyPpmoAX9KkQB7&_nc_ht=scontent-hbe1-1.xx&oh=9f6a14d3fe329c35f35a9f601f4b3758&oe=5F39DF24',
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
        child: buildViewTogetherButton(),
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

  Widget buildViewTogetherButton() {
    return Consumer<Profile>(builder: (context, profile, _) {
      return RaisedButton(
        padding: EdgeInsets.all(10),
        child: Text('Watch together now!'),
        onPressed: !profile.hasFriendbyUsername(viewedProfile.username) ? null : () {
          Navigator.popAndPushNamed(context, CreatePartyScreen.routeName, arguments: viewedProfile);
        },
      );
    });
  }
}
