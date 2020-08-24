import 'dart:math';

import 'package:flutter/material.dart';

class AddPartyBackground extends StatelessWidget {
  final int pageNumber;
  final Color firstColor;
  final Color secondColor;

  AddPartyBackground(this.pageNumber)
      : firstColor = pageNumber == 1 ? Colors.pink : Colors.amberAccent,
        secondColor = pageNumber == 1 ? Colors.amberAccent : Colors.pink;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: firstColor,
        ),
        _buildSecondaryContainer(),
      ],
    );
  }

  Widget _buildSecondaryContainer() {
    return Transform.rotate(
      angle: pi / 4,
      child: Transform.translate(
        offset: const Offset(220, 30),
        child: Container(color: secondColor),
      ),
    );
  }
}
