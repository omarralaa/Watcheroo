import 'package:flutter/material.dart';

class LoadingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 50),
            color: Color.fromRGBO(200, 200, 200, 0.3),
          ),
          SizedBox(height: 10),
          Container(
            width: 50,
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 50),
            color: Color.fromRGBO(200, 200, 200, 0.3),
          ),
        ],
      ),
    );
  }
}
