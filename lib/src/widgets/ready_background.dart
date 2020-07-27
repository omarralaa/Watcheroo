import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/ready.dart';

class ReadyBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        return Consumer<Ready>(
            child: Positioned(
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
            builder: (context, ready, child) {
              return Stack(
                children: <Widget>[
                  Container(
                    color: ready.isUserReady
                        ? Theme.of(context).primaryColor
                        : Colors.amberAccent,
                  ),
                  child,
                ],
              );
            });
      },
    );
  }
}
