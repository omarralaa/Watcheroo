import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/profile.dart';

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
                ClipOval(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),                 
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
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 23.0,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () => _pickAndUploadPhoto(context),
                    ),
                  ],
                ),
              ),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -15.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future<void> _pickAndUploadPhoto(context) async {
    File file = await FilePicker.getFile(type: FileType.image);
    if (file == null) return;
    double sizeInMb = file.lengthSync() / (1024 * 1024);
    if (sizeInMb > 6) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Photo size must not excced 6 MB'),
          duration: Duration(milliseconds: 1500),
        ),
      );
    } else {
      await Provider.of<Profile>(context, listen: false).updatePhoto(file);
    }
  }
}
