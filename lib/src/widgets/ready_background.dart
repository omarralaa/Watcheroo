import 'package:flutter/material.dart';

class ReadyBackground extends StatelessWidget {
  final bool isUserReady;

  ReadyBackground(this.isUserReady);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;

        return Stack(
          children: <Widget>[
            Container(
              color: isUserReady
                  ? Theme.of(context).primaryColor
                  : Colors.amberAccent,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: height,
                height: height * .98,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
