import 'package:flutter/material.dart';

class ProfilePictureHeader extends StatelessWidget {
  final bool editable;
  final String image;
  final String profileId;

  ProfilePictureHeader({
    @required this.image,
    @required this.editable,
    this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              color: Theme.of(context).backgroundColor,
            ),
            Transform.translate(
              offset: Offset(220.0, -30.0),
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(30 / 360),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.pink,
                ),
              ),
            ),
            Transform.scale(
              scale: 2.0,
              child: Transform.translate(
                offset: Offset(-150.0, -60.0),
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(-30 / 360),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ],
            ),
            if (editable)
              Padding(
                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 25.0,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
