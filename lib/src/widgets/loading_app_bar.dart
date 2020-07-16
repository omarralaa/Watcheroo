import 'package:flutter/material.dart';

class LoadingAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 180,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildLoadingContainer(double.infinity),
          SizedBox(height: 20),
          buildLoadingContainer(120),
          SizedBox(height: 20),
          buildLoadingContainer(70)
        ],
      ),
    );
  }

  Widget buildLoadingContainer(double width) {
    return Container(
      width: width,
      height: 15,
      color: Color.fromRGBO(200, 200, 200, 0.3),
    );
  }
}
