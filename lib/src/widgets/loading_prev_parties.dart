import 'package:flutter/material.dart';

class LoadingPrevParties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          return Container(
            width: 250,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Color(0xFFE8E8E8),
          );
        },
      ),
    );
  }
}
