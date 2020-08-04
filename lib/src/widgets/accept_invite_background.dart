import 'package:flutter/material.dart';

class AcceptInviteBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        return Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
            ),
            Positioned(
              left: - width / 2,
              bottom: height * .1,
              child: Container(
                width: height,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: -width / 2,
              bottom: height * .1,
              child: Container(
                width: height,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[200],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
